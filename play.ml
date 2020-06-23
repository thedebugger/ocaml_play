open Core
open Cohttp_async
open Async
open Raft_t
open Raft_api
open Raft_control

let filename_param =
  let open Command.Param in
  anon ("filename" %: string)

(*http://dev.realworldocaml.org/command-line-parsing.html#basic-command-line-parsing*)

let client_cmd =
  Command.async ~summary:"client"
    ~readme:(fun () -> "More detailed information")
    (Command.Param.map filename_param ~f:(fun filename () ->
         let req =
           {candidate_id= 1; term= 2; last_long_term= 3; last_long_index= 4}
         in
         try
           Raft_api_client.vote req
           >>| fun res -> printf "filename is %s %d\n" filename res.term
         with e ->
           let msg = Exn.to_string e in
           printf "Exception occured %s \n" msg ;
           return () ))

let server writer =
  let callback ~body _ req =
    let path = req |> Request.uri |> Uri.path in
    match path with
    | "/vote" ->
        Cohttp_async.Body.to_string body
        >>= fun body ->
        let vote_req = Raft_j.vote_request_of_string body in
        Deferred.create (fun i ->
          if not (Pipe.is_closed w)
          then(
            let message = {req: vote_req; res: i; event: `VoteRPC}
            Pipe.write w message)
        )
        >>= fun res ->
        Server.respond_string ~status:`OK (Raft_j.string_of_vote_response res)
    | _ ->
        Server.respond_string ~status:`Not_found
          (Printf.sprintf "Route %s not found" path)
  in
  Server.create ~on_handler_error:`Raise
    (Tcp.Where_to_listen.of_port 8000)
    callback

let run_server _ =
  let timer = Timer.create ~timeout_millis:5000 in
  let r, w = Pipe.create () in
  let l =
    Raft_control_loop.create
      {mode= Follower; per_state= {current_term= 1; voted_for= 2; entries= []}; reader=r}
      timer
  in
  ignore (server w) ;
  ignore (Raft_control_loop.run l) ;
  never_returns (Scheduler.go ())

let server_cmd =
  Command.basic ~summary:"server"
    ~readme:(fun () -> "More detailed information")
    (Command.Param.map filename_param ~f:(fun filename () ->
         run_server filename ))

let command =
  Command.group ~summary:"start playing"
    [("client", client_cmd); ("server", server_cmd)]

let () = Command.run ~version:"1.0" ~build_info:"RWO" command
