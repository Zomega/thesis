# Allows for partial data, etc.    
class Trajectory:
    def __init__(self):
        self.timeline = []
    def register( self, t, obs ):
        self.timeline.append((t,obs))
        # TODO Sort timeline...
    def getSequence(self, name):
        T = []
        X = []
        for time, entry in self.timeline:
            if name in entry:
                T.append(time)
                X.append(entry[name])
        return T, X
    def estimate(self, t):
        # TODO: Find surrounding frames, linearly interpolate....
        for time, entry in self.timeline:
            if time > t:
                return entry
        return {}

