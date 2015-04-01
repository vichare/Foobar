
-- It's ugly, I'll rewrite this

module Vichare.DFA where
import Debug.Trace

debug = flip trace

type State = Maybe Int

data Match = MatchSingle Char
           | MatchRange Char Char
           | MatchAll
    deriving Show

ifmatch :: Match -> Char -> Bool
ifmatch (MatchSingle key) c = (c == key)
ifmatch (MatchRange k1 k2) c = (c >= k1) && (c <= k2)
ifmatch MatchAll c = True

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
lookupNextStateTable c [] = Nothing
lookupNextStateTable c ((match, state): xs) = if ifmatch match c
    then state
    else lookupNextStateTable c xs


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
        Just table -> case lookupNextStateTable c table of
            Nothing   -> Nothing
            nextState -> parseDFAHelper cs nextState trans
                         `debug` ("State: " ++ show state ++ " --" ++ show c ++ "--> " ++ show nextState) 

--------------------------------------------------------------------
-- test
--------------------------------------------------------------------

alphabetTable :: [Int] -> Char -> NextStateTable
alphabetTable [] startChar = []
alphabetTable (i:is) startChar = ((MatchSingle startChar, Just i) : alphabetTable is (succ startChar))

testInput = "bceadgfcbacbedfadg"

testTransientTable = [
    (Just 0, alphabetTable [0..6] 'a'), 
    (Just 1, alphabetTable [1,3,0,6,4,2,5] 'a'), 
    (Just 2, alphabetTable [2,4,0,1,5,6,3] 'a'), 
    (Just 3, alphabetTable [3,2,5,1,4,0,6] 'a'), 
    (Just 4, alphabetTable [4,1,0,3,6,2,5] 'a'), 
    (Just 5, alphabetTable [5,1,3,4,6,0,2] 'a'), 
    (Just 6, alphabetTable [6,5,1,2,4,3,0] 'a')
    ]

testDFA = DFA (Just 0) testTransientTable [Just 5, Just 6]

result = parseDFA testInput  testDFA



