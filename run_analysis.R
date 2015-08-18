
## 1. You should create one R script called run_analysis.R that does the following. 
## 2. Merges the training and the test sets to create one data set.
## 3. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 4. Uses descriptive activity names to name the activities in the data set
## 5. Appropriately labels the data set with descriptive variable names. 
## 6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Read the training and test data set
library(reshape2)
train <- read.table("X_train.txt")
test <- read.table("X_test.txt")

## Read the activity number (1-6 referencing type of activity) and subject number(1-30 referencing each person) for train and test data set

activity_train <- read.table("Y_train.txt")
activity_test <- read.table("Y_test.txt")
subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")

#Read features and activity labels of the data set (2nd column)

features <- read.table("features.txt")[,2]
labels <- read.table("activity_labels.txt")[,2]

colnames(train) <- features
colnames(test) <- features

# 4. Uses descriptive activity names to name the activities in the data set

activity_train[,2] = labels[activity_train[,1]]
activity_test[,2] = labels[activity_test[,1]]

# 5. Appropriately labels the data set with descriptive variable names. 

colnames(activity_train) <- c("ID", "Activity_Name")
colnames(activity_test) <- c("ID", "Activity_Name")
colnames(subject_train) <- c("Subject")
colnames(subject_test) <- c("Subject")

#Create the full training and test set with individual, activity, and rate for traing and test set
xtrain <- cbind(subject_train, activity_train, train)
xtest <- cbind(subject_test, activity_test, test)

# 2. Merges the training and the test sets to create one data set.

fulldata <- rbind(xtrain, xtest)

# 3. Extracts only the measurements on the mean and standard deviation for each measurement.

columns <- grepl("mean|std", features)
mean_std <- fulldata[,columns]

#Melt data into ID variables and measure variables

id <- c("Subject", "ID", "Activity_Name")
measure <- setdiff(colnames(mean_std), id)

#Use melt function to create a moldable set based on our ID variables

dataMelt <- melt(mean_std, id = id, measure.vars = measure)

#Seperate each variable by Subject and Activity and then take the mean of each observartion

tidyset <- dcast(dataMelt, Subject + Activity_Name ~ variable, mean)

#Print data set to a file

write.table(tidyset, file = "./tidy_set.txt", row.name=FALSE)
