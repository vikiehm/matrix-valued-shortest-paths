function [] = visualize_cluster(V,F, idX, mode, color)
%visualize clusters in a 3D shape
% idX: cluster assignment
% if mode = smal: idx contains the index of the current figure (no clusters
% are shown, one color per figure)
% V: vertices
% F: faces

colors = repmat([176/255 226/255 1], size(V,1),1); 

if(nargin > 3)
    if mode == "smal"
        V = rotate_mesh(V,F, [0 0 -90]);
    elseif contains(mode, "michael")
        V = rotate_mesh(V,F, [0 0 -90]);
    elseif contains(mode, "victoria")
        V = rotate_mesh(V,F, [0 0 -90]);
    elseif contains(mode, "tosca")
        V = rotate_mesh(V,F, [0 90 -90]);
     elseif contains(mode, "chair")
        V = rotate_mesh(V,F, [0 160 0]);
    end
end

V = squashInUnitBox(V);
X.vertices = V;
X.faces = F;


axis equal;
light

max_x = max(V(:,1),[],'all');
max_y = max(V(:,2),[],'all');

min_x = min(V(:,1),[],'all');
min_y = min(V(:,2),[],'all');

margin = 0.1;
if mode == "smal"
    xlim([min_x max_x]);
    ylim([min_y max_y]);
end

xlim([-1 1.1]);
ylim([-1 1.1]);

patch(X, ... 
        'edgecolor', 'none', ...
        'facecolor', 'flat',...
        'FaceVertexCData', colors,...
        'FaceAlpha', 1,...
        'FaceLighting', 'flat','AmbientStrength',0.3, ...
        'DiffuseStrength',0.8,'SpecularStrength', 0.5, ...
        'SpecularExponent', 10);
    
hold on

end

