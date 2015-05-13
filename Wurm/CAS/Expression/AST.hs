module Expression.AST where

data Variable = Variable String deriving Eq

data Expression = Const Int
		| Var Variable
		| BinExpr Expression BinOp Expression
		| MultiExpr MultiOp [Expression]
		| TimeDerivative Variable
		| TimeDerivative2 Variable

data BinOp = Plus
	   | Minus
	   | Mult
	   | Quotient
	   | Exp

data MultiOp = Sum
	     | Product
