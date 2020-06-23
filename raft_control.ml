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

module type Raft_control = sig
  type l

  val create : raft_state -> Timer.t -> l

  val run : l -> raft_state Deferred.t
  (*
	val timeout: raft_state -> run_state Deferred.t
	let vote: req:vote_request -> s:raft_state -> (vote_response, raft_state) Deferred.t
  *)
end

type timeout_request = {}
type timeout_response = {}
type init_request = {}
type init_response = {}
type request = [append_entries_request|vote_request|timeout_request|init_request]
type response = [append_entries_response|vote_response|timeout_response|init_response]
type message = { req: request; res: response IVar.t; event: event }

module Raft_control_loop : Raft_control = struct
  type l = {state: raft_state; election_timeout_var: unit Ivar.t Option.t; request_reader: message Reader.t; timeout_r: message Reader.t; timeout_w: message Writer.t }

  let create s t req_read =
  	let r, w = Pipe.create () in
		{state= s; election_timeout_var = Option.None; request_reader = req_read; timeout_r=r; timeout_w = w; }

  let run l =
    let rec loop l =
      let req_choice = Pipe.read_choice l.request_reader in
      let timeout_choice = Pipe.read_choice l.timeout_r in
			choose
      [ req_choice;
				timeout_choice;
      ]
    	>>> function
			| `Ok m ->
				let next_state = process_message l m
				loop(next_state)
			| _ -> printf "Inside control loop. Eof or Nothing available in what? pipe";
				l
		in
		loop(l)

	let start_timeout span w =
		let i = Ivar.create () in
		let cancel_def = Ivar.read i
		in
		Clock.with_timeout span cancel_def
		>>| function
		| `Result () -> print "Timeout cancelled succesfully"
		| `Timeout ->
			if not (Pipe.is_closed w)
      then(
				let message = {req= vote_req, res= i; event=Timeout}
        Pipe.write w message)
		;
		return i

	let reset_timeout i =
		Ivar.fill i ()

  (* takes previous state and message and returns next state*)
  let process_message cur_state m =
    match cur_state.mode with
    | _ ->
      match m.event with
      | `Init ->
        in
				start_timeout (Time.Span.of_sec 0.5) cur_state.timeout_w
      | `VoteRPC ->
				reset_timeout cur_state.election_timeout_var
        let res = Candidate.vote_rpc req cur_state in
        cur_state
      | `Timeout ->
				reset_timeout cur_state.election_timeout_var
        Candidate.handle_timeout printf "timeout expired";
        cur_state
    	| _ ->
        prev_state
end
