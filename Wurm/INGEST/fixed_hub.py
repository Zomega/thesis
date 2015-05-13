#TODO: Generalize state...

def x_dot( x ):
    #ti <- theta i
    #wi <- theta dot i
    #di <- theta double dot i
    t1, t2, t3, t4, w1, w2, w3, w4 = x
    def t(i):
        return [t1, t2, t3, t4][i]
    def w(i):
        return [w1, w2, w3, w4][i]
    def d(i):
        return (1/I) * ( torque(i-1, i) - torque(i, i+1) - b * w(i) )
    def torque(a, b):
        a = a % n
        b = b % n
        assert abs(a-b) == 1
        # TODO
        return 0
        
    return w(1), w(2), w(3), w(4), d(1), d(2), d(3), d(4)
    
    
def x_dot( x ):
    x1, x2 = x
    x1 = float(x1)
    x2 = float(x2)
    #x1_dot = (-6 * x1)/(1 +x1**2)**2 + 2*x2
    #x2_dot = -2 * ( x1 + x2 ) / ( 1+x1**2 )**2
    #x1_dot = x2 - (x1**3)
    #x2_dot = -(x2 ** 3) - x1
    x1_dot = x2
    x2_dot = -x1 + x1**3 - x2
    return( x1_dot, x2_dot )


def traj( x0 ):
    x1 = [x0[0]]
    x2 = [x0[1]]

    dt = 0.0001

    def scale( alpha, x ):
        return (alpha*x[0], alpha*x[1])
        
    def add( x1, x2 ):
        return (x1[0]+x2[0], x1[1]+x2[1])

    for i in range(10**3):
        x_t = (x1[-1], x2[-1])
        x_n = add( x_t, scale( dt, x_dot( x_t ) ) )
        x1.append(x_n[0])
        x2.append(x_n[1])
    return (x1, x2)
    
    
import matplotlib.pyplot as plt
from pylab import arange
from random import randint

def plot(traj):
	x1, x2 = traj
	plt.plot(x1, x2)

plt.xlabel('x1')
plt.ylabel('x2')

for n in range(10):
    plot( traj((randint(-20,20),randint(-20,20))))
    print n

plt.legend()
plt.show()

