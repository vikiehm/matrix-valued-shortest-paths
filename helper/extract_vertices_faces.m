function [V,F] = extract_vertices_faces(filename, extra_infos)
% extracts vertices and faces from a given file, at the moment 
% .ply, .obj and .off files are supportes 
% add files as a paramter to stash the vertices and faces into an unit
% sphere
% the extra info cell array contains extra information that are relevant
% for the vertices and faces. 
% extra_infos: {rot_limit, iteration, idx, files}
    do_rotation = 0;
    if nargin > 1
        rot_limit = extra_infos{1,1};
        iteration = extra_infos{1,2};
        idx = extra_infos{1,3};
        mode = extra_infos{1,4};
        do_rotation = 1;
    end
    [~,~,ext] = fileparts(filename);
    if ext == ".off"
        x = load_off(filename);
        V = x.VERT;
        F = x.TRIV;
    elseif ext == ".ply"
        [V,F] = read_ply(filename);
    elseif ext ==".obj"
        x = readObj(filename);
        V = x.v;
        F = x.f.v;
    elseif ext ==".mat"
        load(filename);
        V = [surface.X surface.Y surface.Z];
        F = surface.TRIV;
    else
        error("File Extension not supported");
    end
    
    if do_rotation
        filename = strcat('random_eul_new.mat');
        load(filename);
        randR = random_eul{1,idx};
        V = V * randR;
        V = squash_in_unit_sphere(V, mode);
    end
end

