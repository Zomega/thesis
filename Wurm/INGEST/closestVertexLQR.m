function [closest_vert, min_index, K] = closestVertexLQR(verts,point)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes

x_0 = normalize_vert(point);
u_0 = 0;

A = pend_dynamics_gradX( x_0, u_0 );
B = pend_dynamics_gradU( x_0, u_0 );
R = [0.1];
Q = eye(2);
[K,S] = lqr(A,B,Q,R);

min_index = -1;
min_distance = inf;
size_verts = size(verts);
for i = 1:size_verts(2)
    distance = pend_distanceLQR(verts(:,i), point, S);
    if distance < min_distance;
        min_distance = distance;
        min_index = i;
    end
end
closest_vert = verts(:,min_index)';
end