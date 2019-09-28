(* Auto-generated from "raft.atd" *)
[@@@ocaml.warning "-27-32-35-39"]

type vote_response = Raft_t.vote_response = {term: int; vote_granted: bool}

type vote_request = Raft_t.vote_request =
  {candidate_id: int; term: int; last_long_index: int; last_long_term: int}

type log = Raft_t.log = {index: int; term: int; command: string}

type append_entries_response = Raft_t.append_entries_response =
  {term: int; success: bool}

type append_entries_request = Raft_t.append_entries_request =
  { term: int
  ; leader_id: int
  ; prev_log_index: int
  ; prev_log_term: int
  ; entries: log list
  ; commit_index: int }

let write_vote_response : _ -> vote_response -> _ =
 fun ob x ->
  Bi_outbuf.add_char ob '{' ;
  let is_first = ref true in
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"term\":" ;
  Yojson.Safe.write_int ob x.term ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"vote_granted\":" ;
  Yojson.Safe.write_bool ob x.vote_granted ;
  Bi_outbuf.add_char ob '}'

let string_of_vote_response ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_vote_response ob x ; Bi_outbuf.contents ob

let read_vote_response p lb =
  Yojson.Safe.read_space p lb ;
  Yojson.Safe.read_lcurl p lb ;
  let field_term = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_vote_granted = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let bits0 = ref 0 in
  try
    Yojson.Safe.read_space p lb ;
    Yojson.Safe.read_object_end lb ;
    Yojson.Safe.read_space p lb ;
    let f s pos len =
      if pos < 0 || len < 0 || pos + len > String.length s then
        invalid_arg "out-of-bounds substring position or length" ;
      match len with
      | 4 ->
          if
            String.unsafe_get s pos = 't'
            && String.unsafe_get s (pos + 1) = 'e'
            && String.unsafe_get s (pos + 2) = 'r'
            && String.unsafe_get s (pos + 3) = 'm'
          then 0
          else -1
      | 12 ->
          if
            String.unsafe_get s pos = 'v'
            && String.unsafe_get s (pos + 1) = 'o'
            && String.unsafe_get s (pos + 2) = 't'
            && String.unsafe_get s (pos + 3) = 'e'
            && String.unsafe_get s (pos + 4) = '_'
            && String.unsafe_get s (pos + 5) = 'g'
            && String.unsafe_get s (pos + 6) = 'r'
            && String.unsafe_get s (pos + 7) = 'a'
            && String.unsafe_get s (pos + 8) = 'n'
            && String.unsafe_get s (pos + 9) = 't'
            && String.unsafe_get s (pos + 10) = 'e'
            && String.unsafe_get s (pos + 11) = 'd'
          then 1
          else -1
      | _ -> -1
    in
    let i = Yojson.Safe.map_ident p f lb in
    Atdgen_runtime.Oj_run.read_until_field_value p lb ;
    ( match i with
    | 0 ->
        field_term := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x1
    | 1 ->
        field_vote_granted := Atdgen_runtime.Oj_run.read_bool p lb ;
        bits0 := !bits0 lor 0x2
    | _ -> Yojson.Safe.skip_json p lb ) ;
    while true do
      Yojson.Safe.read_space p lb ;
      Yojson.Safe.read_object_sep p lb ;
      Yojson.Safe.read_space p lb ;
      let f s pos len =
        if pos < 0 || len < 0 || pos + len > String.length s then
          invalid_arg "out-of-bounds substring position or length" ;
        match len with
        | 4 ->
            if
              String.unsafe_get s pos = 't'
              && String.unsafe_get s (pos + 1) = 'e'
              && String.unsafe_get s (pos + 2) = 'r'
              && String.unsafe_get s (pos + 3) = 'm'
            then 0
            else -1
        | 12 ->
            if
              String.unsafe_get s pos = 'v'
              && String.unsafe_get s (pos + 1) = 'o'
              && String.unsafe_get s (pos + 2) = 't'
              && String.unsafe_get s (pos + 3) = 'e'
              && String.unsafe_get s (pos + 4) = '_'
              && String.unsafe_get s (pos + 5) = 'g'
              && String.unsafe_get s (pos + 6) = 'r'
              && String.unsafe_get s (pos + 7) = 'a'
              && String.unsafe_get s (pos + 8) = 'n'
              && String.unsafe_get s (pos + 9) = 't'
              && String.unsafe_get s (pos + 10) = 'e'
              && String.unsafe_get s (pos + 11) = 'd'
            then 1
            else -1
        | _ -> -1
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb ;
      match i with
      | 0 ->
          field_term := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x1
      | 1 ->
          field_vote_granted := Atdgen_runtime.Oj_run.read_bool p lb ;
          bits0 := !bits0 lor 0x2
      | _ -> Yojson.Safe.skip_json p lb
    done ;
    assert false
  with Yojson.End_of_object ->
    if !bits0 <> 0x3 then
      Atdgen_runtime.Oj_run.missing_fields p [|!bits0|]
        [|"term"; "vote_granted"|] ;
    ({term= !field_term; vote_granted= !field_vote_granted} : vote_response)

