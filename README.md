Peer-graded Assignment: Getting and Cleaning Data Course Project

This repository contains the instructions on how to prepare a dataset according to the Coursera class's instructions.

The datset used is the UCI Human Activity Recognition dataset, which can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The files this repository contains are:

codebook.md
This file is the codebook describing the variables and transformations performed on the data.

run_analysis.r
This file contains the code for preparing the data according to the course project, following these steps:
+Merges the training and the test sets to create one data set.
+Extracts only the measurements on the mean and standard deviation for each measurement.
+Uses descriptive activity names to name the activities in the data set
+Appropriately labels the data set with descriptive variable names.
+From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Tidydata.txt
This file is the exported tidy data set that results from following the steps in run_analysis.r