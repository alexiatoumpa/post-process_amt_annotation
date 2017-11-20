%% %%  Proccess Annotation Files from Crowdsourcing %% %%
%
% Copyrights © 2017, Alexia Toumpa , All Rights Reserved
%
% Contact email: scat [at] leeds [dot] ac [dot] uk
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize your workspace
clear;clc;
close all;

% Mac OS Filesystem
filename_act = '../../Desktop/annotation_files/annotation_232323.txt';
filename_ans = '../../Desktop/annotation_files/qualTestAnswers_232323.txt';
filename_dir = '../../Desktop/annotation_files/';

% Windows OS Filesystem
%filename_act = '../../Data/Annotations/annotation_232323.txt';
%filename_ans = '../../Data/Annotations/qualTestAnswers_232323.txt';
%filename_dir = '../../Data/Annotations/';


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

%% Sort Activities (Ascend sort)
% sort the activities in ascending order reference to the starting time
[Ascend_order indx] = sortrows(Data_mat);
%Data_act(:,1)(indx)
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

%% Timeline
timeline_unsorted = [Ascend_order(:,1); Ascend_order(:,2)];
timeline = sortrows(timeline_unsorted);
clear timeline_unsorted;

% Plot Timeline
figure
len = length(Ascend_order(:,1));
for i=1:len
    plot([Ascend_order(i,1), Ascend_order(i,2)],[i i], 'LineWidth', 10);
    hold on;
end
xlabel('Frames (time)')
ylabel('Activities (ordered)')
legend(char(Ascend_cells{1}),char(Ascend_cells{2}),char(Ascend_cells{3}), char(Ascend_cells{4}), char(Ascend_cells{5}), char(Ascend_cells{6}),char(Ascend_cells{7}),char(Ascend_cells{8}), 'Location', 'southeast')

%{
% Get percentage of annotations
ann_num = size(Data_act,1);
min_time = min(cell2mat(Data_act(:,2))); % time in frames
max_time = max(cell2mat(Data_act(:,3))); % time in frames

ann_perc = 100 * 7 / double((max_time-min_time));


%data_act{2}(3) %parse a column vector: data_act{X}(Y), where 1<X<3 , 1<Y<N
                %and N = total annotations

%data_ans{3} %parse elements: data_ans{1,X},where 1<X<4

%}

%% Time Intervals & Overlaps
% Create Time Intervals and Count activities at these intervals
ioverl=1;
len = length(timeline);
len_asc = length(Ascend_order(:,1));
pointer_start = timeline(1);
pointer_end = timeline(len);
pointer_stop = 0;
reached_end = false;
while ~reached_end
    if (~isequal(pointer_stop, pointer_end)) % go in the loop
        min_stop_value = pointer_end + 1;
        for i=len:-1:1
            if((timeline(i)>pointer_start) & (timeline(i)<min_stop_value))
                    min_stop_value = timeline(i);
                    pointer_stop = min_stop_value;
            end
        end
        pointer_stop;
        % check for activity overlaps
        sum_ovrl=0;
        for i=1:len_asc
            if(Ascend_order(i,1)<=pointer_start & Ascend_order(i,2)>pointer_start)
                sum_ovrl = sum_ovrl + 1;
            end
        end
        Overlaps(ioverl) = sum_ovrl;
        ioverl = ioverl + 1;
        pointer_start = pointer_stop;
    else
        reached_end = true; % terminate
    end
end

figure
barh(Overlaps)
xlabel('Overlaps')
ylabel('Time Intervals')
figure
plot(Overlaps)
xlabel('Time Intervals')
ylabel('Overlaps')

