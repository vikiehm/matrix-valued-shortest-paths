function [] = visualize_indirect_direct(indir_path, filenames,clusterAssigments)
% visualizes the indirect paths that are shorter than the direct ones
num_matrices = size(indir_path,2);
close all
figure
sgtitle("Indirect paths that are shorter than direct ones. Press to continue");
for i=1:(num_matrices)
    idx = indir_path(i);
    curr_file = filenames(idx);
    [V,F] = extract_vertices_faces(curr_file);
    subplot(1,num_matrices,i);
    title(strcat("Shape ", curr_file));
    visualize_cluster(V,F,clusterAssigments{idx,1}, "tosca",curr_file);
end

end

