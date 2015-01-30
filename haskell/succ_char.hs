
succ_char_helper :: (Enum a, Integral n) => a -> n -> [a] -> [a]
succ_char_helper c 0 prelist = prelist
succ_char_helper c num prelist = succ_char_helper (succ c) (num-1) (prelist ++ [c])
