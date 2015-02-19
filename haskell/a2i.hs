
a2i :: (Num a) => String -> a
a2i s = loop 0 s
  where loop acc [] = acc
        loop acc (x:xs) = loop acc' xs
                          where acc' = acc * 10 + digitToInt x


i = a2i "18446744073709551615"