let vote_response_of_string s =
  read_vote_response (Yojson.Safe.init_lexer ()) (Lexing.from_string s)

let write_vote_request : _ -> vote_request -> _ =
 fun ob x ->
  Bi_outbuf.add_char ob '{' ;
  let is_first = ref true in
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"candidate_id\":" ;
  Yojson.Safe.write_int ob x.candidate_id ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"term\":" ;
  Yojson.Safe.write_int ob x.term ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"last_long_index\":" ;
  Yojson.Safe.write_int ob x.last_long_index ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"last_long_term\":" ;
  Yojson.Safe.write_int ob x.last_long_term ;
  Bi_outbuf.add_char ob '}'

let string_of_vote_request ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_vote_request ob x ; Bi_outbuf.contents ob

let read_vote_request p lb =
  Yojson.Safe.read_space p lb ;
  Yojson.Safe.read_lcurl p lb ;
  let field_candidate_id = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_term = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_last_long_index = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_last_long_term = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let bits0 = ref 0 in
  try
    Yojson.Safe.read_space p lb ;
    Yojson.Safe.read_object_end lb ;
    Yojson.Safe.read_space p lb ;
    let f s pos len =
      if pos < 0 || len < 0 || pos + len > String.length s then
        invalid_arg "out-of-bounds substring position or length" ;
      match len with
      | 4 ->
          if
            String.unsafe_get s pos = 't'
            && String.unsafe_get s (pos + 1) = 'e'
            && String.unsafe_get s (pos + 2) = 'r'
            && String.unsafe_get s (pos + 3) = 'm'
          then 1
          else -1
      | 12 ->
          if
            String.unsafe_get s pos = 'c'
            && String.unsafe_get s (pos + 1) = 'a'
            && String.unsafe_get s (pos + 2) = 'n'
            && String.unsafe_get s (pos + 3) = 'd'
            && String.unsafe_get s (pos + 4) = 'i'
            && String.unsafe_get s (pos + 5) = 'd'
            && String.unsafe_get s (pos + 6) = 'a'
            && String.unsafe_get s (pos + 7) = 't'
            && String.unsafe_get s (pos + 8) = 'e'
            && String.unsafe_get s (pos + 9) = '_'
            && String.unsafe_get s (pos + 10) = 'i'
            && String.unsafe_get s (pos + 11) = 'd'
          then 0
          else -1
      | 14 ->
          if
            String.unsafe_get s pos = 'l'
            && String.unsafe_get s (pos + 1) = 'a'
            && String.unsafe_get s (pos + 2) = 's'
            && String.unsafe_get s (pos + 3) = 't'
            && String.unsafe_get s (pos + 4) = '_'
            && String.unsafe_get s (pos + 5) = 'l'
            && String.unsafe_get s (pos + 6) = 'o'
            && String.unsafe_get s (pos + 7) = 'n'
            && String.unsafe_get s (pos + 8) = 'g'
            && String.unsafe_get s (pos + 9) = '_'
            && String.unsafe_get s (pos + 10) = 't'
            && String.unsafe_get s (pos + 11) = 'e'
            && String.unsafe_get s (pos + 12) = 'r'
            && String.unsafe_get s (pos + 13) = 'm'
          then 3
          else -1
      | 15 ->
          if
            String.unsafe_get s pos = 'l'
            && String.unsafe_get s (pos + 1) = 'a'
            && String.unsafe_get s (pos + 2) = 's'
            && String.unsafe_get s (pos + 3) = 't'
            && String.unsafe_get s (pos + 4) = '_'
            && String.unsafe_get s (pos + 5) = 'l'
            && String.unsafe_get s (pos + 6) = 'o'
            && String.unsafe_get s (pos + 7) = 'n'
            && String.unsafe_get s (pos + 8) = 'g'
            && String.unsafe_get s (pos + 9) = '_'
            && String.unsafe_get s (pos + 10) = 'i'
            && String.unsafe_get s (pos + 11) = 'n'
            && String.unsafe_get s (pos + 12) = 'd'
            && String.unsafe_get s (pos + 13) = 'e'
            && String.unsafe_get s (pos + 14) = 'x'
          then 2
          else -1
      | _ -> -1
    in
    let i = Yojson.Safe.map_ident p f lb in
    Atdgen_runtime.Oj_run.read_until_field_value p lb ;
    ( match i with
    | 0 ->
        field_candidate_id := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x1
    | 1 ->
        field_term := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x2
    | 2 ->
        field_last_long_index := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x4
    | 3 ->
        field_last_long_term := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x8
    | _ -> Yojson.Safe.skip_json p lb ) ;
    while true do
      Yojson.Safe.read_space p lb ;
      Yojson.Safe.read_object_sep p lb ;
      Yojson.Safe.read_space p lb ;
      let f s pos len =
        if pos < 0 || len < 0 || pos + len > String.length s then
          invalid_arg "out-of-bounds substring position or length" ;
        match len with
        | 4 ->
            if
              String.unsafe_get s pos = 't'
              && String.unsafe_get s (pos + 1) = 'e'
              && String.unsafe_get s (pos + 2) = 'r'
              && String.unsafe_get s (pos + 3) = 'm'
            then 1
            else -1
        | 12 ->
            if
              String.unsafe_get s pos = 'c'
              && String.unsafe_get s (pos + 1) = 'a'
              && String.unsafe_get s (pos + 2) = 'n'
              && String.unsafe_get s (pos + 3) = 'd'
              && String.unsafe_get s (pos + 4) = 'i'
              && String.unsafe_get s (pos + 5) = 'd'
              && String.unsafe_get s (pos + 6) = 'a'
              && String.unsafe_get s (pos + 7) = 't'
              && String.unsafe_get s (pos + 8) = 'e'
              && String.unsafe_get s (pos + 9) = '_'
              && String.unsafe_get s (pos + 10) = 'i'
              && String.unsafe_get s (pos + 11) = 'd'
            then 0
            else -1
        | 14 ->
            if
              String.unsafe_get s pos = 'l'
              && String.unsafe_get s (pos + 1) = 'a'
              && String.unsafe_get s (pos + 2) = 's'
              && String.unsafe_get s (pos + 3) = 't'
              && String.unsafe_get s (pos + 4) = '_'
              && String.unsafe_get s (pos + 5) = 'l'
              && String.unsafe_get s (pos + 6) = 'o'
              && String.unsafe_get s (pos + 7) = 'n'
              && String.unsafe_get s (pos + 8) = 'g'
              && String.unsafe_get s (pos + 9) = '_'
              && String.unsafe_get s (pos + 10) = 't'
              && String.unsafe_get s (pos + 11) = 'e'
              && String.unsafe_get s (pos + 12) = 'r'
              && String.unsafe_get s (pos + 13) = 'm'
            then 3
            else -1
        | 15 ->
            if
              String.unsafe_get s pos = 'l'
              && String.unsafe_get s (pos + 1) = 'a'
              && String.unsafe_get s (pos + 2) = 's'
              && String.unsafe_get s (pos + 3) = 't'
              && String.unsafe_get s (pos + 4) = '_'
              && String.unsafe_get s (pos + 5) = 'l'
              && String.unsafe_get s (pos + 6) = 'o'
              && String.unsafe_get s (pos + 7) = 'n'
              && String.unsafe_get s (pos + 8) = 'g'
              && String.unsafe_get s (pos + 9) = '_'
              && String.unsafe_get s (pos + 10) = 'i'
              && String.unsafe_get s (pos + 11) = 'n'
              && String.unsafe_get s (pos + 12) = 'd'
              && String.unsafe_get s (pos + 13) = 'e'
              && String.unsafe_get s (pos + 14) = 'x'
            then 2
            else -1
        | _ -> -1
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb ;
      match i with
      | 0 ->
          field_candidate_id := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x1
      | 1 ->
          field_term := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x2
      | 2 ->
          field_last_long_index := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x4
      | 3 ->
          field_last_long_term := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x8
      | _ -> Yojson.Safe.skip_json p lb
    done ;
    assert false
  with Yojson.End_of_object ->
    if !bits0 <> 0xf then
      Atdgen_runtime.Oj_run.missing_fields p [|!bits0|]
        [|"candidate_id"; "term"; "last_long_index"; "last_long_term"|] ;
    ( { candidate_id= !field_candidate_id
      ; term= !field_term
      ; last_long_index= !field_last_long_index
      ; last_long_term= !field_last_long_term }
      : vote_request )

