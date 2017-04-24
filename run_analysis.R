# Reading the tables and labels:
# 1) train tables
x_train <- read.table("./data/dataset/train/X_train.txt")
y_train <- read.table("./data/dataset/train/y_train.txt")
subject_train <- read.table("./data/dataset/train/subject_train.txt")

# 2) test tables:
x_test <- read.table("./data/dataset/test/X_test.txt")
y_test <- read.table("./data/dataset/test/y_test.txt")
subject_test <- read.table("./data/dataset/test/subject_test.txt")

# 3) feature vector:
features <- read.table('./data/dataset/features.txt')

# 4) Reading activity labels:
activityLabels <- read.table('./data/dataset/activity_labels.txt')

## Assign the columnNames to all the tables
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

## Merges the training and the test sets to create one data set.
mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)

##merge train and test data sets to create one big data set
setAllInOne <- rbind(mrg_train, mrg_test)

## Extracts only the measurements on the mean and standard deviation for each measurement.
colNames <- colnames(setAllInOne)

mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names.


setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

## From the data set in step 4, creates a second, independent tidy data set with 
## the average of each variable for each activity and each subject.
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)

## write the tidy data set in a file
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
