### Overview
## You should create one R script called run_analysis.R that does the following. 
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each 
## measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with
##the average of each variable for each activity and each subject.

## Load the dplyr package
library (dplyr)

### 1st part
### load and merge the training and test sets

testx <- read.table("test/X_test.txt")
testy <- read.table("test/y_test.txt")
subj_test <- read.table("test/subject_test.txt")

trainx <- read.table("train/X_train.txt")
trainy <- read.table("train/y_train.txt")
subj_train <- read.table("train/subject_train.txt")

## create the x data set
x_data <- rbind(trainx, testx)

## create y data set
y_data <- rbind(trainy, testy)

## create subject data set
subj_data <- rbind(subj_train, subj_test)

### 2nd part 
### Extract the measurements on the mean and standard deviation for each \
### pmeasurement and place into readable columns 

features <- read.table("features.txt")

## get only columns with mean() or std() in their names
meanstdfeat <- grep("-(mean|std)\\(\\)", features[, 2])

## split the columns
x_data <- x_data[, meanstdfeat]

## assign the column names
names(x_data) <- features[meanstdfeat, 2]

### 3rd Part
### Describe activities with appropriate actvity names. 

## read in activities 

activity <- read.table("activity_labels.txt")

## correct activity names
y_data[, 1] <- activity[y_data[, 1], 2]

## column name
names(y_data) <- "activity"

### Step 4
### Appropriately label the data set with descriptive variable names


## column name subject
names(subj_data) <- "subject"

## Put it all together in single data set 
put_together <- cbind(x_data, y_data, subj_data)

### Step 5
### Tidy up 

finaldata <- ddply(put_together, .(subject, activity), function(x) 
    colMeans(x[, 1:66]))

## final tidy table

write.table(finaldata, "averages_data.txt", row.name=FALSE)