let vote_request_of_string s =
  read_vote_request (Yojson.Safe.init_lexer ()) (Lexing.from_string s)

let write_log : _ -> log -> _ =
 fun ob x ->
  Bi_outbuf.add_char ob '{' ;
  let is_first = ref true in
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"index\":" ;
  Yojson.Safe.write_int ob x.index ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"term\":" ;
  Yojson.Safe.write_int ob x.term ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"command\":" ;
  Yojson.Safe.write_string ob x.command ;
  Bi_outbuf.add_char ob '}'

let string_of_log ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_log ob x ; Bi_outbuf.contents ob

let read_log p lb =
  Yojson.Safe.read_space p lb ;
  Yojson.Safe.read_lcurl p lb ;
  let field_index = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_term = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_command = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let bits0 = ref 0 in
  try
    Yojson.Safe.read_space p lb ;
    Yojson.Safe.read_object_end lb ;
    Yojson.Safe.read_space p lb ;
    let f s pos len =
      if pos < 0 || len < 0 || pos + len > String.length s then
        invalid_arg "out-of-bounds substring position or length" ;
      match len with
      | 4 ->
          if
            String.unsafe_get s pos = 't'
            && String.unsafe_get s (pos + 1) = 'e'
            && String.unsafe_get s (pos + 2) = 'r'
            && String.unsafe_get s (pos + 3) = 'm'
          then 1
          else -1
      | 5 ->
          if
            String.unsafe_get s pos = 'i'
            && String.unsafe_get s (pos + 1) = 'n'
            && String.unsafe_get s (pos + 2) = 'd'
            && String.unsafe_get s (pos + 3) = 'e'
            && String.unsafe_get s (pos + 4) = 'x'
          then 0
          else -1
      | 7 ->
          if
            String.unsafe_get s pos = 'c'
            && String.unsafe_get s (pos + 1) = 'o'
            && String.unsafe_get s (pos + 2) = 'm'
            && String.unsafe_get s (pos + 3) = 'm'
            && String.unsafe_get s (pos + 4) = 'a'
            && String.unsafe_get s (pos + 5) = 'n'
            && String.unsafe_get s (pos + 6) = 'd'
          then 2
          else -1
      | _ -> -1
    in
    let i = Yojson.Safe.map_ident p f lb in
    Atdgen_runtime.Oj_run.read_until_field_value p lb ;
    ( match i with
    | 0 ->
        field_index := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x1
    | 1 ->
        field_term := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x2
    | 2 ->
        field_command := Atdgen_runtime.Oj_run.read_string p lb ;
        bits0 := !bits0 lor 0x4
    | _ -> Yojson.Safe.skip_json p lb ) ;
    while true do
      Yojson.Safe.read_space p lb ;
      Yojson.Safe.read_object_sep p lb ;
      Yojson.Safe.read_space p lb ;
      let f s pos len =
        if pos < 0 || len < 0 || pos + len > String.length s then
          invalid_arg "out-of-bounds substring position or length" ;
        match len with
        | 4 ->
            if
              String.unsafe_get s pos = 't'
              && String.unsafe_get s (pos + 1) = 'e'
              && String.unsafe_get s (pos + 2) = 'r'
              && String.unsafe_get s (pos + 3) = 'm'
            then 1
            else -1
        | 5 ->
            if
              String.unsafe_get s pos = 'i'
              && String.unsafe_get s (pos + 1) = 'n'
              && String.unsafe_get s (pos + 2) = 'd'
              && String.unsafe_get s (pos + 3) = 'e'
              && String.unsafe_get s (pos + 4) = 'x'
            then 0
            else -1
        | 7 ->
            if
              String.unsafe_get s pos = 'c'
              && String.unsafe_get s (pos + 1) = 'o'
              && String.unsafe_get s (pos + 2) = 'm'
              && String.unsafe_get s (pos + 3) = 'm'
              && String.unsafe_get s (pos + 4) = 'a'
              && String.unsafe_get s (pos + 5) = 'n'
              && String.unsafe_get s (pos + 6) = 'd'
            then 2
            else -1
        | _ -> -1
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb ;
      match i with
      | 0 ->
          field_index := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x1
      | 1 ->
          field_term := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x2
      | 2 ->
          field_command := Atdgen_runtime.Oj_run.read_string p lb ;
          bits0 := !bits0 lor 0x4
      | _ -> Yojson.Safe.skip_json p lb
    done ;
    assert false
  with Yojson.End_of_object ->
    if !bits0 <> 0x7 then
      Atdgen_runtime.Oj_run.missing_fields p [|!bits0|]
        [|"index"; "term"; "command"|] ;
    ({index= !field_index; term= !field_term; command= !field_command} : log)

