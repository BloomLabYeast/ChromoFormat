function chromoformat(coordinates, timepoints, cs_filename)
%CHROMOFORMAT Write ChromoShake outfiles.

%   Coordinates variable is a 3D matrix with each row corresponding to a mass,
%   The columns corresponding to X,Y, and Z positions,
%   and the 3rd dimension corresponding to timepoints.
%   Timepoints variable should contain the timepoints in double format
%   The size in the 3rd dimension should equal the number of timepoints

%   Written by Josh Lawrimore, June 2018

%% Error reporting
if ~(size(coordinates,3) == numel(timepoints))
    error('The size of the 3rd dimension of coordinates must equal the number of timepoints.');
end
%% Open file
fid = fopen(cs_filename,'w');
%% Write metadata section
%write out necessary meta line and structure lines
fprintf(fid, 'meta Unknown Simulation\n');
fprintf(fid, 'structure {\n');
fprintf(fid, '\tsee orignal simulation data\n');
fprintf(fid, '}\n');
fprintf(fid, '\n');
%% Write Color Section
%Print out MassColor section
fprintf(fid, 'MassColors\n');
for c = 1:size(coordinates,1) %1: number of masses
    fprintf(fid, '1\n'); %use only color 1 (red)
end
%print out blank line
fprintf(fid, '\n');
%% Write Coordinate Section
%create a waitbar
f_write = waitbar(0);
%Loop through Time and coordinates 
for n = 1:size(coordinates,3)
    waitbar(n/size(coordinates,3),f_write,'Writing Data');
    %print timeline
    fprintf(fid,'Time %f\n', timepoints(n));
    %loop to print coordinates in meters
    for i = 1:size(coordinates,1)
        fprintf(fid,'%g %g %g\n', ...
            coordinates(i,1,n),...
            coordinates(i,2,n),...
            coordinates(i,3,n));
    end
    %put a blank line between next time line
    fprintf(fid, '\n');
end
%close the waitbar
close(f_write);
%close the file
fclose(fid);

            