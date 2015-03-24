
-- round f = floor(f * 2 + 1) `div` 2
round' :: (RealFrac b, Integral c) => b -> c
round' = (`div` 2) . floor . (+ 1) . (* 2)
round'' = floor . (+ 0.5)
