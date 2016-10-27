
module Main where

import Criterion.Main
import qualified Data.List as L
import qualified Data.Vector as B
import qualified Data.Vector.Unboxed as U
import qualified Data.Vector.Generic as G
import qualified Data.Vector.Generic.Mutable as GM
import Data.Word (Word64)
import System.Random.Mersenne.Pure64

randomStream :: (PureMT -> (a, PureMT))
             -> PureMT
             -> [a]
randomStream rndStep = L.unfoldr (Just . rndStep)

toStream :: Word64 -> [Double]
toStream seed = randomStream randomDouble $ pureMT seed

main :: IO ()
main = print . take 10 $ toStream 42