let log_of_string s =
  read_log (Yojson.Safe.init_lexer ()) (Lexing.from_string s)

let write_append_entries_response : _ -> append_entries_response -> _ =
 fun ob x ->
  Bi_outbuf.add_char ob '{' ;
  let is_first = ref true in
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"term\":" ;
  Yojson.Safe.write_int ob x.term ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"success\":" ;
  Yojson.Safe.write_bool ob x.success ;
  Bi_outbuf.add_char ob '}'

let string_of_append_entries_response ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_append_entries_response ob x ;
  Bi_outbuf.contents ob

let read_append_entries_response p lb =
  Yojson.Safe.read_space p lb ;
  Yojson.Safe.read_lcurl p lb ;
  let field_term = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_success = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let bits0 = ref 0 in
  try
    Yojson.Safe.read_space p lb ;
    Yojson.Safe.read_object_end lb ;
    Yojson.Safe.read_space p lb ;
    let f s pos len =
      if pos < 0 || len < 0 || pos + len > String.length s then
        invalid_arg "out-of-bounds substring position or length" ;
      match len with
      | 4 ->
          if
            String.unsafe_get s pos = 't'
            && String.unsafe_get s (pos + 1) = 'e'
            && String.unsafe_get s (pos + 2) = 'r'
            && String.unsafe_get s (pos + 3) = 'm'
          then 0
          else -1
      | 7 ->
          if
            String.unsafe_get s pos = 's'
            && String.unsafe_get s (pos + 1) = 'u'
            && String.unsafe_get s (pos + 2) = 'c'
            && String.unsafe_get s (pos + 3) = 'c'
            && String.unsafe_get s (pos + 4) = 'e'
            && String.unsafe_get s (pos + 5) = 's'
            && String.unsafe_get s (pos + 6) = 's'
          then 1
          else -1
      | _ -> -1
    in
    let i = Yojson.Safe.map_ident p f lb in
    Atdgen_runtime.Oj_run.read_until_field_value p lb ;
    ( match i with
    | 0 ->
        field_term := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x1
    | 1 ->
        field_success := Atdgen_runtime.Oj_run.read_bool p lb ;
        bits0 := !bits0 lor 0x2
    | _ -> Yojson.Safe.skip_json p lb ) ;
    while true do
      Yojson.Safe.read_space p lb ;
      Yojson.Safe.read_object_sep p lb ;
      Yojson.Safe.read_space p lb ;
      let f s pos len =
        if pos < 0 || len < 0 || pos + len > String.length s then
          invalid_arg "out-of-bounds substring position or length" ;
        match len with
        | 4 ->
            if
              String.unsafe_get s pos = 't'
              && String.unsafe_get s (pos + 1) = 'e'
              && String.unsafe_get s (pos + 2) = 'r'
              && String.unsafe_get s (pos + 3) = 'm'
            then 0
            else -1
        | 7 ->
            if
              String.unsafe_get s pos = 's'
              && String.unsafe_get s (pos + 1) = 'u'
              && String.unsafe_get s (pos + 2) = 'c'
              && String.unsafe_get s (pos + 3) = 'c'
              && String.unsafe_get s (pos + 4) = 'e'
              && String.unsafe_get s (pos + 5) = 's'
              && String.unsafe_get s (pos + 6) = 's'
            then 1
            else -1
        | _ -> -1
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb ;
      match i with
      | 0 ->
          field_term := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x1
      | 1 ->
          field_success := Atdgen_runtime.Oj_run.read_bool p lb ;
          bits0 := !bits0 lor 0x2
      | _ -> Yojson.Safe.skip_json p lb
    done ;
    assert false
  with Yojson.End_of_object ->
    if !bits0 <> 0x3 then
      Atdgen_runtime.Oj_run.missing_fields p [|!bits0|] [|"term"; "success"|] ;
    ({term= !field_term; success= !field_success} : append_entries_response)

