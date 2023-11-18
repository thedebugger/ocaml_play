# Raft implmentation in ocaml for funsies

# Program design
* Server
  1. Input
    a. conf
      1. client rpc interface
      2. server rpc interface
      3. other server addresses
      4. bootstrap_expect
      5. log level
    b. persisted state
      1. logs (location from disk)
      2. currentTerm
      3. votedFor
    c. apis
      1. /kv/put
      2. /kv/get
      3. /kv/delete
      r. /raft/requestvote - request: RequestVoteRequest, response: RequestVoteResponse
      5. /raft/appendenteries - request: AppendEnteriesRequest response: AppendEnteriesResponse
      6. /raft/getenteries ?
  2. Output
    a. persisted state
      1. logs (location from disk)
      2. currentTerm
      3. votedFor
  3. State: (mode, submode, logs, currentTerm, votedFor, candidateId)
  4. Types
    a. mode: (leader|follower|candidate)
    b. currentTerm:
    c. RequestVoteRequest
    d. RequestVoteResponse
    e. submode: (follower
    f. logEntry: index, term, command
  3. Subsystems
    a. Heartbeart and election timeout
    b. RPC
    c. Control loop

# Tasks


# References
* http://blogs.perl.org/users/cyocum/2012/11/writing-state-monads-in-ocaml.html
* http://raftuserstudy.s3-website-us-west-1.amazonaws.com/study/raft.pdf
* https://medium.com/@komamitsu/what-i-learned-from-implementing-raft-consensus-algorithm-in-ocaml-17c71b1b412f
