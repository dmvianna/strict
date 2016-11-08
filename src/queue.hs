
module Queue where

import Criterion.Main
import Data.Maybe (fromJust)
import qualified Data.Sequence as S

-- From Okasaki's Purely Functional Data Structures
data Queue a =
  Queue { enqueue :: [a]
        , dequeue :: [a]
        } deriving (Eq, Show)

toQueue :: [a] -> Queue a
toQueue xs' =
  case splitAt (length xs' - 1) xs' of
    ([],[]) -> Queue [] []
    ([x],[])   -> Queue [] [x]
    (x,y) -> Queue x y

push :: a -> Queue a -> Queue a
push x q = let xs = x : enqueue q
           in Queue xs (dequeue q)

pop :: Queue a -> Maybe (a, Queue a)
pop q =
  case dequeue q of
    [] -> Nothing
    [x] -> Just (x, toQueue $ enqueue q)
    _ -> pop $ toQueue (enqueue q ++ dequeue q) -- should not happen

-- Do stuff

turnQ :: Queue a -> Queue a
turnQ q' =
  case dequeue q' of
    [] -> toQueue []
    _  -> do
      let (x, q) = fromJust $ pop q -- living la vida loca
      push x q

turnS :: S.Seq a -> S.Seq a
turnS s =
  if null s
  then S.empty
  else
    let x  = S.index s 0
        xs = snd $ S.splitAt 1 s
    in xs S.|> x

-- Sample

l' :: [Int]
l' = [1,2,3]

q'' :: Queue Int
q'' = toQueue l'

s' :: S.Seq Int
s' = S.fromList l'

again :: Int -> (a -> a) -> a -> a
again n f = foldr (.) id (replicate n f)

main :: IO ()
main = defaultMain
  [ bench "turning queue" $
    whnf (again 1 turnQ) q''
  , bench "turning sequence" $
    whnf (again 1 turnS) s'
  ]

-- again 4 (snd . fromMaybe (0, Queue [] []) . pop) q''