let append_entries_response_of_string s =
  read_append_entries_response
    (Yojson.Safe.init_lexer ())
    (Lexing.from_string s)

let write__1 = Atdgen_runtime.Oj_run.write_list write_log

let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x ; Bi_outbuf.contents ob

let read__1 = Atdgen_runtime.Oj_run.read_list read_log

let _1_of_string s = read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)

let write_append_entries_request : _ -> append_entries_request -> _ =
 fun ob x ->
  Bi_outbuf.add_char ob '{' ;
  let is_first = ref true in
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"term\":" ;
  Yojson.Safe.write_int ob x.term ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"leader_id\":" ;
  Yojson.Safe.write_int ob x.leader_id ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"prev_log_index\":" ;
  Yojson.Safe.write_int ob x.prev_log_index ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"prev_log_term\":" ;
  Yojson.Safe.write_int ob x.prev_log_term ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"entries\":" ;
  write__1 ob x.entries ;
  if !is_first then is_first := false else Bi_outbuf.add_char ob ',' ;
  Bi_outbuf.add_string ob "\"commit_index\":" ;
  Yojson.Safe.write_int ob x.commit_index ;
  Bi_outbuf.add_char ob '}'

let string_of_append_entries_request ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_append_entries_request ob x ;
  Bi_outbuf.contents ob

