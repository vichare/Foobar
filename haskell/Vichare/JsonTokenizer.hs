
--
-- if I want to rewrite this, I will remove workshop (only two parameters)
-- and change the return type to "Either [Json_TOKEN] String" 
-- (Right errorMessage)
--
-- TODO : Current ErrorHandler just return the rest string as a ErrorToken
-- We can try to delete some chars to recover the process
--

module Vichare.JsonTokenizer(
          JSON_TOKEN(..)
        , jsonTokenize
        ) where
--module Vichare.JsonTokenizer where
import Vichare.DFA2
import Vichare.JsonDFA
import Data.Char

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
                deriving (Eq, Show)

jsonTokenize :: String -> [JSON_TOKEN]
jsonTokenize input = reverse $ helper DeleteSpace (WS input [])

data State = DeleteSpace
           | FindOneToken
           | FindNumber
           | FindString
           | HandleError

data Workshop = WS {
      input       :: [Char]
    , tokens      :: [JSON_TOKEN]
    }

helper :: State -> Workshop -> [JSON_TOKEN]
helper _ (WS [] tokens) = tokens

helper DeleteSpace ws@(WS (x:xs) tokens) = if isSpace x 
    then helper DeleteSpace (WS xs tokens)
    else helper FindOneToken ws

helper FindOneToken ws@(WS input@(x:xs) tokens)
    | x == '{'    = helper DeleteSpace (WS xs (LeftBrace:tokens))
    | x == '}'    = helper DeleteSpace (WS xs (RightBrace:tokens))
    | x == '['    = helper DeleteSpace (WS xs (LeftBracket:tokens))
    | x == ']'    = helper DeleteSpace (WS xs (RightBracket:tokens))
    | x == ':'    = helper DeleteSpace (WS xs (Colon:tokens))
    | x == ','    = helper DeleteSpace (WS xs (Comma:tokens))
    | x == '"'    = helper FindString ws
    | x == '-'    = helper FindNumber ws
    | x >= '0' && x <= '9' = helper FindNumber ws
    | otherwise   = case tryKeywords input keywords of
                    (_, Nothing)         -> helper HandleError ws
                    (remain, Just token) -> helper DeleteSpace (WS remain (token:tokens))

helper FindNumber ws@(WS input tokens)
    = let (match, remain) = longest_match input jsonNumberDFA in
        case match of
        Just matchstr -> helper DeleteSpace (WS remain ((JsonNumber matchstr):tokens))
        Nothing       -> helper HandleError ws

helper FindString ws@(WS input tokens)
    = let (match, remain) = longest_match input jsonStringDFA in
        case match of
        Just matchstr -> helper DeleteSpace (WS remain ((JsonString matchstr):tokens))
        Nothing       -> helper HandleError ws

helper HandleError (WS input tokens) = (ErrorToken input):tokens

keywords = [
      ("true",  JsonTrue)
    , ("false", JsonFalse)
    , ("null",  JsonNull)
    ]

tryKeywords :: String -> [(String, key)] -> (String, Maybe key)
tryKeywords input []  = (input, Nothing)
tryKeywords input ((k, token):kws) 
    = let len = length k in
        if take len input == k
        then (drop len input, Just token)
        else tryKeywords input kws



