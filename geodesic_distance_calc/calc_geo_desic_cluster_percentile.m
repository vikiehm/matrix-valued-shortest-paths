function [clusterPercentile] = calc_geo_desic_cluster_percentile(files, i, ...
    idx, numPercentiles, mode, bins, radius, extra_infos)
%CALC_GEO_DESIC_SIM_MATRIX Summary of this function goes here
%   Detailed explanation goes here
% set parameters

% based on Danil Kirsanov, 09/2007 example
filename = files(i);
if nargin > 7
    extra_infos{1,3} = i;
    [V,F]=extract_vertices_faces(filename,extra_infos);
else
    [V,F]=extract_vertices_faces(filename);
end
fv = struct('vertices', V, 'faces', F);

%[curr_fv_reduced, fv_idx] = downsampleMesh(fv, 3000);

numCluster = max(idx); 
% Calculate shot features for cluster
clusterFeatures = cell(numCluster,1);
for i=1:numCluster
    clusterNr = i;
    % get vertices of current cluster
    mask_cluster = idx == clusterNr;
    %Calculate shot features on that cluster
    [filepath,~,~] = fileparts(which('calc_geo_desic_cluster_percentile.m'));
    shot_f_name = strcat(filepath, '/../shot_features/', get_filename_shot_features(filename, mode, bins,radius));
    load(shot_f_name);
    %curr_shot_features = curr_shot_features(fv_idx,:);
    curr_shot_features = curr_shot_features(mask_cluster,:);
    clusterFeatures{i,1} = curr_shot_features;
end

% Calculate percentile of cluster
clusterPercentile = cell(numCluster,1);
step_size = 100/numPercentiles;
for i=1:numCluster
    curr_shot_features = clusterFeatures{i,1}; 
    %numPercentiles = size(curr_shot_features,1);
    %percentileM = zeros(numPercentiles, size(curr_shot_features,2));
    percentileM = prctile(curr_shot_features,step_size:step_size:100,1);
    clusterPercentile{i,1} = percentileM;
end
end

