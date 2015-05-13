from ControlledSystem import ControlledSystem, ClosedLoopSystem
from DynamicSystem import DynamicSystem
from Controller import ZeroController
from math import sin

class SimplePendulum(DynamicSystem):
    def __init__(self, b, g, l):
        self.b = b
        self.g = g
        self.l = l
    def f(self, x):
        th = x["th"]
        th_dot = x["th_dot"]
        return {"th":th_dot,
                "th_dot": - ( self.b * th_dot + self.g * sin(th) / self.l )}
               
class ActuatedPendulum(ControlledSystem):
    def __init__(self, b, g, l):
        self.b = b
        self.g = g
        self.l = l
    def f(self, x, u):
        th = x["th"]
        th_dot = x["th_dot"]
        return {"th":th_dot,
                "th_dot": u - ( self.b * th_dot + self.g * sin(th) / self.l )}
                
def UnactuatedPendulum( b, g, l ):
    return ClosedLoopSystem( ActuatedPendulum( b, g, l ), ZeroController() )  
