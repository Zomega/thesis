function collisionFree = isCollisionFree(Obs,xy)

collisionFree = true;

a = size(Obs);

for i = 1:(a(2))
    xi = Obs{i}; % Each column is a point (x,y)
    x0 = xy'

    X_i = xi(1,:)';
    X_0 = x0(1,:)';

    Y_i = xi(2,:)';
    Y_0 = x0(2,:)';

    hull = convhull(X_i,Y_i);
    collisionFreeI = ~ inpolygon(X_0, Y_0, X_i(hull), Y_i(hull))';
    collisionFree = collisionFree && collisionFreeI;
end
end

