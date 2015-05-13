from math import *

import numpy

import random

import matplotlib.pyplot as plt
from pylab import arange
from random import randint

import numpy as np
import pylab as pl
from matplotlib import collections  as mc
        
from ControlledSystem import ClosedLoopSystem
from Controller import *

from Swing import *
from Pendulum import *

def plot(traj, name1, name2):
    T, x1 = traj.getSequence(name1)
    T, x2 = traj.getSequence(name2) #[ a for a,b in traj ], [ b for a,b in traj ])
    plt.plot(x1, x2)

#plt.xlabel('x1')
#plt.ylabel('x2')

pendulum_free = UnactuatedPendulum( 0.1, 10, 5 )
swing = ClosedLoopSystem( Swing(0, 10, 1, 0.1, 2), ZeroController() )
def f(t):
    if t < 1:
        return 1
    if t < 2:
        return -1
    return 0

def swingBangBang(T, tau, I_dot_max):
    def f(t):
        if t > T:
            return f(t - T)
        if t < tau:
            return I_dot_max
        if t < (T / 2)  - tau:
            return 0
        if t < (T / 2) + tau:
            return -1 * I_dot_max
        if t < T - tau:
            return 0
        return I_dot_max
    return f

"""
#swingcc = ClosedLoopSystem( Swing(0, 10, 5, 0.1, 2), TVController(swingBangBang(5,.5,1) ) )
swingcc = ClosedLoopSystem( Swing(0, 10, 5, 0.1, 2), TVController(swingBangBang(2.5,.5,1) ) )
pendulum = ClosedLoopSystem( Swing(0, 10, 5, 0.0, 2), ZeroController() )
swing2 = ClosedLoopSystem( Swing(0, 10, 1, 0.1, 2), TVController(f) )

#pendulum = UnactuatedPendulum( 0, 10, 5 )

#plot( pendulum_free.simulate( {"th":14, "th_dot":-3.5}, 200.0 ), "th", "th_dot" )
#plot( pendulum_free.simulate( {"th":14, "th_dot":3.5}, 40.0 ), "th", "th_dot" )
#plot( pendulum.simulate( {"th":14 - 2*pi, "th_dot":-3.5}, 200.0 ), "th", "th_dot" )
# plot( pendulum.simulate( {"th":14, "th_dot":3.5}, 40.0 ), "th", "th_dot" )

#plot( swing.simulate( {"th":14 - 2*pi, "th_dot":-1.5, "I":1.0}, 20.0 ), "th", "th_dot" )
#plot( swing2.simulate( {"th":14 - 2*pi, "th_dot":-1.5, "I":1.0}, 20.0 ), "th", "th_dot" )
x_0 = {'I': 1.0, 'th_dot': -2.0534396169989577, 'th': 7.442233486484738 - 2*pi}
x_1 = {'I': 1.0, 'th_dot': 0, 'th': -1.98478}
plot( swingcc.simulate( x_0, 5.1 ), "th", "th_dot" )
plot( pendulum.simulate( x_0, 7.0 ), "th", "th_dot" )
plot( pendulum.simulate( x_1, 6.0 ), "th", "th_dot" )
"""


swingcc = ClosedLoopSystem( Swing(680, 760, 150, 5, 1500), TVController(swingBangBang(2.5,.5,150) ) )
pendulum = ClosedLoopSystem( Swing(680, 760, 150, 0, 1500), ZeroController() )

x_0 = {'I': 720, 'th_dot': 1, 'th': 0}
#x_1 = {'I': 720, 'th_dot': 0, 'th': -1.98478}
plot( swingcc.simulate( x_0, 5 * 20 ), "th", "th_dot" )
plot( pendulum.simulate( x_0, 5 ), "th", "th_dot" )
#plot( pendulum.simulate( x_1, 6.0 ), "th", "th_dot" )

"""
lines = rrt((0, 0))
c = np.array([(1, 0, 0, 1), (0, 1, 0, 1), (0, 0, 1, 1)])

lc = mc.LineCollection(lines, linewidths=2)
fig, ax = pl.subplots()
ax.add_collection(lc)
ax.autoscale()
ax.margins(0.1)
"""

plt.show()
        
