open Raft_t
open Core
open Cohttp
open Async_kernel
open Cohttp_async

module type Raft_api = sig
  val vote : vote_request -> vote_response Deferred.t

  val append_entries : append_entries_request -> append_entries_response
end

module Raft_api_client : Raft_api = struct
  let append_entries _ = {term= 1; success= false}

  (* https://github.com/mirage/ocaml-cohttp/blob/master/examples/async/s3_cp.ml *)
  let make_request ~body ~port ~host ~meth =
    let uri =
      Printf.sprintf "http://%s:%d/%s" host port meth |> Uri.of_string
    in
    let headers =
      [("Content-length", Int.to_string (String.length body))]
      @ [("Host", host)]
    in
    let request =
      Request.make ~meth:`POST ~headers:(Header.of_list headers) uri
    in
    let headers = headers |> Header.of_list in
    let request = {request with Cohttp.Request.headers} in
    let body = Body.of_string body in
    Cohttp_async.Client.request ~body ~uri request
    >>= fun (res, res_body) ->
    match Cohttp.Response.(res.status) with
    | #Code.success_status ->
        Core.Printf.printf "Success from" ;
        Body.to_string res_body
    | _ ->
        Core.Printf.printf "Error: %s\n"
          (Sexp.to_string (Response.sexp_of_t res)) ;
        return ""

  let vote req =
    make_request
      ~body:(Raft_j.string_of_vote_request req)
      ~host:"localhost" ~port:8000 ~meth:"vote"
    >>| fun b -> Raft_j.vote_response_of_string b
end

module Raft_api_server : Raft_api = struct
  let vote _ = return {term= 1; vote_granted= false}

  let append_entries _ = {term= 1; success= false}
end
