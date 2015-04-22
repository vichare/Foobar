Here dumps some haskell programs
====

A json parser
----

The first version:

    Match.hs
    DFA1.hs => Match

The second version:

    DFA2.hs => Match
    JsonDFA.hs => Match, DFA2
    JsonTokenizer.hs => DFA2, JsonDFA

    Json.hs
    JsonRDA.hs => JsonTokenizer, Json

The third version:

    DFA3.hs => Match.hs

