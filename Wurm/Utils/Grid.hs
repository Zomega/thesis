module Utils.Grid where

import Data.Matrix

import Debug.Trace


data RangeSpec = IntRange Int Int
               | SteppedRange Int Int Int
               | FloatRange Float Float Int

type GridSpec = (RangeSpec, RangeSpec)

range :: RangeSpec -> [Float]
range (IntRange a b) = map fromIntegral [a .. b] :: [Float]
range (SteppedRange a b dx) = map fromIntegral [a, a+dx .. b] :: [Float]
range (FloatRange a b steps)
    = let dx = (b-a) / (fromIntegral steps-1)
      in [a, a+dx .. b]

grid :: GridSpec -> [(Float,Float)]
grid (xspec, yspec) = cartProd (range xspec) (range yspec)

mgrid ::  GridSpec -> (Matrix Float, Matrix Float)
mgrid (xspec, yspec)
    = let xrange = range xspec
          yrange = range yspec
      in (fromLists (take (length yrange) $ repeat xrange),
          transpose $ fromLists (take (length xrange) $ repeat yrange))

cartProd xs ys = [(x,y) | x <- xs, y <- ys]

mapOverGrid :: ((Float, Float) -> (Float, Float)) -> GridSpec -> (Matrix Float, Matrix Float)
mapOverGrid f (xspec, yspec)
    = let xrange = range xspec
          yrange = range yspec
          w = length xrange
          h = length yrange
          u :: (Int, Int) -> Float
          u (i,j) = fst $ f ((xrange !! (j-1)), (yrange !! (i-1)))
          v :: (Int, Int) -> Float
          v (i,j) = snd $ f ((xrange !! (j-1)), (yrange !! (i-1)))
      in (matrix w h u, matrix w h v)

--main = do
--    print $ mgrid ((IntRange 0 4), (IntRange 0 4))
--    print $ range (FloatRange (-3) 3 30)
--    print $ range (SteppedRange (-10) 10 5)
