(* Auto-generated from "raft.atd" *)
[@@@ocaml.warning "-27-32-35-39"]

type vote_response = {term: int; vote_granted: bool}

type vote_request =
  {candidate_id: int; term: int; last_long_index: int; last_long_term: int}

type log = {index: int; term: int; command: string}

type append_entries_response = {term: int; success: bool}

type append_entries_request =
  { term: int
  ; leader_id: int
  ; prev_log_index: int
  ; prev_log_term: int
  ; entries: log list
  ; commit_index: int }
