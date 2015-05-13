function A = pend_dynamics_gradX( x, u )
th = x(1);

b = 0.1;
g =9.81;

A = [0, 1; -g * cos(th), -b];

end

