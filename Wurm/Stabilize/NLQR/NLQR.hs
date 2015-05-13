import Expression.AST
import Expression.LaTeX
import Expression.Simplify
import Expression.Monomial
import Expression.Polynomial
import Expression.Calculus.Derivative

-- | For classes that represent subclasses of expressions.
class ExprPrecursor a where
	expression :: a -> Expression

-- | For classes that represent subclasses of expressions.
class Shoehornable a where
	shoehorn :: Expression -> Maybe a

instance ExprPrecursor Variable where
	expression v = Var v

instance Shoehornable Variable where
	shoehorn (Var v) = Just v
	shoehorn _ = Nothing

instance ExprPrecursor Monomial where
	expression (Monomial m) = MultiExpr Product $ map (\(x,n) -> BinExpr (Var x) Exp (Const n)) m

x1 = Variable "x_1"
x2 = Variable "x_2"
x3 = Variable "x_3"

m = Monomial [(x1,2),(x2,4),(x3,10)]

p = Polynomial [(3,m), (4,m)]

main = putStrLn $ show $ p -- simplify $ time_derivative $ expression m
