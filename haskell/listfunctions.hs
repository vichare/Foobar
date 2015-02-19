
data TestCases = TestCases String String
--  deriving (Show)

a = [TestCases "null [1,2,3]" (show (null [1,2,3])),
     TestCases "null []" (show (null [])),
     TestCases "head [2..7]" (show (head [2..7])),
     TestCases "tail [2..7]" (show (tail [2..7])),
     TestCases "last [2..7]" (show (last [2..7])),
     TestCases "init [2..7]" (show (init [2..7])),
     TestCases "head [2..7]" (show (head [2..7])),
     TestCases "takeWhile (< 5) [2..7]" (show (takeWhile (< 5) [2..7])),
     TestCases "(++) [1,3..10] [2,4..10]" (show ((++) [1,3..10] [2,4..10])),
     TestCases "concat [[[1,2],[3]], [[4],[5],[6]]]" (show (concat [[[1,2],[3]], [[4],[5],[6]]])),
     TestCases "reverse [2,3,5,7,11]" (show (reverse [2,3,5,7,11])),
     TestCases "and [True,False,True]" (show (and [True,False,True])),
     TestCases "and []" (show (and [])),
     TestCases "or [True,False,True]" (show (or [True,False,True])),
     TestCases "or []" (show (or [])),
     TestCases "all odd [1,3,5]" (show (all odd [1,3,5])),
     TestCases "all odd []" (show (all odd [])),
     TestCases "any even [3,1,4,1,5,9,2,6,5]" (show (any even [3,1,4,1,5,9,2,6,5])),
     TestCases "any even []" (show (any even [])),
     TestCases "take 3 \"foobar\"" (show (take 3 "foobar")),
     TestCases "take 2 [1]" (show (take 2 [1])),
     TestCases "drop 3 \"xyzzy\"" (show (drop 3 "xyzzy")),
     TestCases "splitAt 3 \"foobar\"" (show (splitAt 3 "foobar")),
     --TestCases "" (show ()),
     TestCases "otherwise" "True"]

test :: TestCases -> String
test (TestCases des result) = des ++ " = " ++ result

instance Show TestCases where
    show (TestCases des result) = des ++ " = " ++ result

main = putStrLn $ unlines $ fmap test a

