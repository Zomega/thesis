import System.Process
import Data.Matrix

-- | Calls out to a python script to run LQR Control.
lqr :: Matrix Float -> Matrix Float -> Matrix Float -> Matrix Float -> IO (Matrix Float, Matrix Float)
lqr a b q r
    = do
        store "A.matrix#" a
        store "B.matrix#" b
        store "Q.matrix#" q
        store "R.matrix#" r
        pHandle <- runCommand "python LQR.py"
                            ++ " -A A.matrix#"
                            ++ " -B B.matrix#"
                            ++ " -Q Q.matrix#"
                            ++ " -R R.matrix#"
                            ++ " --Kout K.matrix#"
                            ++ " --Pout P.matrix#"
        k <- load "K.matrix#"
        p <- load "P.matrix#"
	return (k,p)

main = let a = fromLists [[1,2],[3,4]]
           b = fromLists [[1],[3]]
           q = fromLists [[1,0],[0,2]]
           r = fromLists [[1]]
        in do
          (k,p) <- lqr a b q r
          putStrLn $ show p
          putStrLn $ show k
