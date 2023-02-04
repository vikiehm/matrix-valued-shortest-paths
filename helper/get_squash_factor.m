function [delta_max] = get_squash_factor(files)
%calculates squash factor for files 
 delta_max = 0;
for i=1:numel(files)
    [V,~] = extract_vertices_faces(files(i));
    V = V - mean(V);
    dist = max(sqrt(sum(V.^2,2)));
    delta_max = max(dist, delta_max);
end
end

