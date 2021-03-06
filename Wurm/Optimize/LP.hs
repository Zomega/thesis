module Optimize.LP where

-- | General Linear Programming
-- |
-- | z* = min c1^T x1 + c2^T x2 + c3^T x3
-- |
-- | subj A11 x1 + A12 x2 + A13 x3 == b1
-- |      A21 x1 + A22 x2 + A23 x3 >= b2
-- |      A31 x1 + A32 x2 + A33 x3 <= b3
-- | 
-- |      x1 >= 0
-- |      x2 <= 0
-- |      x3 unrestricted
-- | 
-- | Dual Form:
-- | 
-- | z* = max b1^T y1 + b2^T y2 +b3^T y3
-- | 
-- | subj A11^T y1 + A21^T y2 + A31^T y3 <= c1
-- |      A12^T y1 + A22^T y2 + A32^T y3 >= c2
-- |      A13^T y1 + A23^T y2 + A33^T y3 == c3
-- | 
-- |      y1 unrestricted
-- |      y2 >= 0
-- |      y3 <= 0

import System.Process
import Data.Matrix

import Utils.MatrixIO

data ReducedLP = ReducedLP (Matrix Float) (Matrix Float) (Matrix Float)

solve_reduced :: ReducedLP -> IO (Matrix Float)
solve_reduced (ReducedLP c a b)
    = do
        store "c.matrix#" c
        store "A.matrix#" a
        store "b.matrix#" b
        pHandle <- runCommand "optimize lp -c c.matrix# -A A.matrix# -b b.matrix# --out x.matrix#"
        load "x.matrix#"

main = do
    c <- load "c.matrix"
    a <- load "A.matrix"
    b <- load "b.matrix"
    x <- solve_reduced (ReducedLP c a b)
    print a
