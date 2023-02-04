function [points] = squash_in_unit_sphere(points)
% squash points in unit sphere

delta_max = get_squash_factor(files);
points = points-mean(points);
squashingFactor = 1/delta_max;
points = squashingFactor * points;
end

