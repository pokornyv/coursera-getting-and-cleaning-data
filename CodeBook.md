## Coursera "Getting and cleaning data" project Code Book

We use data set "_Smartphone-Based Recognition of Human Activities and Postural Transitions Data Set_" downloaded from UCI Machine Learining Repository, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

Data consist of 10299 measurements separated into 7352 training and 2947 test ones. 

* Files *x_train.txt* and *x_test.txt* contain 561 variables described in *features.txt* file. 
* Files *y_train.txt* and *y_test.txt* contain information about the activity (Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying, as described in *activity_labels.txt*). 
* Files *subj_train.txt* and *subj_test.txt* contain information about the subject (experiment was done on a population of 30 subjects).

We used the R script *run_nalaysis.R* to process the data. Training and test sets were merged using R *rbind()* and *cbind()* functions to form a single data set. We selected the columns containing information about mean and standard deviation of all 33 features (66 columns in total). (Warning: columns containing *meanFreq()* and *angle* do not hold info about mean values). Variable names were replaced by more descriptive ones (replacing t/f by Time/Freq, mean/std by Mean/StandardDev). Numbers in activity labels were replaced by descriptive text, so the table *activity_labels.txt* is not needed.

We also created a second data set containing the average values of each variable for each activity and each subject. This is done using the *aggregate* function that creates a data frame of dimension 180 (6 activities times 30 subjects) times 66. This data frame is stored as a table in file *avg.txt*.
