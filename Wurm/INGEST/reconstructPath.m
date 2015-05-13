function path = reconstructPath(verts, parents, end_index)
path = []
index = end_index
while index ~= -1
    path = [verts(:,index)';path]
    index = parents(index)
end
end