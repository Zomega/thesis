from Trajectory import *

class DynamicSystem:
    def sample_state(self):
        raise NotImplementedError()
    def f(self, x, t):
        raise NotImplementedError()
    def update(self, x, t, dt):
        new_x = {}
        for variable in x:
            dxdt = self.f(x, t)
            new_x[variable] = x[variable] + dt*dxdt[variable]
        return new_x
    def simulate(self, x_initial, t, dt=0.0001):
        time = 0
        x = x_initial
        traj = Trajectory()
        while time < t:
            traj.register(time, x)
            x = self.update( x, time, dt )
            time += dt
        return traj
