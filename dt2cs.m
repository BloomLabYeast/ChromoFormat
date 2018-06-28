function dt2cs(mat_filename, cs_filename)
%DT2CS Converts datatank mat file to chromoShake outfiles.

[coordinates, timepoints] = dtextract(mat_filename);
chromoformat(coordinates, timepoints, cs_filename);

