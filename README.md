# Course 3: Getting and Cleaning Data

## Objetctive
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 

## Documents
This repository contains the following documents: 

1. ```README.md```: Explians how all of the scripts work and how are they connected. 
2. ```CodeBook.md```: Describes the variables, the data, and all of the transformation performed to celan up the data. 
3. ```run_analysis.R```: Creates a tidy data set with the averages of each variable for each activity and subject.

## Instructions for ```run_analysis.R```
You should create one R script called ```run_analysis.R``` that does the following: 

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set.
4. Label the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps on how to work with ```run_analysis.R```
The following are the steps that you must follow prior to run run_analysis.R:

1. Download the data source to your local drive.
2. Put run_analysis.R in the parent folder. 
3. Change the working directory on line 28.
4. Run source("```run_analysis.R```"). 
5. A new file "```tidydata.txt```" will be created in the working directory. 

## Dependencies
In order for ```run_analysis.R``` to run correctly, we'll need the libraries data.table and plyr. Both of them are installed at the beginning of the script. 
