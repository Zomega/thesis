function closest_vert = closestVertexEuclidean(verts,point)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes 
min_index = -1;
min_distance = inf;
size_verts = size(verts);
for i = 1:size_verts(2)
    distance = pend_distance(verts(:,i), point);
    if distance < min_distance;
        min_distance = distance;
        min_index = i;
    end
end
closest_vert = verts(:,min_index)';
end

