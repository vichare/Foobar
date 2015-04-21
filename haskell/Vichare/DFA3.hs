
-- It seems prettier, but I'm not sure whether 
-- it should be written in this way.

module Vichare.DFA3 where
import Vichare.Match

-- State match matchState nextState
-- The logic is: if match jump to match state
--               otherwise jump to next state
data State = State CharMatch State State
           | FinalState State -- record
           | ErrorState
           -- if there's no match, go to error state

-- A state contains the whole graph
-- A state is a DFA


longest_match :: [Char] -> State -> (Maybe [Char], [Char])
-- input: the string, start state
-- output: (longest match, rest of the string)
longest_match input state = 
    longest_match' input [] state (Nothing, input)

longest_match' :: [Char] -> [Char]-> State -> (Maybe [Char], [Char]) 
                                           -> (Maybe [Char], [Char])
-- input:
-- remain string
-- consumed string
-- current state
-- temp result = (previous match, consumed input, rest input)

longest_match' _ _ ErrorState tempResult = tempResult

longest_match' input consumed (FinalState state) _
    = longest_match' input consumed state (Just consumed, input) 

longest_match' input@(c:cs) consumed (State m matchState nextState) tempResult
    = if c `match` m
      then longest_match' cs (consumed++[c]) matchState tempResult
      else longest_match' input consumed nextState tempResult

longest_match' [] _ _ tempResult = tempResult

--------------------------------------------------------------------
-- test
--------------------------------------------------------------------

s0  = State (MatchSingle 'a') s0
    . State (MatchSingle 'b') s1
    . State (MatchSingle 'c') s2
    . State (MatchSingle 'd') s3
    . State (MatchSingle 'e') s4
    . State (MatchSingle 'f') s5
    . State (MatchSingle 'g') s6
    $ ErrorState

s1  = State (MatchSingle 'a') s1
    . State (MatchSingle 'b') s3
    . State (MatchSingle 'c') s0
    . State (MatchSingle 'd') s6
    . State (MatchSingle 'e') s4
    . State (MatchSingle 'f') s2
    . State (MatchSingle 'g') s5
    $ ErrorState

s2  = State (MatchSingle 'a') s2
    . State (MatchSingle 'b') s4
    . State (MatchSingle 'c') s0
    . State (MatchSingle 'd') s1
    . State (MatchSingle 'e') s5
    . State (MatchSingle 'f') s6
    . State (MatchSingle 'g') s3
    $ ErrorState

s3  = State (MatchSingle 'a') s3
    . State (MatchSingle 'b') s2
    . State (MatchSingle 'c') s5
    . State (MatchSingle 'd') s1
    . State (MatchSingle 'e') s4
    . State (MatchSingle 'f') s0
    . State (MatchSingle 'g') s6
    $ ErrorState

s4  = State (MatchSingle 'a') s4
    . State (MatchSingle 'b') s1
    . State (MatchSingle 'c') s0
    . State (MatchSingle 'd') s3
    . State (MatchSingle 'e') s6
    . State (MatchSingle 'f') s2
    . State (MatchSingle 'g') s5
    $ ErrorState

s5  = FinalState
    . State (MatchSingle 'a') s5
    . State (MatchSingle 'b') s1
    . State (MatchSingle 'c') s3
    . State (MatchSingle 'd') s4
    . State (MatchSingle 'e') s6
    . State (MatchSingle 'f') s0
    . State (MatchSingle 'g') s2
    $ ErrorState

s6  = FinalState
    . State (MatchSingle 'a') s6
    . State (MatchSingle 'b') s5
    . State (MatchSingle 'c') s1
    . State (MatchSingle 'd') s2
    . State (MatchSingle 'e') s4
    . State (MatchSingle 'f') s3
    . State (MatchSingle 'g') s0
    $ ErrorState

testInput = "bceadgfcbacbeddfad@#$%@#"

result = longest_match testInput s0


