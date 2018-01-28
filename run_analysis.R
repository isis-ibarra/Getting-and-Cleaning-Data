# Getting and Cleaning Data
# Week 4
# Peer-graded Assignment: Getting and Cleaning Data Course Project

# INSTRUCTIONS
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# DATA
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Installing required librarys
install.packages("data.table")
install.packages("plyr")

library(data.table)
library(plyr)

# Set working directory
setwd("~/Desktop/Data Science/Peer-graded Assignments/UCI HAR Dataset")


# Step 1. Merging the training data and the test sets to create one data set.

# Reading general data
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

# Readin train data
subject_train <-read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")

# Reading test data
subject_test <-read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")

# Assign column names to general data
colnames(activity_labels) <- c("activity_id","activity_type")

# Assign column names to train data
colnames(subject_train) <- "subject_id"
colnames(X_train) <- features [,2]
colnames(y_train) <- "activity_id"

# Assign column names to test data
colnames(subject_test) <- "subject_id"
colnames(X_test) <- features [,2]
colnames(y_test) <- "activity_id"

# Merging training data
train_data <- cbind(subject_train, X_train, y_train)

# Merging test data
test_data <- cbind(subject_test, X_test, y_test)

# Merging merged data
train_test_data <- rbind(train_data, test_data)


# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
colNames <- colnames(train_test_data)
data_mean_std <- train_test_data[,grepl("mean|std|subject_id|activity_id", colnames(train_test_data))]


# Step 3. Uses descriptive activity names to name the activities in the data set.
data_mean_std <- join(data_mean_std, activity_labels, by = "activity_id", match = "first")
data_mean_std <- data_mean_std [,-1]


# Step 4. Appropriately labels the data set with descriptive variable names.
names(data_mean_std) <- gsub("\\(|\\)", "", names(data_mean_std), perl  = TRUE)
names(data_mean_std) <- make.names(names(data_mean_std))
names(data_mean_std) <- gsub("Acc", "Accelerometer", names(data_mean_std))
names(data_mean_std) <- gsub("Freq", "Frequency", names(data_mean_std))
names(data_mean_std) <- gsub("^t", "Time", names(data_mean_std))
names(data_mean_std) <- gsub("^f", "Frequency", names(data_mean_std))
names(data_mean_std) <- gsub("BodyBody", "Body", names(data_mean_std))
names(data_mean_std) <- gsub("mean", "Mean", names(data_mean_std))
names(data_mean_std) <- gsub("std", "StandardDeviation", names(data_mean_std))
names(data_mean_std) <- gsub("Mag", "Magnitude", names(data_mean_std))
names(data_mean_std) <- gsub("Gyro", "Gyroscope", names(data_mean_std))
names(data_mean_std) <- gsub("Jerk", "SuddenMovementAcceleration", names(data_mean_std))


# Step 5. From the data set in step 4, creates a second, independent tidy data set 
#         with the average of each variable for each activity and each subject.
tidy_data_average <- ddply(data_mean_std, c("subject_id","activity_id"), numcolwise(mean))
write.table(tidy_data_average, file="tidydata.txt")

