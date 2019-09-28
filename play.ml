open Core
open Cohttp
open Cohttp_async
open Async
open Raft_t
open Raft_api

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

let server filename =
  let callback ~body not_used req =
    let address =
      Async_unix__Unix_syscalls.Socket.Address.Inet.to_string not_used
    in
    let uri = req |> Request.uri |> Uri.to_string in
    let meth = req |> Request.meth |> Code.string_of_method in
    let headers = req |> Request.headers |> Header.to_string in
    Cohttp_async.Body.to_string body
    >>| (fun body ->
          Printf.sprintf
            "Uri: %s\n\
             Method: %s\n\
             Headers\n\
             Headers: %s\n\
             Body: %s\n\
             Filename: %s address: %s"
            uri meth headers body filename address )
    >>= fun _ -> Server.respond_string ~status:`OK "works"
  in
  Server.create ~on_handler_error:`Raise
    (Tcp.Where_to_listen.of_port 8000)
    callback

let run_server filename =
  ignore (server filename) ;
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