let read_append_entries_request p lb =
  Yojson.Safe.read_space p lb ;
  Yojson.Safe.read_lcurl p lb ;
  let field_term = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_leader_id = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_prev_log_index = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_prev_log_term = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_entries = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let field_commit_index = ref (Obj.magic (Sys.opaque_identity 0.0)) in
  let bits0 = ref 0 in
  try
    Yojson.Safe.read_space p lb ;
    Yojson.Safe.read_object_end lb ;
    Yojson.Safe.read_space p lb ;
    let f s pos len =
      if pos < 0 || len < 0 || pos + len > String.length s then
        invalid_arg "out-of-bounds substring position or length" ;
      match len with
      | 4 ->
          if
            String.unsafe_get s pos = 't'
            && String.unsafe_get s (pos + 1) = 'e'
            && String.unsafe_get s (pos + 2) = 'r'
            && String.unsafe_get s (pos + 3) = 'm'
          then 0
          else -1
      | 7 ->
          if
            String.unsafe_get s pos = 'e'
            && String.unsafe_get s (pos + 1) = 'n'
            && String.unsafe_get s (pos + 2) = 't'
            && String.unsafe_get s (pos + 3) = 'r'
            && String.unsafe_get s (pos + 4) = 'i'
            && String.unsafe_get s (pos + 5) = 'e'
            && String.unsafe_get s (pos + 6) = 's'
          then 4
          else -1
      | 9 ->
          if
            String.unsafe_get s pos = 'l'
            && String.unsafe_get s (pos + 1) = 'e'
            && String.unsafe_get s (pos + 2) = 'a'
            && String.unsafe_get s (pos + 3) = 'd'
            && String.unsafe_get s (pos + 4) = 'e'
            && String.unsafe_get s (pos + 5) = 'r'
            && String.unsafe_get s (pos + 6) = '_'
            && String.unsafe_get s (pos + 7) = 'i'
            && String.unsafe_get s (pos + 8) = 'd'
          then 1
          else -1
      | 12 ->
          if
            String.unsafe_get s pos = 'c'
            && String.unsafe_get s (pos + 1) = 'o'
            && String.unsafe_get s (pos + 2) = 'm'
            && String.unsafe_get s (pos + 3) = 'm'
            && String.unsafe_get s (pos + 4) = 'i'
            && String.unsafe_get s (pos + 5) = 't'
            && String.unsafe_get s (pos + 6) = '_'
            && String.unsafe_get s (pos + 7) = 'i'
            && String.unsafe_get s (pos + 8) = 'n'
            && String.unsafe_get s (pos + 9) = 'd'
            && String.unsafe_get s (pos + 10) = 'e'
            && String.unsafe_get s (pos + 11) = 'x'
          then 5
          else -1
      | 13 ->
          if
            String.unsafe_get s pos = 'p'
            && String.unsafe_get s (pos + 1) = 'r'
            && String.unsafe_get s (pos + 2) = 'e'
            && String.unsafe_get s (pos + 3) = 'v'
            && String.unsafe_get s (pos + 4) = '_'
            && String.unsafe_get s (pos + 5) = 'l'
            && String.unsafe_get s (pos + 6) = 'o'
            && String.unsafe_get s (pos + 7) = 'g'
            && String.unsafe_get s (pos + 8) = '_'
            && String.unsafe_get s (pos + 9) = 't'
            && String.unsafe_get s (pos + 10) = 'e'
            && String.unsafe_get s (pos + 11) = 'r'
            && String.unsafe_get s (pos + 12) = 'm'
          then 3
          else -1
      | 14 ->
          if
            String.unsafe_get s pos = 'p'
            && String.unsafe_get s (pos + 1) = 'r'
            && String.unsafe_get s (pos + 2) = 'e'
            && String.unsafe_get s (pos + 3) = 'v'
            && String.unsafe_get s (pos + 4) = '_'
            && String.unsafe_get s (pos + 5) = 'l'
            && String.unsafe_get s (pos + 6) = 'o'
            && String.unsafe_get s (pos + 7) = 'g'
            && String.unsafe_get s (pos + 8) = '_'
            && String.unsafe_get s (pos + 9) = 'i'
            && String.unsafe_get s (pos + 10) = 'n'
            && String.unsafe_get s (pos + 11) = 'd'
            && String.unsafe_get s (pos + 12) = 'e'
            && String.unsafe_get s (pos + 13) = 'x'
          then 2
          else -1
      | _ -> -1
    in
    let i = Yojson.Safe.map_ident p f lb in
    Atdgen_runtime.Oj_run.read_until_field_value p lb ;
    ( match i with
    | 0 ->
        field_term := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x1
    | 1 ->
        field_leader_id := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x2
    | 2 ->
        field_prev_log_index := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x4
    | 3 ->
        field_prev_log_term := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x8
    | 4 ->
        field_entries := read__1 p lb ;
        bits0 := !bits0 lor 0x10
    | 5 ->
        field_commit_index := Atdgen_runtime.Oj_run.read_int p lb ;
        bits0 := !bits0 lor 0x20
    | _ -> Yojson.Safe.skip_json p lb ) ;
    while true do
      Yojson.Safe.read_space p lb ;
      Yojson.Safe.read_object_sep p lb ;
      Yojson.Safe.read_space p lb ;
      let f s pos len =
        if pos < 0 || len < 0 || pos + len > String.length s then
          invalid_arg "out-of-bounds substring position or length" ;
        match len with
        | 4 ->
            if
              String.unsafe_get s pos = 't'
              && String.unsafe_get s (pos + 1) = 'e'
              && String.unsafe_get s (pos + 2) = 'r'
              && String.unsafe_get s (pos + 3) = 'm'
            then 0
            else -1
        | 7 ->
            if
              String.unsafe_get s pos = 'e'
              && String.unsafe_get s (pos + 1) = 'n'
              && String.unsafe_get s (pos + 2) = 't'
              && String.unsafe_get s (pos + 3) = 'r'
              && String.unsafe_get s (pos + 4) = 'i'
              && String.unsafe_get s (pos + 5) = 'e'
              && String.unsafe_get s (pos + 6) = 's'
            then 4
            else -1
        | 9 ->
            if
              String.unsafe_get s pos = 'l'
              && String.unsafe_get s (pos + 1) = 'e'
              && String.unsafe_get s (pos + 2) = 'a'
              && String.unsafe_get s (pos + 3) = 'd'
              && String.unsafe_get s (pos + 4) = 'e'
              && String.unsafe_get s (pos + 5) = 'r'
              && String.unsafe_get s (pos + 6) = '_'
              && String.unsafe_get s (pos + 7) = 'i'
              && String.unsafe_get s (pos + 8) = 'd'
            then 1
            else -1
        | 12 ->
            if
              String.unsafe_get s pos = 'c'
              && String.unsafe_get s (pos + 1) = 'o'
              && String.unsafe_get s (pos + 2) = 'm'
              && String.unsafe_get s (pos + 3) = 'm'
              && String.unsafe_get s (pos + 4) = 'i'
              && String.unsafe_get s (pos + 5) = 't'
              && String.unsafe_get s (pos + 6) = '_'
              && String.unsafe_get s (pos + 7) = 'i'
              && String.unsafe_get s (pos + 8) = 'n'
              && String.unsafe_get s (pos + 9) = 'd'
              && String.unsafe_get s (pos + 10) = 'e'
              && String.unsafe_get s (pos + 11) = 'x'
            then 5
            else -1
        | 13 ->
            if
              String.unsafe_get s pos = 'p'
              && String.unsafe_get s (pos + 1) = 'r'
              && String.unsafe_get s (pos + 2) = 'e'
              && String.unsafe_get s (pos + 3) = 'v'
              && String.unsafe_get s (pos + 4) = '_'
              && String.unsafe_get s (pos + 5) = 'l'
              && String.unsafe_get s (pos + 6) = 'o'
              && String.unsafe_get s (pos + 7) = 'g'
              && String.unsafe_get s (pos + 8) = '_'
              && String.unsafe_get s (pos + 9) = 't'
              && String.unsafe_get s (pos + 10) = 'e'
              && String.unsafe_get s (pos + 11) = 'r'
              && String.unsafe_get s (pos + 12) = 'm'
            then 3
            else -1
        | 14 ->
            if
              String.unsafe_get s pos = 'p'
              && String.unsafe_get s (pos + 1) = 'r'
              && String.unsafe_get s (pos + 2) = 'e'
              && String.unsafe_get s (pos + 3) = 'v'
              && String.unsafe_get s (pos + 4) = '_'
              && String.unsafe_get s (pos + 5) = 'l'
              && String.unsafe_get s (pos + 6) = 'o'
              && String.unsafe_get s (pos + 7) = 'g'
              && String.unsafe_get s (pos + 8) = '_'
              && String.unsafe_get s (pos + 9) = 'i'
              && String.unsafe_get s (pos + 10) = 'n'
              && String.unsafe_get s (pos + 11) = 'd'
              && String.unsafe_get s (pos + 12) = 'e'
              && String.unsafe_get s (pos + 13) = 'x'
            then 2
            else -1
        | _ -> -1
      in
      let i = Yojson.Safe.map_ident p f lb in
      Atdgen_runtime.Oj_run.read_until_field_value p lb ;
      match i with
      | 0 ->
          field_term := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x1
      | 1 ->
          field_leader_id := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x2
      | 2 ->
          field_prev_log_index := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x4
      | 3 ->
          field_prev_log_term := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x8
      | 4 ->
          field_entries := read__1 p lb ;
          bits0 := !bits0 lor 0x10
      | 5 ->
          field_commit_index := Atdgen_runtime.Oj_run.read_int p lb ;
          bits0 := !bits0 lor 0x20
      | _ -> Yojson.Safe.skip_json p lb
    done ;
    assert false
  with Yojson.End_of_object ->
    if !bits0 <> 0x3f then
      Atdgen_runtime.Oj_run.missing_fields p [|!bits0|]
        [| "term"
         ; "leader_id"
         ; "prev_log_index"
         ; "prev_log_term"
         ; "entries"
         ; "commit_index" |] ;
    ( { term= !field_term
      ; leader_id= !field_leader_id
      ; prev_log_index= !field_prev_log_index
      ; prev_log_term= !field_prev_log_term
      ; entries= !field_entries
      ; commit_index= !field_commit_index }
      : append_entries_request )

let append_entries_request_of_string s =
  read_append_entries_request
    (Yojson.Safe.init_lexer ())
    (Lexing.from_string s)
