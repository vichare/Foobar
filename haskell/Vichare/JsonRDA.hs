
module Vichare.JsonRDA where
import Vichare.JsonTokenizer

testInput = "[{\"a\": \"testify\"}, {\"Vichare\": [1,2,3,{\"c\": null}]}, [], {}]";
tokens = jsonTokenize testInput
