function new_vert = extendEuclidean(closest_vert,xy)
dt = 0.05;
th = closest_vert(1);
th_dot = closest_vert(2);
verts = [];
for i = 1:50
    u = randf([-5,5]);
    th_ddot = u - 9.81 * sin(th) - 0.1 * th_dot;
    verts = [verts; th + dt*th_dot, th_dot + dt*th_ddot];
end
new_vert = closestVertexEuclidean(verts', xy);
new_vert = normalize_vert(new_vert);
end