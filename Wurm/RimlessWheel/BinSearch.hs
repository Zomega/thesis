module BinSearch where

data BinSearchResult = TooHigh | TooLow | JustRight

binarySearch :: (Double -> BinSearchResult) -> Int -> Double -> Double -> Double
binarySearch _ 0 low high = (high + low) / 2.0
binarySearch f i low high = let mid = (high + low) / 2.0
				in case (f mid) of
					TooHigh -> binarySearch f (i - 1) low mid
					TooLow -> binarySearch f (i - 1 ) mid high
					JustRight -> mid

approxFixedPoint :: (Double -> Double) -> Double -> Double -> Double
approxFixedPoint f low high = binarySearch (\ x -> case x > (f x) of
							True -> TooHigh
							False -> TooLow) 1000 low high

-- Assumes that the function is monotonic and increasing...
approxZeroPoint :: (Double -> Double) -> Double -> Double -> Double
approxZeroPoint f low high = binarySearch (\ x -> case (f x) < 0 of
							True -> TooLow
							False -> TooHigh) 1000 low high

