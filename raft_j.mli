(* Auto-generated from "raft.atd" *)
[@@@ocaml.warning "-27-32-35-39"]

type vote_response = Raft_t.vote_response = { term: int; vote_granted: bool }

type vote_request = Raft_t.vote_request = {
  candidate_id: int;
  term: int;
  last_long_index: int;
  last_long_term: int
}

type log = Raft_t.log = { index: int; term: int; command: string }

type append_entries_response = Raft_t.append_entries_response = {
  term: int;
  success: bool
}

type append_entries_request = Raft_t.append_entries_request = {
  term: int;
  leader_id: int;
  prev_log_index: int;
  prev_log_term: int;
  entries: log list;
  commit_index: int
}

val write_vote_response :
  Bi_outbuf.t -> vote_response -> unit
  (** Output a JSON value of type {!vote_response}. *)

val string_of_vote_response :
  ?len:int -> vote_response -> string
  (** Serialize a value of type {!vote_response}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_vote_response :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> vote_response
  (** Input JSON data of type {!vote_response}. *)

val vote_response_of_string :
  string -> vote_response
  (** Deserialize JSON data of type {!vote_response}. *)

val write_vote_request :
  Bi_outbuf.t -> vote_request -> unit
  (** Output a JSON value of type {!vote_request}. *)

val string_of_vote_request :
  ?len:int -> vote_request -> string
  (** Serialize a value of type {!vote_request}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_vote_request :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> vote_request
  (** Input JSON data of type {!vote_request}. *)

val vote_request_of_string :
  string -> vote_request
  (** Deserialize JSON data of type {!vote_request}. *)

val write_log :
  Bi_outbuf.t -> log -> unit
  (** Output a JSON value of type {!log}. *)

val string_of_log :
  ?len:int -> log -> string
  (** Serialize a value of type {!log}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_log :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> log
  (** Input JSON data of type {!log}. *)

val log_of_string :
  string -> log
  (** Deserialize JSON data of type {!log}. *)

val write_append_entries_response :
  Bi_outbuf.t -> append_entries_response -> unit
  (** Output a JSON value of type {!append_entries_response}. *)

val string_of_append_entries_response :
  ?len:int -> append_entries_response -> string
  (** Serialize a value of type {!append_entries_response}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_append_entries_response :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> append_entries_response
  (** Input JSON data of type {!append_entries_response}. *)

val append_entries_response_of_string :
  string -> append_entries_response
  (** Deserialize JSON data of type {!append_entries_response}. *)

val write_append_entries_request :
  Bi_outbuf.t -> append_entries_request -> unit
  (** Output a JSON value of type {!append_entries_request}. *)

val string_of_append_entries_request :
  ?len:int -> append_entries_request -> string
  (** Serialize a value of type {!append_entries_request}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_append_entries_request :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> append_entries_request
  (** Input JSON data of type {!append_entries_request}. *)

val append_entries_request_of_string :
  string -> append_entries_request
  (** Deserialize JSON data of type {!append_entries_request}. *)

