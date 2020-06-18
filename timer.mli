(* This implementation is from
https://github.com/komamitsu/oraft/blob/master/lib/timer.mli
*)
open Async

type t

val update : t -> unit

val start : t -> unit Deferred.t -> on_stop:(unit -> unit) -> unit Deferred.t

val create : timeout_millis:int -> t

val stop : t -> unit
