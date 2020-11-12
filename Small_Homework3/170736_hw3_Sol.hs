----------------------Q1---------------------
qsort :: (Ord a) => [a] -> [a]
qsort [] = []
qsort (x:xs) =
  let s = qsort [a | a <- xs, a <= x]
      b = qsort [a | a <- xs, a > x]
  in  s ++ [x] ++ b

--------------------Q2-----------------------
uniq1 :: (Eq a) => [a] -> [a]
uniq1 [] = []
uniq1 (x:xs)
  | elem x xs = uniq1 xs
  | otherwise = x : uniq1 xs
uniq :: Ord a => t -> [a]
uniq x=qsort (uniq x)

-----------------------Q3--------------------
find :: (Eq t1, Eq t) => [(t1, t)] -> t1 -> t -> [(t1, t)]
find [] a b =[]
find (x:xs) a b
  |(x==(a,b))=xs
  |otherwise=[x]++find xs a b
map1 :: [t1] -> [t] -> [(t1, t)]
map1 a b=[(x,y)| x<-a,y<-b]
neighbors
  :: (Num t1, Num t, Enum t1, Enum t, Ord t1, Ord t) =>
     t1 -> t -> [(t1, t)]
neighbors i j = find (map1 [i+x|x<-[-1..1],i+x>=0,i+x<10,i>=0,i<10] [j+x|x<-[-1..1],j+x>=0,j+x<10,j>=0,j<10]) i j

-----------------------Q4--------------------
sum1 :: Num t => [t1] -> t
sum1 []=0
sum1 (x:xs)=1+(sum1 xs)
count :: Num t => String -> t
count s=sum1 (words s)

-----------------------Q5--------------------
compose_multiple :: [b -> b] -> b -> b
compose_multiple [] a=a
compose_multiple (f:xs) a=f (compose_multiple xs a)

----------------------Q6---------------------
------------------Q6.1---------
data BinaryTree a =Empty | Root a (BinaryTree a) (BinaryTree a) deriving (Eq, Show)
------------------Q6.2---------
maptree :: (t -> a) -> BinaryTree t -> BinaryTree a
maptree f Empty = Empty
maptree f (Root x t1 t2)
  = Root (f x) (maptree f t1) (maptree f t2)
------------------Q6.3----------
foldTree :: (t -> t1 -> t1 -> t1) -> t1 -> BinaryTree t -> t1
foldTree _ b Empty = b
foldTree f i (Root a b c) = f a (foldTree f i b) (foldTree f i c)
