
--
-- hard-code a recursive descent parser for JSON
--
-- In the first verson, if something goes wrong, 
-- we just run error and exit
--

module Vichare.JsonRDA where
import Vichare.JsonTokenizer
import Vichare.Json

t = jsonTokenize "[1,2,3,4]"
testInput = "[{\"a\": \"testify\"}, {\"Vichare\": [1,2,3,{\"c\": null}]}, [], {}]";
tokens = jsonTokenize testInput
tree = jsonRDA tokens

{-
data Workshop = WS {
      input       :: [JSON_TOKEN]
    }
-}

jsonRDA :: [JSON_TOKEN] -> JValue
jsonRDA input = case jsonValue input of
    (value, []) -> value
    (_, remain) -> error ("Redundant sequence: " ++ show remain)

-- ignore a certain token
-- if it doesn't match, raise a error
jsonToken :: JSON_TOKEN -> [JSON_TOKEN] -> [JSON_TOKEN]
jsonToken token [] = error ("Expecting the token " ++ show token ++ " at the end of the input.")
jsonToken ignore (x:remain) = if x == ignore
                              then remain
                              else error ("Expecting the token " ++ show x ++ " instead of " ++ show ignore ++ ".")

jsonValue :: [JSON_TOKEN] -> (JValue, [JSON_TOKEN])
jsonValue [] = error "Expecting a JSON Value at the end of the input."
jsonValue (LeftBrace:remain) = jsonObject remain
jsonValue (LeftBracket:remain) = jsonArray remain
jsonValue (JsonString str:remain) = (JString str, remain)
jsonValue (JsonNumber num:remain) = (JNumber num, remain)
jsonValue (JsonTrue:remain) = (JBool True, remain)
jsonValue (JsonFalse:remain) = (JBool False, remain)
jsonValue (JsonNull:remain) = (JNull, remain)
jsonValue _ = error "Invalid Json Value."

jsonObject :: [JSON_TOKEN] -> (JValue, [JSON_TOKEN])
jsonObject (RightBrace:remain) = (JObject [], remain)
jsonObject input = (JObject objs, remain)
    where (objs, remain) = jsonObjectInside input

jsonObjectInside :: [JSON_TOKEN] -> ([(String, JValue)], [JSON_TOKEN])
jsonObjectInside (JsonString str:Colon:remain) = ((str, value) : restObjects, remain2)
    where (value, remain1) = jsonValue remain
          (restObjects, remain2) = jsonObjectInsidePlus remain1
jsonObjectInside _ = error "Invalid Json Object."

jsonObjectInsidePlus :: [JSON_TOKEN] -> ([(String, JValue)], [JSON_TOKEN])
jsonObjectInsidePlus (RightBrace:remain) = ([], remain)
jsonObjectInsidePlus (Comma:remain) = jsonObjectInside remain
jsonObjectInsidePlus _ = error "Invalid Json Object."

jsonArray :: [JSON_TOKEN] -> (JValue, [JSON_TOKEN])
jsonArray (RightBracket:remain) = (JArray [], remain)
jsonArray input = (JArray array, remain)
    where (array, remain) = jsonArrayInside input
--jsonArray _ = error "Unreachable point."

jsonArrayInside :: [JSON_TOKEN] -> ([JValue], [JSON_TOKEN])
jsonArrayInside input = (value:restValues, remain2)
    where (value, remain1) = jsonValue input
          (restValues, remain2) = jsonArrayInsidePlus remain1

jsonArrayInsidePlus :: [JSON_TOKEN] -> ([JValue], [JSON_TOKEN])
jsonArrayInsidePlus (RightBracket:remain) = ([], remain)
jsonArrayInsidePlus (Comma:remain) = (value:restValues, remain2)
    where (value, remain1) = jsonValue remain
          (restValues, remain2) = jsonArrayInsidePlus remain1
jsonArrayInsidePlus _ = error "Invalid JSON Array."



