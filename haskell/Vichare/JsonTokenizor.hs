
module Vichare.JsonTokenizor where
import Vichare.DFA2

data JSON_TOKEN = LeftBrace
                | RightBrace
                | LeftBracket
                | RightBracket
                | Colon
                | Comma
                | JsonString String
                | JsonNumber String
                | JsonTrue
                | JsonFalse
                | JsonNull
                | ErrorToken String

jsonTokenize :: String -> [JSON_TOKEN]
jsonTokenize input = undefined



