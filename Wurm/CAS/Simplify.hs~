module Expression.Simplify where

import Expression.AST

simplify :: Expression -> Expression
-- | Rules for products...
simplify (BinExpr e1 Plus (BinExpr e2 Plus e3))
	= MultiExpr Sum $ map simplify [e1, e2, e3]
simplify (BinExpr (BinExpr e1 Plus e2) Plus e3)
	= MultiExpr Sum $ map simplify [e1, e2, e3]

simplify (BinExpr e1 Mult (BinExpr e2 Mult e3))
	= MultiExpr Product $ map simplify [e1, e2, e3]
simplify (BinExpr (BinExpr e1 Mult e2) Mult e3)
	= MultiExpr Product $ map simplify [e1, e2, e3]

simplify e = e
