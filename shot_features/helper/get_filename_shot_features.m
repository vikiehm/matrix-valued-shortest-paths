function [curr_filename] = get_filename_shot_features(curr_file, folder, num_bins, radius)
%returns the filename to save the shot features of a given 3D shape name  
[filepath, name, ~] = fileparts(curr_file);
folder_part = strcat('../data/', folder, '/'); 
curr_filename = strcat(folder_part,filepath,'/', name, '_features', ...
    '_bins_', string(num_bins), '_radius_', string(radius));
end

