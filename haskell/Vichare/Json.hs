
module Vichare.Json where

data JValue = JString String
            | JNumber String
            | JBool Bool
            | JNull
            | JObject [(String, JValue)]
            | JArray [JValue]
              deriving (Eq, Ord, Show)


