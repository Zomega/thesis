function nvert = normalize_vert( vert )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
th = vert(1);
th_dot = vert(2);

while th >= 1.5 * pi
    th = th - 2 * pi;
end
while th < -0.5 * pi
    th = th + 2 * pi;
end
nvert = [th, th_dot];
end

