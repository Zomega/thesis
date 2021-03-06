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
    plt.plot(x1, x2, linewidth=5)

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

swing = Swing(0, 10, 5, 0.1, 2)
swingcc = ClosedLoopSystem( swing, TVController(swingBangBang(5,.5,1) ) )
#swing = ClosedLoopSystem( Swing(0, 10, 1, 0, 2), ZeroController() )

x_0 = {'I': 1, 'th_dot': -1.9867943371056118, 'th': 0.8551266605053061}
plot( swingcc.simulate( x_0, 20 ), "th", "th_dot" )
#plot( swing.simulate( x_0, 7 ), "th", "th_dot" )

# ADD General Pendulum info.
plt.plot([-pi,pi,0], [0,0,0], 'ro')

TH_DOT, TH = np.mgrid[-4:4:100j, -4:4:100j]
TH_DDOT = - ( swing.b * TH_DOT + swing.k * np.sin(TH) ) / 1
speed = np.sqrt(TH_DOT*TH_DOT + TH_DDOT*TH_DDOT)
lw = 2*speed/speed.max()

plt.streamplot(TH, TH_DOT, TH_DOT, TH_DDOT, color='0.5', linewidth=lw)

plt.show()

print "STARTING DRAWING..."
import pygame

clock = pygame.time.Clock()
pygame.init()
size = (width, height) = (600,500)
screen = pygame.display.set_mode(size)

j = 0
t = 0
traj = swingcc.simulate( x_0, 60 )
while 1:
    screen.fill((255,255,255))
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
    x = traj.estimate(t)
    drawSwing(screen, x, (300,300), 1.5)
    clock.tick(60)
    pygame.display.flip()
    t += 1/30.0
    pygame.image.save(screen, "frame" + str(j) +".png")
    j = j+1
