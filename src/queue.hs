
module Queue where

-- From Okasaki's Purely Functional Data Structures
data Queue a =
  Queue { enqueue :: [a]
        , dequeue :: [a]
        } deriving (Eq, Show)

toQueue :: [a] -> Queue a
toQueue xs = Queue xs (reverse xs)

-- adds an item
push :: a -> Queue a -> Queue a
push x q = let xs = x : enqueue q
           in toQueue xs

pop :: Queue a -> Maybe (a, Queue a)
pop q =
  case dequeue q of
    [] -> Nothing
    x:xs -> Just (x, toQueue xs)

