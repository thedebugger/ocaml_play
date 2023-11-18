open Base
open Async_kernel
open Raft_t
open Core

module type MONAD = sig
  type 'a t

  val return : 'a -> 'a t

  val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t
end

module type STATE = sig
  type state

  include MONAD

  val get : state t

  val put : state -> unit t

  val runState : 'a t -> init:state -> state * 'a
end

module State (S : sig
  type t
end) : STATE with type state = S.t = struct
  type state = S.t

  type 'a t = state -> state * 'a

  let return v s = (s, v)

  let ( >>= ) m k s =
    let s', a = m s in
    k a s'

  let get s = (s, s)

  let put s' _ = (s', ())

  let runState m ~init = m init
end

module RaftState = State (struct
  type t = raft_state
end)

type request =
  | Append_entries of append_entries_request
  | Vote of vote_request
  | TimeoutReq
  | InitReq

type response =
  | Append_entries of append_entries_response
  | Vote of vote_response
  | TimeoutRes
  | InitRes

type message = {req: request; res: response Ivar.t; event: raft_event}

module type Raft_control = sig
  type l

  val create : raft_state -> Timer.t -> l

  val run : l -> raft_state Deferred.t

  (* optional election timeout ivar *)
  val reset_timeout : unit Ivar.t Option.t -> unit
  val start_timeout : timeout_millis:int -> writer_t:message Pipe.Writer.t -> unit Ivar.t -> unit Deferred.t
  (*
	val timeout: raft_state -> run_state Deferred.t
	let vote: req:vote_request -> s:raft_state -> (vote_response, raft_state) Deferred.t
  *)
end

module Raft_control_loop : Raft_control = struct
  type l =
    { state: raft_state
    ; election_timeout_var: unit Ivar.t Option.t
    ; request_reader: message Pipe.Reader.t
    ; timeout_r: message Pipe.Reader.t
    ; timeout_w:
        message Pipe.Writer.t
        (* pending result of election timeout. it can only be pending if timeout_w has pending pushback deferred*)
    ; election_timeout_res: unit Deferred.t }

  let create s t req_read =
    let r, w = Pipe.create () in
    { state= s
    ; election_timeout_var= None
    ; request_reader= req_read
    ; timeout_r= r
    ; timeout_w= w
    ; election_timeout_res= return () }

  let start_timeout span w cancel_ivar =
    let cancel_def = Ivar.read cancel_ivar in
    Async_unix.Clock.with_timeout span cancel_def
    (* result takes precedence over timeout. not sure how worse is that??? *)
    >>= function
    | `Result _ ->
        printf "Timeout cancelled succesfully" ;
        return ()
    | `Timeout ->
        if not (Pipe.is_closed w) then
          let i = Ivar.create () in
          let message = {req= TimeoutReq; res= i; event= `Timeout} in
          Pipe.write w message
        else (
          printf "WARN: Timeout writer closed??" ;
          return () )

  let reset_timeout i =
    i
    >>= fun ivar ->
    Ivar.fill ivar TimeoutRes

  (* takes previous state and message and returns next state*)
  let process_message cur_state m =
    match cur_state.state.mode with _ -> (
      match m.event with
      | `Init ->
          (*
          let new_election_timeout_res =
            cur_state.election_timeout_res
            >>=
            let i = Ivar.create () in
            start_timeout (Time.Span.of_sec 0.5) cur_state.timeout_w i
          in
          *)
          cur_state
      | `VoteRPC ->
          (* likely race conditions here *)
          reset_timeout cur_state.election_timeout_var ;
          let res = Candidate.vote_rpc req cur_state in
          (* return response back *)
          Ivar.fill m.response res ;
          (* start election timeout only after previous has finished *)
          let new_election_timeout_res =
            cur_state.election_timeout_res
            >>=
            let i = Ivar.create () in
            start_timeout (Time.Span.of_sec 0.5) cur_state.timeout_w i
          in
          cur_state
      | `Timeout ->
          (* can't find any docs to close ivar. so ignore it *)
          Candidate.handle_timeout printf "timeout expired" ;
          (*TODO: change state? start election?*)
          cur_state
      | _ -> cur_state )

  let run l =
    let rec loop l =
      let req_choice = Pipe.read_choice l.request_reader in
      let timeout_choice = Pipe.read_choice l.timeout_r in
      choose [req_choice; timeout_choice]
      >>> function
      | `Ok m ->
          let next_state = process_message l m in
          loop next_state
      | _ ->
          printf "Inside control loop. Eof or Nothing available in what? pipe" ;
          l
    in
    loop l
end
