
module Vichare.Match where

data CharMatch = MatchSingle Char
           | MatchRange Char Char
           | MatchAll
    deriving Show

match :: Char -> CharMatch -> Bool
match c (MatchSingle key) = (c == key)
match c (MatchRange k1 k2) = (c >= k1) && (c <= k2)
match c MatchAll = True

