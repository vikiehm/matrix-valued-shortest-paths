function [points, squashingFactor] = squashInUnitBox(points)
%SQUASHINUNITBOX Function that takes points and scales them so that they
%lie inside the unitbox

minPoints = min(points);
maxPoints = max(points);
deltaMinMax = max(maxPoints - minPoints);

% move points to unitbox
if deltaMinMax == 0
    error("Invalid Shape")
end

squashingFactor = 1/deltaMinMax;
points = squashingFactor * (points - minPoints);
points = points-mean(points);

end

