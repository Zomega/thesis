module Expression.Calculus.Derivative where

import Expression.AST

import Expression.Show

time_derivative :: Expression -> Expression
time_derivative (Const a)
	= Const 0
time_derivative (Var x)
	= TimeDerivative x
time_derivative (TimeDerivative x)
	= TimeDerivative2 x
time_derivative (BinExpr l Plus r)
	= (BinExpr (time_derivative l) Plus (time_derivative r))
time_derivative (BinExpr l Minus r)
	= (BinExpr (time_derivative l) Minus (time_derivative r))
time_derivative (BinExpr l Mult r)
	= BinExpr (BinExpr (time_derivative l) Mult r) Plus (BinExpr l Mult (time_derivative r))

time_derivative (BinExpr b Exp (Const 1))
	= time_derivative b

time_derivative (BinExpr b Exp (Const n))
	= MultiExpr Product [Const n, BinExpr b Exp (Const $ n - 1), time_derivative b]

time_derivative (MultiExpr Sum exprs)
	= MultiExpr Sum $ map time_derivative exprs

time_derivative (MultiExpr Product [expr])
	= time_derivative expr
time_derivative (MultiExpr Product exprs)
	= time_derivative $ BinExpr (head exprs) Mult (MultiExpr Product $ tail exprs)

time_derivative e = error $ "Took a time derivative of an unsupported expression " ++ show e
