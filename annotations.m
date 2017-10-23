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
formatSpec_ans = '%u %c %u';

files = dir(filename_dir);
for k=1:length(files)
    filenames = files(k).name;
end

[data_vid_act, data_act] = readmyfile(filename_act,formatSpec_act, delimiter);
[data_vid_ans, data_ans] = readmyfile(filename_ans,formatSpec_ans, delimiter);

Data_act = [num2cell(data_act{:,1}) num2cell(data_act{:,2}) num2cell(data_act{:,3})];
Data_ans = [num2cell(data_ans{:,1}) num2cell(data_ans{:,2}) num2cell(data_ans{:,3})];

clear data_act; clear data_ans;

%dt_str = cell2mat(Data_act(:,1));
Data_mat = [cell2mat(Data_act(:,2)) cell2mat(Data_act(:,3))];

% sort the activities in ascending order reference to the starting time
Ascend_order = sortrows(Data_mat);
% sort the activity labels
as = size(Data_act,1);
for i=1:as
    for j=1:as
        if (isequal(Ascend_order(i,1), Data_act{j,2}) && isequal(Ascend_order(i,2), Data_act{j,3}))
            Act_label(i)=Data_act{j,1};
        end
    end
end

Act_label = Act_label.';

Ascend_cells = sortrows(Data_act, 2);


% Get percentage of annotations
ann_num = size(Data_act,1);
min_time = min(cell2mat(Data_act(:,2))); % time in frames
max_time = max(cell2mat(Data_act(:,3))); % time in frames

ann_perc = 100 * 7 / double((max_time-min_time));


%data_act{2}(3) %parse a column vector: data_act{X}(Y), where 1<X<3 , 1<Y<N
                %and N = total annotations

%data_ans{3} %parse elements: data_ans{1,X},where 1<X<4
