%% %%  Proccess Annotation Files from Crowdsourcing %% %%
%
% Copyrights © 2017, Alexia Toumpa , All Rights Reserved
%
% Contact email: scat [at] leeds [dot] ac [dot] uk
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read file function :
% Input: the file's path, the data format, the delimiter
% Output: the video's ID, the data scructured in column vectors
function [data_vid, data] = readmyfile (filename, formatSpec, delimiter)
    fprintf('Loading file...');
    fileID = fopen(filename);
    data_vid = cell2mat(textscan(fileID, '#video %u', 1, 'Delimiter', '\n'));
    data = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'ReturnOnError', false);
    fclose(fileID);
    fprintf('Done\n');
end