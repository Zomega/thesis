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

from Leg import *

def plot(traj, name1, name2, tau):
    T, x1 = traj.getSequence(name1)
    T, x2 = traj.getSequence(name2) #[ a for a,b in traj ], [ b for a,b in traj ])
    plt.plot(x1, x2, linewidth=2, label='Tau = ' + str(tau))

def pullin( tau, I_dot_max):
    def f(t):
        t_start = 0
        if t < t_start:
            return 0
        if t < t_start + tau:
            return -I_dot_max
        if t < t_start + 2 * tau:
            return I_dot_max
        return 0
    return f


phi = 2 * pi / 3.0
I_min = 1
I_max = 10
I_dot_max = 5
leg = Leg(I_min, I_max, I_dot_max, 1, 1, 1, phi, 1)

def trim_traj( traj ):
	new_traj = Trajectory()
	for time, entry in traj.timeline:
		if entry["th_dot"] < 0:
			return new_traj
		new_traj.register(time, entry)
	return new_traj
"""
TAU = []
RETURN = []

tau_l = [ x / 40.0 for x in range(4*19) ]
for tau in tau_l:
    leg_w_control = ClosedLoopSystem( leg, TVController(pullin(tau, I_dot_max) ) )

    th_0 = -0.7
    x_0 = {'I': I_max, 'th_dot': 0, 'th': th_0}
    traj = leg_w_control.simulate( x_0, 6 )

    traj = trim_traj(traj)
    TAU.append(tau)
    RETURN.append( -1 * traj.timeline[-1][1]["th"] / th_0 )
    print tau, RETURN[-1]
    plot( traj, "th", "th_dot", tau )

# ADD General Pendulum info.
plt.plot([0], [0], 'ro')
plt.plot( [th_0,-th_0], [0,0], 'ro')

TH_DOT, TH = np.mgrid[0:0.65:100j, (-phi / 1.9):(phi / 1.9):100j]
TH_DDOT = - ( leg.b * TH_DOT + leg.A * np.sin(TH) + leg.B * np.sin(TH / 2.0 ) ) / I_max
speed = np.sqrt(TH_DOT*TH_DOT + TH_DDOT*TH_DDOT)
lw = 5*speed/speed.max()

plt.vlines([-phi / 2, phi/2],0,0.65)
plt.hlines([0], -phi / 2, phi/2)

plt.streamplot(TH, TH_DOT, TH_DOT, TH_DDOT, color='0.5', linewidth=lw)
plt.legend()

fig2 = plt.figure()
ax2 = fig2.add_subplot(111)
ax2.plot(TAU, RETURN)
plt.ylabel("-th_f / th_0")
plt.xlabel("tau")
plt.hlines([1], 0, 2)

plt.show()"""

print "STARTING DRAWING..."
import pygame

clock = pygame.time.Clock()
pygame.init()
size = (width, height) = (600,500)
screen = pygame.display.set_mode(size)

j = 0
t = 0

leg_w_control = ClosedLoopSystem( leg, TVController(pullin(1.274, I_dot_max) ) )

th_0 = - 0.5
x_0 = {'I': I_max, 'th_dot': 0, 'th': th_0}
traj = leg_w_control.simulate( x_0, 6 )
traj = trim_traj(traj)

while 1:
    screen.fill((255,255,255))
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
    drawGait(screen, leg, traj, t)
    clock.tick(60)
    pygame.display.flip()
    t += 1/10.0
    pygame.image.save(screen, "frame" + str(j) +".png")
    j = j+1
