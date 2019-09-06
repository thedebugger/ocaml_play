open Base

type raft_mode = Leader|Follower|Candidate

type raft_persistent_state = {
    current_term: int;
    voted_for: int;
    entries: log list;
}

type raft_state = {
    mode : raft_mode;
    per_state: raft_persistent_state;
}

val run: raft_state -> raft_state
