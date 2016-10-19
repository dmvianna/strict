
module Main where

import Criterion.Main
import Debug.Trace
import SafeIndex

myList :: [Int]
myList = trace "myList was evaluated"
         ([1..9999] ++ [undefined])

-- your version of (!?) here

main :: IO ()
main = defaultMain
  [ bench "index list 9999"
    $ whnf (myList !!) 998
  , bench "index list maybe index 9999"
    $ nf (myList !?) 9999
  ]
