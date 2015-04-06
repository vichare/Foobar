
import Data.List
import Vichare.JsonTokenizor

jsonCases = [
      "{}"
    , "{ \"v\":\"1\"}"
    , "{ \"v\":\"1\"\r\n}"
    , "{ \"v\":1}"
    , "{ \"v\":\"ab'c\"}"
    , "{ \"PI\":3.141E-10}"
    , "{ \"PI\":3.141e-10}"
    , "{ \"v\":12345123456789}"
    , "{ \"v\":123456789123456789123456789}"
    , "[ 1,2,3,4]"
    , "[ \"1\",\"2\",\"3\",\"4\"]"
    , "[ { }, { },[]]"
    , "{ \"v\":\"\\u2000\\u20ff\"}"
    , "{ \"v\":\"\\u2000\\u20FF\"}"
    , "{ \"a\":\"hp://foo\"}"
    , "{ \"a\":null}"
    , "{ \"a\":true}"
    , "{ \"a\":false}"
    , "{ \"a\" : true }"
    , "{ \"v\":1.7976931348623157E308}"
    , "{'X':'s"
    , "{'X"
    ]

main = putStrLn . intercalate "\n" . fmap show $ fmap jsonTokenize jsonCases

