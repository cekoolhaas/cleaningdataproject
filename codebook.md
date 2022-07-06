The code in run_analysis.R will perform the transformations to the given data set according to the course's instructions.

1. First, the user must download the data set under a folder titled UCI HAR Dataset.
2. The packages dplyr and data.table are loaded into the library. 
3. A list of variables and their assigned data are as follows:
featureNames <- features.txt
activityLabels <- activity_labels.txt
subjectTrain <- subject_train.txt
activityTrain <- y_train.txt
featuresTrain <- X_train.txt
subjectTest <- subject_test.txt
activityTest <- y_test.txt
featuresTest <- X_test.txt

4. Merging the data goes as follows:
subject is created by using rbind on subjectTrain and sibjectTest
activity is created by using rbind on activityTrain and activityTest
features is created by using rbind on featuresTrain and featuresTest
completeData is created by using cbind on subject, activity, and features


5. Extracting mean and standard deviation measurements go as follows:
columnsWithMeansSTD is created by using grep to extract information regarding means or standard deviations from completeData.
requiredColumns is created by concatenating columnsWithMeansSTD and columns that contain the activity and subject data.
extractedData is the variable that holds the necessary data about mean and SD measurements from completeData and requiredColumns.

6. To set descriptive activity names, the data in activity is changed from numeric to character values.
Then, existing variable names are renamed more descriptively. 
"Acc" is changed to "Accelerometer",
"Gyro" is changed to "Gyroscope",
"BodyBody" is changed to "Body",
"Mag" is changed to "Magnitude",
"^t" is changed to "Time",
"^f" is changed to "Frequency",
"tBody" is changed to "TimeBody",
"-mean()" is changed to "Mean",
"-std()" is changed to "STD",
"-freq()" is changed to "Frequency",
"angle" is changed to "Angle",
and "gravity" is changed to "Gravity".

7. Finally, the script creates a second, independent tidy data set with the average of each variable for each activity and each subject using write.table() and names it Tidydata.txt. 
