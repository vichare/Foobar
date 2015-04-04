{-
Sum-Product Problem (Brian Smith Version)
 
  Let x and y are two integers chosen from {2,...,99}
  Suppose A is given the value x+y and B is given the value x*y.

  <<1>>   Mr. B.:  I do not know the two numbers.
  <<2>>   Mr. A.:  I knew you didn't.  Neither do I.
  <<3>>   Mr. B.:  Now I know the two numbers.
  <<4>>   Mr. A.:  Now I know the two numbers.

  What are the two numbers?
 -}
import Data.List

oneNumber = [2..99]
twoNumber = [(x, y) | x <- oneNumber, y <- oneNumber, x <= y]

sameKey key a b = (key a) == (key b)

myGroupBy key l = myGroupByHelper l key []

myGroupByHelper [] key previousResult = previousResult
myGroupByHelper list@(x:_) key previousResult 
    = let (ans, remain) = partition (sameKey key x) list in
        myGroupByHelper remain key (ans:previousResult)

sure = (== 1) . length
notSure = not . sure
--mustNotSure = null . filter sure

a1 = myGroupBy (uncurry (+)) twoNumber 
b1 = myGroupBy (uncurry (*)) twoNumber 

-- A doesn't know
a2 = filter notSure a1

-- B doesn't know
b2 = filter notSure b1

-- A knew that B doesn't know
a3 = flip filter a2 (all (`elem` (concat b2)))

-- B knows that (A knew B doesn't know)
b3 = flip map b2 (filter (`elem` (concat a3)))

-- B knows the answer
b4 = filter sure b3

-- A knows that B knows the answer
a4 = flip map a3 (filter (`elem` (concat b4)))

-- A knows the answer
a5 = filter sure a4


