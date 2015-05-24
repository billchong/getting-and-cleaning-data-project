# Getting and Cleaning Data Project
Author: Bill Chong

## Description
This is the Codebook which describes the variables, data and transformations used in the Getting and Cleaning Data Project.

## About the Data Set

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training 
data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


## Data Transformations

### Step 1 - Merge Training and Data Sets to Create One Table

Input the UCI HAR Data Set from (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and read the following files

- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

rename the columns of y_train.txt, y_test.txt, activity_labels.txt and subject_train.txt to use the descriptive names of "ActivityID", "Activity", "SubjectID" moving forward.

- create table 1 using y_train, subject_train, x_train by column binding
- create table 2 using y_test, subject_test, x_test by column binding
- create table 3 by row binding table 1 and table 2 to integrate the data

### Step 2 - Extract only the measurements on the mean and standard deviation for each measurement

Create table 4 by subsetting table 3 by selecting only column names which include the keywords "mean","std","ActivityID" and "SubjectID".

### Step 3 - Use descriptive activity names to name the activities in the data set

Merge table 4 with "activity_labels.txt" to create table 5 with descriptive activity names.

### Step 4 - Appropriately label the data set with descriptive variable names. 

Modify the column names of table 5 to have more descriptive names using gsub.

### Step 5 - Create another independent tidy data set with the average of each variable for each activity and subject

Create table 6 from table 5 by calculating the means for each activity and subject. The following excerpt from RStudio lists the variables are  table 6

 [1] "ActivityID"                           "Activity"                            
 [3] "SubjectID"                            "timeBodyAcc-Mean()-X"                
 [5] "timeBodyAcc-Mean()-Y"                 "timeBodyAcc-Mean()-Z"                
 [7] "timeBodyAcc-StdDev()-X"               "timeBodyAcc-StdDev()-Y"              
 [9] "timeBodyAcc-StdDev()-Z"               "timeGravityAcc-Mean()-X"             
[11] "timeGravityAcc-Mean()-Y"              "timeGravityAcc-Mean()-Z"             
[13] "timeGravityAcc-StdDev()-X"            "timeGravityAcc-StdDev()-Y"           
[15] "timeGravityAcc-StdDev()-Z"            "timeBodyAccJerk-Mean()-X"            
[17] "timeBodyAccJerk-Mean()-Y"             "timeBodyAccJerk-Mean()-Z"            
[19] "timeBodyAccJerk-StdDev()-X"           "timeBodyAccJerk-StdDev()-Y"          
[21] "timeBodyAccJerk-StdDev()-Z"           "timeBodyGyro-Mean()-X"               
[23] "timeBodyGyro-Mean()-Y"                "timeBodyGyro-Mean()-Z"               
[25] "timeBodyGyro-StdDev()-X"              "timeBodyGyro-StdDev()-Y"             
[27] "timeBodyGyro-StdDev()-Z"              "timeBodyGyroJerk-Mean()-X"           
[29] "timeBodyGyroJerk-Mean()-Y"            "timeBodyGyroJerk-Mean()-Z"           
[31] "timeBodyGyroJerk-StdDev()-X"          "timeBodyGyroJerk-StdDev()-Y"         
[33] "timeBodyGyroJerk-StdDev()-Z"          "timeBodyAccMagnitude-Mean()"         
[35] "timeBodyAccMagnitude-StdDev()"        "timeGravityAccMagnitude-Mean()"      
[37] "timeGravityAccMagnitude-StdDev()"     "timeBodyAccJerkMagnitude-Mean()"     
[39] "timeBodyAccJerkMagnitude-StdDev()"    "timeBodyGyroMagnitude-Mean()"        
[41] "timeBodyGyroMagnitude-StdDev()"       "timeBodyGyroJerkMagnitude-Mean()"    
[43] "timeBodyGyroJerkMagnitude-StdDev()"   "freqBodyAcc-Mean()-X"                
[45] "freqBodyAcc-Mean()-Y"                 "freqBodyAcc-Mean()-Z"                
[47] "freqBodyAcc-StdDev()-X"               "freqBodyAcc-StdDev()-Y"              
[49] "freqBodyAcc-StdDev()-Z"               "freqBodyAcc-MeanFreq()-X"            
[51] "freqBodyAcc-MeanFreq()-Y"             "freqBodyAcc-MeanFreq()-Z"            
[53] "freqBodyAccJerk-Mean()-X"             "freqBodyAccJerk-Mean()-Y"            
[55] "freqBodyAccJerk-Mean()-Z"             "freqBodyAccJerk-StdDev()-X"          
[57] "freqBodyAccJerk-StdDev()-Y"           "freqBodyAccJerk-StdDev()-Z"          
[59] "freqBodyAccJerk-MeanFreq()-X"         "freqBodyAccJerk-MeanFreq()-Y"        
[61] "freqBodyAccJerk-MeanFreq()-Z"         "freqBodyGyro-Mean()-X"               
[63] "freqBodyGyro-Mean()-Y"                "freqBodyGyro-Mean()-Z"               
[65] "freqBodyGyro-StdDev()-X"              "freqBodyGyro-StdDev()-Y"             
[67] "freqBodyGyro-StdDev()-Z"              "freqBodyGyro-MeanFreq()-X"           
[69] "freqBodyGyro-MeanFreq()-Y"            "freqBodyGyro-MeanFreq()-Z"           
[71] "freqBodyAccMagnitude-Mean()"          "freqBodyAccMagnitude-StdDev()"       
[73] "freqBodyAccMagnitude-MeanFreq()"      "freqBodyAccJerkMagnitude-Mean()"     
[75] "freqBodyAccJerkMagnitude-StdDev()"    "freqBodyAccJerkMagnitude-MeanFreq()" 
[77] "freqBodyGyroMagnitude-Mean()"         "freqBodyGyroMagnitude-StdDev()"      
[79] "freqBodyGyroMagnitude-MeanFreq()"     "freqBodyGyroJerkMagnitude-Mean()"    
[81] "freqBodyGyroJerkMagnitude-StdDev()"   "freqBodyGyroJerkMagnitude-MeanFreq()"
