module Expression.Polynomial where

import Expression.Monomial

data Polynomial = Polynomial [(Int, Monomial)]
