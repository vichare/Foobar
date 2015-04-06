
module Vichare.JsonDFA(jsonNumberDFA, jsonStringDFA) where
import Vichare.Match
import Vichare.DFA2

s = MatchSingle
r = MatchRange

nstable0 = [
      (s '-', 1)
    , (r '1' '9', 2)
    , (s '0', 3)
    ] :: NextStateTable Int

nstable1 = [
      (r '1' '9', 2)
    , (s '0', 3)
    ]

nstable2 = [
      (r '0' '9', 2)
    , (s '.', 4)
    , (s 'e', 6)
    , (s 'E', 6)
    ]

nstable3 = [
      (s '.', 4)
    , (s 'e', 6)
    , (s 'E', 6)
    ]

nstable4 = [
      (r '0' '9', 5)
    ]

nstable5 = [
      (r '0' '9', 5)
    , (s 'e', 6)
    , (s 'E', 6)
    ]

nstable6 = [
      (r '0' '9', 8)
    , (s '+', 7)
    , (s '-', 7)
    ]

nstable78 = [
      (r '0' '9', 8)
    ]


numberTransTable = [
      (0, nstable0)
    , (1, nstable1)
    , (2, nstable2)
    , (3, nstable3)
    , (4, nstable4)
    , (5, nstable5)
    , (6, nstable6)
    , (7, nstable78)
    , (8, nstable78)
    ]

nsTableChar = [
      (s '\\', 2)
    , (s '\"', 7)
    , (MatchAll, 1)
    ]

nsTableEscape = [
      (s '"', 1)
    , (s '\\', 1)
    , (s '/', 1)
    , (s 'b', 1)
    , (s 'f', 1)
    , (s 'n', 1)
    , (s 'r', 1)
    , (s 't', 1)
    , (s 'u', 3)
    ]

stringTransTable = [
      (0, [(s '"', 1)])
    , (1, nsTableChar)
    , (2, nsTableEscape)
    , (3, [(r 'a' 'f', 4), (r 'A' 'F', 4), (r '0' '9', 4)])
    , (4, [(r 'a' 'f', 5), (r 'A' 'F', 5), (r '0' '9', 5)])
    , (5, [(r 'a' 'f', 6), (r 'A' 'F', 6), (r '0' '9', 6)])
    , (6, [(r 'a' 'f', 1), (r 'A' 'F', 1), (r '0' '9', 1)])
    , (7, [])
    ]

jsonNumberDFA = DFA 0 numberTransTable [2,3,5,8] (-1)
jsonStringDFA = DFA 0 stringTransTable [7] (-1)

