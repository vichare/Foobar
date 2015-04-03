
module Vichare.JsonDFA(jsonDFA) where
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


transTable = [
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

jsonNumberDFA = DFA 0 transTable [2,3,5,8] (-1)

