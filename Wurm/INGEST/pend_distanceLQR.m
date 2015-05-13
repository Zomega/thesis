function dist = pend_distanceLQR( x, x_0, S )

x = normalize_vert(x);
x_0 = normalize_vert(x_0);

wrap = [2*pi, 0];

dx = x - x_0;

dist = min([dx*S*dx', (dx+wrap)*S*(dx+wrap)', (dx-wrap)*S*(dx-wrap)']);

end