from cvxopt import matrix, solvers

from MatrixIO import load, store

def solve(c, A, b):
	c = matrix(c)
	A = matrix(A)
	b = matrix(b)
	sol=solvers.lp(c,A,b)
	x = sol['x']
	return x
