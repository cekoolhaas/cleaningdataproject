library(data.table)
library(dplyr)
##First make sure to read the files that will describe the data
featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

##Read all the files from the train folder
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

##Read all the files from the test folder
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

##Put all the subject, activity, and features sets together
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

##The items in featureNames[2] become the column names for features
colnames(features) <- t(featureNames[2])

##Define the columns in activity and subject sets
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"

##Merge them together!
completeData <- cbind(features,activity,subject)

##Now let's get the measurement means and SD's:
##We pull anything in completeData's indices that have means or standard deviations in them
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

##562 and 563 have activity and subject data, so we add it to our collection
requiredColumns <- c(columnsWithMeanSTD, 562, 563)

##extractedData will be the final variable holding the extracted information about mean & SD
extractedData <- completeData[,requiredColumns]

##Now, in order to use descriptive activity names, we need to change the data in activity from
##numeric to character.
extractedData$Activity <- as.character(extractedData$Activity)

##activityLabels has the names for the Activity data, so we assign them to it
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

##Now that the names are set, let's factor the activity variable
extractedData$Activity <- as.factor(extractedData$Activity)


##Let's give the variables more descriptive names by getting rid of confusing abbreviations
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

##Lastly we make an independent data set with variable averages for activity and subject
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

##Create and export the tidy data into a file called Tidydata.txt!
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidydata.txt", row.names = FALSE)





