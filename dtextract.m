function [coordinates, timepoints] = dtextract(mat_filename)
%%DT2CS converts datatank variable mat files to chromoShake
%%output format for chromoView visualization

%% Open the data file
data = load(mat_filename);
%% Parse variable names
vars = fieldnames(data);
%counter for indexing
i = 1;
%create a waitbar
f_read = waitbar(0);
%loop through variable cell array
for n = 1:length(vars)
    waitbar(n/length(vars),f_read,'Reading Data');
    %find variables starting with path
    %these contain the coordinates
    if contains(vars(n), 'Var')
        %split the variable to grab the index at the end of the variable
        split_str = strsplit(vars{n},'_');
        if length(split_str) == 2
            if ~isnan(str2double(split_str{2}))
                index{i,1} = str2double(split_str{2});
                index{i,2} = eval(sprintf('data.%s',vars{n}));
                index{i,3} = eval(sprintf('data.%s',strcat(vars{n},'_time')));
                i = i + 1;
            end
        end
    end
end
%close waitbar
close(f_read);
sorted = sortrows(index, 1);
clearvars -except sorted
timepoints = [sorted{:,3}];
raw = cat(3, sorted{1:end,2});
reorder = permute(raw, [2,1,3]);
coordinates = reorder(2:end, :,:);

