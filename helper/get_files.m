function [files] = get_files(keyword)
%GET_FILES returns files for a given subfoldername
files = [];
curr_path = fileparts(which('get_files.m'));
curr_path =  strcat(curr_path, '/', '../data/', keyword, '/*.off');
files_struct = dir(curr_path);
for i=1:size(files_struct,1)
    curr_file_string = convertCharsToStrings(files_struct(i).name);
    files = [files, curr_file_string];
end
end

