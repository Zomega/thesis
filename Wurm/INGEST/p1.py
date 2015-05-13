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

