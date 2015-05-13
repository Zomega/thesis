import System.Random
import Control.Monad (replicateM)

main = do
    x <- replicateM 10 (randomIO :: IO Float)
    y <- replicateM 10 (randomIO :: IO Float)
    print $ zip x y
