#CodeBook for Cleaning the Data for Human Activity Recognition Using Smartphone

A full description of the input data is available at the site:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

##Tidy Data Set

###Features
 "subject"                         "activity"                        "tBodyAcc-mean()-X"                
 "tBodyAcc-mean()-Y"               "tBodyAcc-mean()-Z"               "tGravityAcc-mean()-X"             
 "tGravityAcc-mean()-Y"            "tGravityAcc-mean()-Z"            "tBodyAccJerk-mean()-X"            
 "tBodyAccJerk-mean()-Y"           "tBodyAccJerk-mean()-Z"           "tBodyGyro-mean()-X"               
 "tBodyGyro-mean()-Y"              "tBodyGyro-mean()-Z"              "tBodyGyroJerk-mean()-X"           
 "tBodyGyroJerk-mean()-Y"          "tBodyGyroJerk-mean()-Z"          "tBodyAccMag-mean()"               
 "tGravityAccMag-mean()"           "tBodyAccJerkMag-mean()"          "tBodyGyroMag-mean()"              
 "tBodyGyroJerkMag-mean()"         "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"                
 "fBodyAcc-mean()-Z"               "fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"            
 "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"           "fBodyAccJerk-mean()-Y"            
 "fBodyAccJerk-mean()-Z"           "fBodyAccJerk-meanFreq()-X"       "fBodyAccJerk-meanFreq()-Y"        
 "fBodyAccJerk-meanFreq()-Z"       "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"               
 "fBodyGyro-mean()-Z"              "fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"           
 "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"              "fBodyAccMag-meanFreq()"           
 "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"          
 "fBodyBodyGyroMag-meanFreq()"     "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-meanFreq()"  
 "tBodyAcc-std()-X"                "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"                 
 "tGravityAcc-std()-X"             "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"              
 "tBodyAccJerk-std()-X"            "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"             
 "tBodyGyro-std()-X"               "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"                
 "tBodyGyroJerk-std()-X"           "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"            
 "tBodyAccMag-std()"               "tGravityAccMag-std()"            "tBodyAccJerkMag-std()"            
 "tBodyGyroMag-std()"              "tBodyGyroJerkMag-std()"          "fBodyAcc-std()-X"                 
 "fBodyAcc-std()-Y"                "fBodyAcc-std()-Z"                "fBodyAccJerk-std()-X"             
 "fBodyAccJerk-std()-Y"            "fBodyAccJerk-std()-Z"            "fBodyGyro-std()-X"                
 "fBodyGyro-std()-Y"               "fBodyGyro-std()-Z"               "fBodyAccMag-std()"                
 "fBodyBodyAccJerkMag-std()"       "fBodyBodyGyroMag-std()"          "fBodyBodyGyroJerkMag-std()"   

###Tidy Data Set
The tidy data set shows the average and standard deviation of every feature for each activity and subject. 
Subject id identifies the person undertaking the activities. The activity categories are described in the following link:  
https://www.youtube.com/watch?v=XOEN9W05_4A   
The description of other variables can be found in the link where the input data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

##Transformations
###Merging the Train and Test Data
First the train data was loaded and X_train.txt.  
trainDF <- read.table(XtrainPath)  
Then, the values of activities and subjects are loaded from y_train.txt and 
subject_train.txt.  
y <- read.table(ytrainPath)  
s <- read.table(strainPath)  
These two latter files contains the id values for activity and subjcet respectively. These values 
are added as new columns to the data set.  
trainDF$activity <- y$V1  
trainDF$subject <- s$V1  
The dataframe in the code is called trainDF.  
The procedure for loading the test data is the same, except that we read the data from X_test.txt, y_test.txt and 
subject_test.txt, and the dataframe is called testDF.  
testDF <- read.table(XtestPath)  
y <- read.table(ytestPath)  
s <- read.table(stestPath)  
testDF$activity <- y$V1  
testDF$subject <- s$V1  
then we combine the train and test data by adding the rows of testDF to trainDF. The resulted dataframe is called allData.  
allData <- rbind(trainDF, testDF)  

###Change the Column Names
The name of the column is changed by its description available in features.txt. We change the column names of
train and test dataframe before merging them.  
names(trainDF) <- f$V2  
names(testDF) <- f$V2  

###Subsetting the Data to the Measurements of Average and Standard Deviation
The data in allData dataframe is subsetted to the features representing the average and standard deviation. 
To subset the feature we search for the terms "-mean()" and "-std()" in the column name and filter them.  
DFnames <- names(allData)  
meanNames <- DFnames[grep("-mean()", DFnames)]  
stdNames <- DFnames[grep("-std()", DFnames)]  
keptNames <- union(meanNames, stdNames)  
Then, we add the columns "activity" and "subject", and subset the data, accordingly.  
otherNames <- c("activity", "subject")  
allNames <- union(keptNames, otherNames)  
allData <- allData[, allNames]  

###Replacing the Activity id with Descriptive Value
The activity id is replaced by its description which is available in activity_labels.txt.  
actLab <- read.table(actPath)  
allData$activity <- sapply(allData$activity, function(x) {actLab[x,2]})  

###Creating Tidy Data Set
The tidy data set is created by averaging on variables for each activity and subject.  
allData = as.data.table(allData)  
tidyData <- allData[, lapply(.SD, mean), by = .(subject, activity), .SDcols = keptNames]  
The result is save as a txt file.  
write.table(tidyData,"C:/Amin/Coursera/GettingAndCleaningData/tidyData.txt",row.name=FALSE)  

##Load the Tidy Data Set
To load the tidy data set into R environment, use the following command:  
tidyData <- read.table("tidyData.txt",header=TRUE)


