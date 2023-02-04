function [sim_matrices,entropy_sim_m] = get_sim_matrix_geodesic(mode,bins, ...
    radius,numCluster,numPercentiles, sigma, cluster_assignments,extra_infos)
% calculate the similarity matrix between different shapes

% Get files for mode
files = get_files(mode);
num_files = size(files,2);
%files = files(ids);
extra_info_given = 0;

if nargin > 7
    extra_info_given = 1;
end

% Remove files that could not be clustered
ids = [];
for i=1:size(cluster_assignments,1)
    curr_cluster = cluster_assignments{i,1};
    if ~isempty(curr_cluster)
        ids = [ids, i];
    end
end

files = files(:,ids);
cluster_assignments = cluster_assignments(ids,:);
num_files = numel(ids);

% Calculater cluster percentile matrix
clusterPercentiles = cell(num_files,1);
for i=1:num_files
    cluster_assignment = cluster_assignments{i,1};
    if extra_info_given 
        currClusterPercentile = calc_geo_desic_cluster_percentile(files,i, ...
            cluster_assignment, numPercentiles, mode, bins, radius,extra_infos);
    else
        currClusterPercentile = calc_geo_desic_cluster_percentile(files,i, ...
            cluster_assignment, numPercentiles, mode, bins, radius);
    end
    clusterPercentiles{i,1} = currClusterPercentile;
end

% Calculate sim matrices of files

sim_matrices = cell(num_files,num_files);
entropy_sim_m = zeros(num_files,num_files);
for i=1:num_files

     currCluster1 = clusterPercentiles{i,1};
    for j=1:num_files
         currCluster2 = clusterPercentiles{j,1};
       if i>=j 
             continue
       end
        sim_matrix = zeros(numCluster,numCluster);
        for k=1:numCluster
             for l=1:numCluster
                     normDiff = norm(currCluster1{k,1}-currCluster2{l,1}, 'fro');
                     sim_matrix(k,l) = normDiff;
             end
        end
        % use gauss kernel
        sim_matrix = arrayfun(@(x) exp(-x^2/(sigma^2)), ...
            sim_matrix);
        % Calculate sinkhorn 
        norm_sim_matrix = sinkhorn(sim_matrix);
        sim_matrices{i,j} = norm_sim_matrix;
        entropy_sim_m(i,j) = entropy_fcn(sim_matrices{i,j});
    end
end

% make sim matrix full
for i=1:size(sim_matrices,1)
    for j=1:size(sim_matrices,2)
        if i > j
        sim_matrices{i,j} = sim_matrices{j,i}';
        end
    end
end

entropy_sim_m = entropy_sim_m + entropy_sim_m';
end

