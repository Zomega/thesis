#!/usr/bin/env python

import click

from MatrixIO import load, store

import LP # Linear Solvers
import QP # Quadratic Solvers

@click.group()
def optimizers():
	pass

@optimizers.command()
@click.option('-c', type=click.Path(exists=True))
@click.option('-A', type=click.Path(exists=True))
@click.option('-b', type=click.Path(exists=True))
@click.option('--out', type=click.Path(exists=False))
def lp(c, a, b, out):
	c = load(c)
	A = load(a)
	b = load(b)
	x = LP.solve(c=c, A=A, b=b)
	store(out, x)
	print "Result written to " + out

#Q = 2*matrix([ [2, .5], [.5, 1] ])
#p = matrix([1.0, 1.0])
#G = matrix([[-1.0,0.0],[0.0,-1.0]])
#h = matrix([0.0,0.0])
#A = matrix([1.0, 1.0], (1,2))
#b = matrix(1.0)
# TODO: Rewrite QP...
@optimizers.command()
@click.option('-c', type=click.Path(exists=True))
@click.option('-A', type=click.Path(exists=True))
@click.option('-b', type=click.Path(exists=True))
@click.option('--out', type=click.Path(exists=False))
def qp(c, a, b, out):
	c = load(c)
	A = load(a)
	b = load(b)
	x = LP.solve(c=c, A=A, b=b)
	store(out, x)
	print "Result written to " + out

if __name__ == '__main__':
    optimizers()
