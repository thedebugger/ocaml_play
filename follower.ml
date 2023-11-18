open Raft_t

module Follower : sig
  val append_enteries :
    append_entries_request -> raft_state -> append_entries_response

  val vote_rpc : vote_request -> raft_state -> vote_response
end = struct
  let vote_rpc req _ = {term= 1; vote_granted= false}

  let append_entries req _ = {term= 1; success= false}
end
