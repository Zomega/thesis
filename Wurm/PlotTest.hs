import Plot.VectorField
import Utils.MatrixIO
import Utils.Grid

import Data.Matrix

mat = fromLists [[1]]

f (x,y) = (y - x^2 - 1, 1 + x - y^2)


pendulum_dynamics g m l b torque (th, th_dot)
    = (th_dot, torque - g * sin( th ) / l - b * th_dot)

g (x1,x2) = (((-6) * x1 /(1 + x1^2)^2) + 2*x2, (-2) * ( x1 + x2 ) / ( 1+ x1^2 )^2)

h (x1,x2) =  (x2, x1**3 -x1 - x2)

j (x1,x2) =  (x2 - (x1^3), (-1)*(x2 ^ 3 + x1))

main
    = do
        let gridspec = (FloatRange (-6.28) 6.28 30, FloatRange (-4) 4 30)
        let (x,y) = mgrid gridspec
        let (u,v) = mapOverGrid (pendulum_dynamics 10 30 5.0 0.1 0) gridspec
        raw_streamplot x y u v
	let (u,v) = mapOverGrid (pendulum_dynamics 10 30 4.0 0.1 0) gridspec
        raw_streamplot x y u v
        --raw_quiverplot x y u v
