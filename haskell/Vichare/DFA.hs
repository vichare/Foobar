
module Vichare.DFA where

type State = Maybe Int

data Match = MatchSingle Char
           | MatchRange Char Char
    deriving Show

ifmatch :: Match -> Char -> Bool
ifmatch (MatchSingle key) c = (c == key)
ifmatch (MatchRange k1 k2) c = (c >= k1) && (c <= k2)

{-
list = [
    (MatchSingle 'a', 'a'),
    (MatchSingle 'a', 'b'),
    (MatchSingle 'a', 'A'),
    (MatchRange 'a' 'z', 'c'),
    (MatchRange 'a' 'z', 'a'),
    (MatchRange 'a' 'z', 'z'),
    (MatchRange 'a' 'z', 'A'),
    (MatchRange 'a' 'z', '0')
    ]

result = [True,False,False,True,True,True,False,False]
testPassed = result == (fmap (uncurry ifmatch) list)
 -}

type NextStateTable = [(Match, State)]

lookupNextStateTable :: Char -> NextStateTable -> State
lookupNextStateTable c table = case lookup c table of
    Nothing -> Nothing
    Just s  -> s

type TransientTable = [(State, NextStateTable)]

data DFA = DFA {
      startState    :: State
    , transTable    :: TransientTable
    , finalStates   :: [State]
    } deriving Show

parseDFA :: [Char] -> DFA -> Bool
parseDFA str (DFA start trans finals) = (parseDFAHelper str start trans) `elem` finals

parseDFAHelper :: [Char] -> State -> TransientTable -> State
parseDFAHelper [] state _ = state
parseDFAHelper _ Nothing _ = Nothing
parseDFAHelper (c:cs) state trans = 
    case lookup state trans of
        Nothing    -> Nothing
        Just table -> case --lookup state table of
                          --Nothing        -> Nothing
                          --Just nextState -> parseDFAHelper cs nextState table

-- elem
