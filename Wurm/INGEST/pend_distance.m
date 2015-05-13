function dist = pend_distance( vert1, vert2 )

n1 = normalize_vert(vert1);
n2 = normalize_vert(vert2);
wrap = [2*pi, 0];
dist = min([norm(n1-n2), norm(n1-n2 + wrap), norm(n1-n2-wrap)]);

end

