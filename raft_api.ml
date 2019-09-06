open Raft_t

module type Raft_api = sig
    val vote: vote_request -> vote_response
    val append_entries: append_entries_request -> append_entries_response
end

module Raft_api_client: Raft_api = struct
    let append_entries req =
		{term = 1; success = false}

    let vote req =
	  make_request ~body:(Raft_j.string_of_vote_request req)
	  >>| fun string ->
	  (Raft_j.vote_response_of_string string)

	(* https://github.com/mirage/ocaml-cohttp/blob/master/examples/async/s3_cp.ml *)
	let make_request ~body ~host ~meth =
		let uri = Printf.sprintf "http://%s/%s" host meth
				  |> Uri.of_string in
		let time = Time.now () in
		let headers = [] @ [("Host", host)] in
		let request = Request.make ~meth:POST
			~headers:(Header.of_list headers)
			uri in
		let headers = (headers @ auth_header) |> Header.of_list in
		let request = {request with Cohttp.Request.headers} in
		Cohttp_async.Client.request ~body request
	  	>>= fun (_, res_body) ->
		(* TODO: error handling *)
	  	Cohttp_async.Body.to_string res_body
end
