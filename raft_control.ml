open Base
open Async_kernel
open Raft_t
open Core

type raft_mode = Leader | Follower | Candidate

type raft_persistent_state =
  {current_term: int; voted_for: int; entries: log list}

type raft_state = {mode: raft_mode; per_state: raft_persistent_state}

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

module Raft_control_loop : Raft_control = struct
  type l = {state: raft_state; timer: Timer.t}

  let create s t = {state= s; timer= t}

  let run loop =
    let cancel_timeout = Deferred.create (fun i -> Ivar.fill i ()) in
    ignore
      (Timer.start loop.timer cancel_timeout ~on_stop:(fun () ->
           printf "timeout expired" )) ;
    return loop.state
end
