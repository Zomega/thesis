from DynamicSystem import *

class ControlledSystem:
    def sample_state(self):
        raise NotImplementedError()
    def sample_control(self):
        raise NotImplementedError()
    def f(self, x, t, u):
        raise NotImplementedError()
    def update(self, x, t, u, dt):
        new_x = {}
        for variable in x:
            dxdt = self.f(x,t,u)
            new_x[variable] = x[variable] + dt*dxdt[variable]
        return new_x
        
class Controller:
    def control_input(self, x):
        raise NotImplementedError()
    def control_input_tv(self, x, t):
        return self.control_input(x)
        
class ClosedLoopSystem(DynamicSystem):
    def __init__( self, system, controller ):
        self.system = system
        self.controller = controller
    def f(self, x, t):
        u = self.controller.control_input_tv(x, t)
        return self.system.f( x, u )
