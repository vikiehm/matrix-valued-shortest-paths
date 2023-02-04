function [V] = rotate_mesh(V,F, degrees)
%rotates mesh by degree array around x,y,z axis
mesh = extendedObjectMesh(V,F);
mesh = rotate(mesh,degrees);
V = mesh.Vertices;
end

