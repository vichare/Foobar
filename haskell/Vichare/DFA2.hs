
-- still not good, just use this

module Vichare.DFA2 where
import Vichare.Match

type NextStateTable state = [(CharMatch, state)]
type TransientTable state = [(state, NextStateTable state)]

data DFA state = DFA {
      start_state   :: state
    , trans_table   :: TransientTable state
    , final_states  :: [state]
    , error_state   :: state
    } deriving Show

lookup_next_state_table :: NextStateTable state -> Char -> state -> state
--lookup_next_state_table [] c = error ("No match for char \'" ++ (show c) ++ "\'")
lookup_next_state_table [] c errorState = errorState
lookup_next_state_table ((m, nextState): xs) c errorState = if c `match` m
    then nextState
    else lookup_next_state_table xs c errorState

next_state :: (Eq state, Show state) => TransientTable state -> state -> Char -> state -> state
next_state transTable currentState c errorState = 
    case lookup currentState transTable of
        Nothing    -> error ("Invalid state " ++ (show currentState))
        Just table -> lookup_next_state_table table c errorState

-- longest_match take a String and a DFA,
-- find the longest prefix to get a valid match before reaching the error state.
-- if no valid match can be found, return the error state.
longest_match :: (Eq state, Show state) => [Char] -> DFA state -> (state, [Char], [Char])
longest_match input dfa = longest_match_helper input "" dfa (start_state dfa) (error_state dfa, input, "")

-- the helper takes two extra parameters:
-- the current state, and the temporary result to be return
longest_match_helper :: (Eq state, Show state) => 
    [Char] -> [Char] -> DFA state -> state -> (state, [Char], [Char]) -> (state, [Char], [Char])
longest_match_helper [] current dfa currentState tempResult = tempResult
longest_match_helper (c:cs) current dfa currentState tempResult
    | nextState == (error_state dfa)      = tempResult
    | nextState `elem` (final_states dfa) = longest_match_helper cs nextString dfa nextState (nextState, cs, nextString)
    | otherwise                           = longest_match_helper cs nextString dfa nextState tempResult
    where nextState = next_state (trans_table dfa) currentState c (error_state dfa)
          nextString = current ++ [c]

--------------------------------------------------------------------
-- test
--------------------------------------------------------------------

alphabetTable :: [state] -> Char -> NextStateTable (Maybe state)
--alphabetTable [] startChar = [(MatchAll, Nothing)]
alphabetTable [] startChar = []
alphabetTable (i:is) startChar = ((MatchSingle startChar, Just i) : alphabetTable is (succ startChar))

testInput = "bceadgfcbacbeddfad@#$%@#"

testTransientTable = [
    (Just 0, alphabetTable [0..6] 'a'), 
    (Just 1, alphabetTable [1,3,0,6,4,2,5] 'a'), 
    (Just 2, alphabetTable [2,4,0,1,5,6,3] 'a'), 
    (Just 3, alphabetTable [3,2,5,1,4,0,6] 'a'), 
    (Just 4, alphabetTable [4,1,0,3,6,2,5] 'a'), 
    (Just 5, alphabetTable [5,1,3,4,6,0,2] 'a'), 
    (Just 6, alphabetTable [6,5,1,2,4,3,0] 'a')
    ]

testDFA = DFA (Just 0) testTransientTable [Just 5, Just 6] Nothing

--result = parseDFA testInput  testDFA
result = longest_match testInput testDFA



