from ControlledSystem import ControlledSystem
from math import sin, cos, sqrt

class Swing(ControlledSystem):
    def __init__( self, I_min, I_max, I_dot_max, b, k ):
        # Used to validate states and controls...
        self.I_min = I_min
        self.I_max = I_max
        self.I_dot_max = I_dot_max
        
        # System Parameters
        self.b = b
        self.k = k
    def f(self, x, u):
        th = x["th"]
        th_dot = x["th_dot"]
        I = x["I"]
        I_dot = u
        #print x
        return {"th": th_dot,
                "th_dot": - ( self.b * th_dot + self.k * sin(th) ) / I,
                "I": I_dot}

import pygame

def drawSwing(screen, x, center, lmax):
	th = x["th"]
        th_dot = x["th_dot"]
        I = x["I"]
	l = 100 * sqrt(I)
	lmax = 100 * lmax
	c_x, c_y = center
	pole_end = (int(c_x + lmax * sin(th)), int(c_y + lmax * cos(th)))
	bob = (int(c_x + l * sin(th)), int(c_y + l * cos(th)))
	pygame.draw.circle(screen, (0,0,0), center, 5)
        pygame.draw.line(screen, (0,0,0), center, pole_end,3)
        pygame.draw.circle(screen, (0,0,255), bob, 14, 0)
