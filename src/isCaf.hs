
module Main where

-- not a CAF

incdInts :: [Integer] -> [Integer]
incdInts = map (+1)

main :: IO ()
main = do
  print (incdInts [1..] !! 1000)
  print (incdInts [1..] !! 900000)
  print (incdInts [1..] !! 900000)
  print (incdInts [1..] !! 9009000)
  print (incdInts [1..] !! 9009000)
  print (incdInts [1..] !! 9009000)
