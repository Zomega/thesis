from __future__ import division, print_function
 
import numpy as np
import scipy.linalg

from MatrixIO import load, store

import click

def lqr(A,B,Q,R):
    """Solve the continuous time lqr controller.
     
    dx/dt = A x + B u
     
    cost = integral x.T*Q*x + u.T*R*u
    """
    #ref Bertsekas, p.151
 
    #first, try to solve the ricatti equation
    P = np.matrix(scipy.linalg.solve_continuous_are(A, B, Q, R))
     
    #compute the LQR gain
    K = np.matrix(scipy.linalg.inv(R)*(B.T*P))
     
    return K, P
 
def dlqr(A,B,Q,R):
    """Solve the discrete time lqr controller.
     
     
    x[k+1] = A x[k] + B u[k]
     
    cost = sum x[k].T*Q*x[k] + u[k].T*R*u[k]
    """
    #ref Bertsekas, p.151
 
    #first, try to solve the ricatti equation
    P = np.matrix(scipy.linalg.solve_discrete_are(A, B, Q, R))
     
    #compute the LQR gain
    K = np.matrix(scipy.linalg.inv(B.T*X*B+R)*(B.T*X*A))
     
    return K, P

@click.command()
@click.option('-A', type=click.Path(exists=True))
@click.option('-B', type=click.Path(exists=True))
@click.option('-Q', type=click.Path(exists=True))
@click.option('-R', type=click.Path(exists=True))
@click.option('-Kout', type=click.Path())
@click.option('-Pout', type=click.Path())
def run_lqr(a, b, q, r, kout, pout):
    A = load(a)
    B = load(b)
    Q = load(q)
    R = load(r)

    K, P = lqr(A,B,Q,R)

    store(kout, K)
    store(pout, P)

if __name__ == '__main__':
    run_lqr()
