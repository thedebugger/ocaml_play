(* This implementation is from
https://github.com/komamitsu/oraft/blob/master/lib/timer.mli
With following chnages
* Removed logger
* Use Aysnc instead of Lwt
*)

open Core
open Async

type t =
  {timeout_millis: int; mutable timeout: Time.t; mutable should_stop: bool}

let span timeout_millis =
  float_of_int ((timeout_millis / 2) + Random.int timeout_millis)
  |> Time.Span.of_ms

let update t = t.timeout <- Time.add (Time.now ()) (span t.timeout_millis)

let start t d ~on_stop =
  Clock.with_timeout (span t.timeout_millis) d
  >>| function `Result () -> () | `Timeout -> on_stop ()

(*
let is_timed_out t = Time.( < ) t.timeout (Time.now ())
let start t ~on_stop =
  let rec check_election_timeout () =
    if is_timed_out t || t.should_stop
    then (
      printf "Election_timer timed out \n" msg ;
      Async.return (on_stop ())
    )
    else Lwt_unix.sleep 0.05 >>= fun () -> check_election_timeout ()
  in
  check_election_timeout ()
*)

let create ~timeout_millis =
  let t =
    { timeout_millis
    ; timeout= Time.add (Time.now ()) (span timeout_millis)
    ; should_stop= false }
  in
  t

let stop t = t.should_stop <- true
