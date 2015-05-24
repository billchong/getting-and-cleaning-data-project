library(dplyr)
rm(list=ls())
setwd("C:/Users/Bill/Documents/R/workspace/GettingAndCleaningData/Project/UCI HAR Dataset")

# 1. Merge the training and the test sets to create one data set.
###########################################################################
# Input the feature and activity vectors
###########################################################################

features     <- read.table("features.txt", header=FALSE)
activity     <- read.table("activity_labels.txt", header=FALSE)


###########################################################################
# Prep the training data
###########################################################################

subjectTrain <- read.table("train/subject_train.txt", header=FALSE)
xTrain       <- read.table("train/X_train.txt", header=FALSE)
yTrain       <- read.table("train/y_train.txt", header=FALSE)


colnames(activity) = c("ActivityID", "Activity")
colnames(subjectTrain) = "SubjectID"
colnames(yTrain) = "ActivityID"
colnames(xTrain) = features[,2]

# Create training data table by column binding yTrain, subjectTrain and xTrain
trainingData <- cbind(yTrain, subjectTrain, xTrain)

###########################################################################
# Prep the test data
###########################################################################

subjectTest   <- read.table("test/subject_test.txt", header=FALSE)
xTest         <- read.table("test/X_test.txt", header=FALSE)
yTest         <- read.table("test/y_test.txt", header=FALSE)

colnames(subjectTest) = "SubjectID"
colnames(yTest) = "ActivityID"
colnames(xTest) = features[,2]

# Create test data table by column binding yTest, subjectTest and xTest
testData      <- cbind(yTest, subjectTest, xTest)

###########################################################################
# Create big data by merging both the training and test data row by row
###########################################################################

tBigData <- rbind(trainingData, testData)
colNames <- colnames(tBigData)

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
###########################################################################
# Search for key words in the column names and create logical vector
# for column selection
###########################################################################
selectV1 <- grepl ("mean", colNames) | grepl ("std", colNames)
selectV2 <- grepl ("ActivityID", colNames) | grepl ("SubjectID", colNames)

colSelectVector = selectV1 | selectV2

###########################################################################
# Create the final data set using only select column names
###########################################################################
bigData <- tBigData[,colSelectVector]

# 3. Use descriptive activity names to name the activities in the data set
bigData <- merge (activity, bigData, by='ActivityID')


# 4. Appropriately label the data set with descriptive activity names. 
###########################################################################
# Tidy the column names
###########################################################################

colNames = colnames(bigData) ;
colNames <- gsub("BodyBody", "Body", colNames)
colNames <- gsub("mean", "Mean", colNames)
colNames <- gsub("std", "StdDev", colNames)
colNames <- gsub("Mag", "Magnitude", colNames)
colNames <- gsub("^t", "time", colNames)
colNames <- gsub("^f", "freq", colNames)

colnames(bigData) <- colNames

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
###########################################################################
# Create the summary data set from bigData
###########################################################################

tidyD <- aggregate(select(bigData, -(ActivityID:SubjectID)), 
                      by=list(bigData$SubjectID, bigData$ActivityID), mean)

tidyD <- merge(activity, tidyD, by.x='ActivityID', by.y='Group.2')
colNames = colnames(tidyD)
colNames[3] = 'SubjectID'
colnames(tidyD) = colNames

###########################################################################
# Export the tidyData set
# write.table is crap. Data does not align with headers
###########################################################################

tidyD <- apply(tidyD, 2, format)
write.table(format(tidyD, digits=10),'tidyData.txt',row.names=FALSE, sep='\t'); 
