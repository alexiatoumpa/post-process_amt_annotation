%% %%  Proccess Annotation Files from Crowdsourcing %% %%
%
% Copyrights © 2017, Alexia Toumpa , All Rights Reserved
%
% Contact email: scat [at] leeds [dot] ac [dot] uk
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize your workspace
clear;clc;

filename_act = '../../Desktop/annotation_files/annotation_232323.txt';
filename_ans = '../../Desktop/annotation_files/qualTestAnswers_232323.txt';

filename_dir = '../../Desktop/annotation_files/';

delimiter = ',';

formatSpec_act = '%s %u %u';
%   Format: annotation.txt
%   #video <vid_id>
%   <start_time>, <end_time>, <activity_label>
%   ...
%   #video <vid_id>
%   <start_time>, <end_time>, <activity_label>
%   ...
formatSpec_ans = '%u %c %u';
%   Format: qualTestAnswers.txt
%   #video <vid_id>
%   <ans1>, <ans2>, <duration_of_assignment>

files = dir(filename_dir);
for k=1:length(files)
    filenames = files(k).name;
end

[data_vid_act, data_act] = readmyfile(filename_act,formatSpec_act, delimiter);
[data_vid_ans, data_ans] = readmyfile(filename_ans,formatSpec_ans, delimiter);


%data_act{2}(3) %parse a column vector: data_act{X}(Y), where 1<X<3 , 1<Y<N
                %and N = total annotations

%data_ans{3} %parse elements: data_ans{1,X},where 1<X<4

%%      FUNCTIONS       %%

% Read file function :
% Input: the file's path, the data format, the delimiter
% Output: the video's ID, the data scructured in column vectors
function [data_vid, data] = readmyfile (filename, formatSpec, delimiter)
    fprintf('Loading file...');
    fileID = fopen(filename);
    data_vid = textscan(fileID, '#video %u', 1, 'Delimiter', '\n');
    data = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'ReturnOnError', false);
    fclose(fileID);
    fprintf('Done\n');
end