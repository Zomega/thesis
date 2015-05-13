def nearest( x, xs ):
    def distance_sq(x,y):
        x = numpy.array(x)
        y = numpy.array(y)
        return numpy.linalg.norm(x-y)
    return min(xs, key=lambda y:distance_sq(x,y))
    
def extend( x ):
    u = random.uniform(-1.0,1.0)
    def f( x, u ):
        th, th_dot = x
        return (th_dot, standard_pendulum_th_ddot(b, g, l, th, th_dot, u) )
    def update( x, u, dt ):
        x1, x2 = x
        x1_dot, x2_dot = f( x, u )
        return (x1 + dt * x1_dot, x2 + dt * x2_dot)
    return update( x, u, 0.1 )
    
def rrt( x_initial ):
    live = set([x_initial])
    all_p = set([x_initial])
    segs = []
    def sample_x():
        return (random.uniform(-40,40), random.uniform(-40,40))
    N = 10**5
    for i in range(N):
        if i%100 == 0:
            print float(100*i)/(N), "%"
        x_goal = sample_x()
        if len(live) < 50:
            x_root = nearest( x_goal, live )
        else:
            x_root = nearest( x_goal, random.sample(live, 40) )
        if not x_root in live:
            continue
        live.remove(x_root)
        for j in range(3):
            x_extended = extend(x_root)
            live.add(x_extended)
            all_p.add(x_extended)
            segs.append([x_root, x_extended])
    return segs
