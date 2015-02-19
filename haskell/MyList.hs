
data MyList a = MyNull | MyList {car :: a, cdr :: MyList a}
  deriving (Show)

-- How to implement this?
--Show a => Show MyList a

--showList :: MyList a -> String
--showList MyNull = "My[]"
--showList (MyList i remain) = "My[" ++ (show i) ++ "]"
  --where showContent :: MyList a -> String
        --showContent MyNull = ""
        --showContent (MyList i MyNull) = show i
        --showContent (MyList i remain) = (show i) ++ ", " ++ (showContent remain)

myConvert :: [a] -> MyList a
myConvert (x:xs) = MyList x (myConvert xs)
myConvert [] = MyNull

myRevert :: MyList a -> [a]
myRevert (MyList i remain) = i:(myRevert remain)
myRevert myNull = []

myMap :: (a -> b) -> MyList a -> MyList b
myMap f MyNull = MyNull
myMap f (MyList i remain) = MyList (f i) (myMap f remain)

l = myConvert [1..5]
names = myConvert ["Alpha", "Beta", "Charlie", "Delta", "Eistein"]
names' = myRevert $ myMap (++ "-") names
names'' = myRevert $ myMap ((++) "-") names


