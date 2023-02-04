function [ids,cluster_assignments,used_files] = get_clustering(files, numCluster,extra_infos)
%get spectral clustering using kmeans
cluster_assignments = cell(size(files,2),1);
used_files = [];
ids = [];
for i=1:size(files,2)
    filename = files(i);
    warning('') % Clear last warning message
    if nargin > 2
        extra_infos{1,3} = i;
        [V,F]=extract_vertices_faces(filename,extra_infos);
   else
        [V,F]=extract_vertices_faces(filename);
   end
    
    %V = V(randperm(size(V, 1)), :);
    X.vertices = V;
    X.faces = F;
    if size(V,1) > 50
        try
            idx = kmeans(X.vertices,numCluster,'MaxIter',10000);
            cluster_assignments{i,1} = idx;
        catch
            warning("Clustering was not possible")
        end
    else
        warning("not enough vertices")
    end
    
    ... run code ...
    [warnMsg, warnId] = lastwarn;
    if isempty(warnMsg)
       used_files = [used_files,filename];
       ids = [ids, i];
    else
        test = "";
    end
end
end

