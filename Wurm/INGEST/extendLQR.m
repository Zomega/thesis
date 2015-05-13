function new_vert = extendLQR(closest_vert,xy,K)
dt = 0.03;
th = closest_vert(1);
th_dot = closest_vert(2);

u = -K * (closest_vert' - xy);
u = max(u, -5);
u = min(u, 5);
u

th_ddot = u - 9.81 * sin(th) - 0.1 * th_dot;
new_vert = [th + dt*th_dot, th_dot + dt*th_ddot];
new_vert = normalize_vert(new_vert);
end