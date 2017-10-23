# post-process_annotation README

## Introduction

With this file we post-process all annotations we get from our Crowdsourcing annotation system; Amazon Mechanical Turk. The annotations we get express recognized activities from turkers.
We save two files for every hit:

* one that denotes all the activities recognized; start and end time of activity as well as the label the turker wishes to put on the activity, and
* one that contains the two qualification questions which are needed to Submit their asnwers as well as the duration of the task needed to be completed and the starting time of the task.

##### File format

activity.txt:

> #video <vid_id>

> <activity_label>, <start_time>, <end_time>

> ...

qualTestAnswers.txt

> #video <vid_id>

> <ans1>, <ans2>, <duration_of_assignment>, <start_hit>