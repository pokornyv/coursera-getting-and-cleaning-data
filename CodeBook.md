## Coursera "Getting and cleaning data" project Code Book

We use data set "_Smartphone-Based Recognition of Human Activities and Postural Transitions Data Set_" downloaded from UCI Machine Learining Repository, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

Data consist of 10299 measurements separated into 7352 training and 2947 test ones. 

* Files *x_train.txt* and *x_test.txt* contain 561 attributes as described in *features.txt* file. 
* Files *y_train.txt* and *y_test.txt* containing information about the activity (Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying, as described in *activity_labels.txt*). 
* Files *subj_train.txt* and *subj_test.txt* contain information about the subject (experiment was done on a population of 30 subjects).

Training and test sets were merged using R _rbind()_ and _cbind()_functions to form one data set.

