module Expression.LaTeX where

import Expression.AST
import Expression.Monomial
import Expression.Polynomial

import Data.List (intercalate)


-------------------------------------------------------------------------------
-- VARIABLES ------------------------------------------------------------------
-------------------------------------------------------------------------------

instance Show Variable where
	show (Variable name) = name

-------------------------------------------------------------------------------
-- GENERAL EXPRESSIONS --------------------------------------------------------
-------------------------------------------------------------------------------

instance Show BinOp where
	show Plus  = "+"
	show Minus = "-"
	show Mult  = "\\cdot"
	show Quotient = "/"
	show Exp = "^"

instance Show MultiOp where
	show Sum = show Plus
	show Product = show Mult

instance Show Expression where
	show (Const a)
		= show a
	show (Var x)
		= show x
	show (BinExpr l Quotient r)
		= "\\frac{ " ++ show l ++ " }{ " ++ show r ++ " }"
	show (BinExpr l Exp r)
		= "( " ++ show l ++ " )^{ " ++ show r ++ " }"
	show (BinExpr l op r)
		= "( " ++ show l ++ " " ++ show op ++ " " ++ show r ++ " )"
	show (MultiExpr op exprs)
		= "( " ++ (intercalate (" " ++ show op ++ " ") $ map show exprs) ++ " )"
	show (TimeDerivative x)
		= "\\dot " ++ show x
	show (TimeDerivative2 x)
		= "\\ddot " ++ show x

-------------------------------------------------------------------------------
-- MONOMIALS ------------------------------------------------------------------
-------------------------------------------------------------------------------

instance Show Monomial where
	show (Monomial m) = intercalate " " $ map (\(x,n) -> show x ++ "^" ++ show n) m

-------------------------------------------------------------------------------
-- POLYNOMIALS ----------------------------------------------------------------
-------------------------------------------------------------------------------

instance Show Polynomial where
	show (Polynomial p) = intercalate " + " $ map (\(a, m) -> show a ++ " " ++ show m) p
