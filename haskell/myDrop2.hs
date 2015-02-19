
myDrop2 :: (Num n, Ord n) => [a] -> n -> [a]
myDrop2 xs n = if n <= 0 || null xs
  then xs
  else myDrop2 (tail xs) (n - 1)

test = myDrop2 "Test"

