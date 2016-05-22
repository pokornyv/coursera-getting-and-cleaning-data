## This is a script to create a tidy data set from original data 
## collected by accelerometers from the Samsung Galaxy S smartphone.
## Vladislav Pokorny, 2016, pokornyv@fzu.cz

# download data if necessary
if (!dir.exists("UCI HAR Dataset")) {
    dataURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    dir.create('UCI HAR Dataset')
    download.file(dataURL, 'UCI-HAR-dataset.zip')
    unzip('UCI-HAR-dataset.zip')
}

# find columns that store info about mean and std
features_info_DF <- read.table(file.path('UCI HAR Dataset','features.txt'))
icols <- grep("((.*)-mean\\((.*))|((.*)-std\\((.*))",features_info_DF[,2])
print(paste(length(icols)," variables store mean or standard deviation values"))
features_info_DF <- features_info_DF[icols,]

# change names of variables to be more descriptive
features_info_DF[,2] <- gsub("\\(\\)","",features_info_DF[,2])
features_info_DF[,2] <- gsub("^t","Time",features_info_DF[,2])
features_info_DF[,2] <- gsub("^f","Freq",features_info_DF[,2])
features_info_DF[,2] <- gsub("Mag","Magnitude",features_info_DF[,2])
features_info_DF[,2] <- gsub("-mean","Mean",features_info_DF[,2])
features_info_DF[,2] <- gsub("-std","StandardDev",features_info_DF[,2])

# read data from files
x_train_DF    <- read.table(file.path('UCI HAR Dataset','train','X_train.txt'))
y_train_DF    <- read.table(file.path('UCI HAR Dataset','train','y_train.txt'))
subj_test_DF  <- read.table(file.path('UCI HAR Dataset','test','subject_test.txt'))
x_test_DF     <- read.table(file.path('UCI HAR Dataset','test','X_test.txt'))
y_test_DF     <- read.table(file.path('UCI HAR Dataset','test','y_test.txt'))
subj_train_DF <- read.table(file.path('UCI HAR Dataset','train','subject_train.txt'))

print(paste(nrow(x_train_DF)," measurements in train data set"))
print(paste(nrow(x_test_DF)," measurements in test data set"))

# merge test and train data sets using rbind()
x_join_DF    <- rbind(x_train_DF,x_test_DF)
y_join_DF    <- rbind(y_train_DF,y_test_DF)
subj_join_DF <- rbind(subj_train_DF,subj_test_DF)

# select columns from data set (x) that contain mean and std data
x_join_DF <- x_join_DF[icols]

# read in names for activity labels and replace numbers in data set (y) by text
activity_info_DF <- read.table(file.path('UCI HAR Dataset','activity_labels.txt'))
for (i in 1:nrow(activity_info_DF)) { 
    y_join_DF[,1] <- gsub(activity_info_DF[i,1],activity_info_DF[i,2],y_join_DF[,1])
}

# add names to columns in data frames
colnames(x_join_DF) <- features_info_DF[,2]
colnames(y_join_DF) <- "Activity"
colnames(subj_join_DF) <- "Subject"

# marge info from accelerators(x) with activity labels (y) and subject labels (subj)
data_DF <- cbind(x_join_DF,y_join_DF,subj_join_DF)

# create an independent tidy data set with the average of each variable for each activity and each subject.
avg_DF <- aggregate(x=data_DF[, !names(data_DF) %in% c("Activity", "Subject")], by=list(Activity=data_DF$Activity, Subject=data_DF$Subject), FUN=mean)
write.table(avg_DF, 'avg.txt', row.names = F)
