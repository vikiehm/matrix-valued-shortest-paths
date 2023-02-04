function [] = main()
% main function to calculate the shortest path for given shapes

bins = 10;
radius = 5;
num_cluster = 28;
num_percentiles = 150;
sigma = 1;
rng(1)

foldername = "tosca_cat";
files = get_files(foldername);
num_files = numel(files);

% TODO calculate shot features and save them to the data folder
% we added precomputed shot features for tosca cat in the data folder

% get cluster assignments
disp("Starting to calculate cluster assignments")
[~,cluster_assignments,~] = get_clustering(files, num_cluster);
disp("Cluster assignments calculated")

% calculate similarity matrices
disp("Starting to calculate similarity matrices")
[sim_matrices, ~] = get_sim_matrix_geodesic(foldername,bins, ...
    radius,num_cluster,num_percentiles, sigma,cluster_assignments);
disp("Similarity matrices calculated")

% calculate matrix-valued shortest paths
disp("Starting to calculate matrix-valued shortest paths")
[sps] = get_indirect_sps(sim_matrices);
disp("Matrix-valued shortest paths calculated")

for i=1:size(sps,2)
    visualize_indirect_direct(sps{1,i}, files, ...
        cluster_assignments);
    waitforbuttonpress
end

end

