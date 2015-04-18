
-- generate prime numbers
-- code from internet

minus (x:xs) (y:ys) = case (compare x y) of 
           LT -> x : minus  xs  (y:ys)
           EQ ->     minus  xs     ys 
           GT ->     minus (x:xs)  ys
minus  xs     _     = xs
union (x:xs) (y:ys) = case (compare x y) of 
           LT -> x : union  xs  (y:ys)
           EQ -> x : union  xs     ys 
           GT -> y : union (x:xs)  ys
union  xs     []    = xs
union  []     ys    = ys

_Y   :: (t -> t) -> t
_Y g = g (_Y g)                -- multistage, non-sharing, recursive
       -- g x where x = g x    -- two stages, sharing, corecursive


primesTME = 2 : _Y ((3:) . gaps 5 . joinT . map (\p-> [p*p, p*p+2*p..]))
 
joinT ((x:xs):t) = x : (union xs . joinT . pairs) t  -- set union, ~=
  where  pairs (xs:ys:t) = union xs ys : pairs t     --    nub.sort.concat
 
gaps k s@(x:xs) | k < x = k:gaps (k+2) s       -- ~= [k,k+2..]\\s, 
                | True  =   gaps (k+2) xs      --   when null(s\\[k,k+2..])

result = foldl' (+) 0 $ takeWhile (< 100000000) primesTME

