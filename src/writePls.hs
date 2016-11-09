
module Main where

import Control.Exception
import Data.Typeable

handler :: SomeException -> IO ()
handler (SomeException e) = do
  putStrLn ("Running main caused an error! It was: " ++ show e)
  writeFile  "bbb" "hi\n"

main = do
  writeFile "zzz" "hi\n"
  `catch` handler

