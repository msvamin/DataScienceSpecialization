
setwd('C:/Amin/Coursera/GettingCleaningData/')

# Defining the Pathes to the Files
XtrainPath = 'C:/Amin/Coursera/GettingCleaningData/train/X_train.txt'
ytrainPath = 'C:/Amin/Coursera/GettingCleaningData/train/y_train.txt'
strainPath = 'C:/Amin/Coursera/GettingCleaningData/train/subject_train.txt'
XtestPath = 'C:/Amin/Coursera/GettingCleaningData/test/X_test.txt'
ytestPath = 'C:/Amin/Coursera/GettingCleaningData/test/y_test.txt'
stestPath = 'C:/Amin/Coursera/GettingCleaningData/test/subject_test.txt'
ftPath = 'C:/Amin/Coursera/GettingCleaningData/features.txt'
actPath = 'C:/Amin/Coursera/GettingCleaningData/activity_labels.txt'

require(data.table)

# Loading the training data
trainDF <- read.table(XtrainPath)
f <- read.table(ftPath)

# Change the column names with descriptive names
names(trainDF) <- f$V2

# Add activity and subject as new columns to the dataset
y <- read.table(ytrainPath)
s <- read.table(strainPath)
trainDF$activity <- y$V1
trainDF$subject <- s$V1

# Loading the test data
testDF <- read.table(XtestPath)

# Change the column names with descriptive names
names(testDF) <- f$V2

# Add activity and subject as new columns to the dataset
y <- read.table(ytestPath)
s <- read.table(stestPath)
testDF$activity <- y$V1
testDF$subject <- s$V1

# Merging the train and test datasets
allData <- rbind(trainDF, testDF)
rm(trainDF, testDF)

# Extracting the measurements on the mean and standard deviation for each measurement
DFnames <- names(allData)
meanNames <- DFnames[grep("-mean()", DFnames)]
stdNames <- DFnames[grep("-std()", DFnames)]
otherNames <- c("activity", "subject")
keptNames <- union(meanNames, stdNames)
allNames <- union(keptNames, otherNames)
allData <- allData[, allNames]

# Replacing the activity id with its description
actLab <- read.table(actPath)
allData$activity <- sapply(allData$activity, function(x) {actLab[x,2]})

# Create a tidy dataset with the average of variables for each activity and subject
allData = as.data.table(allData)
tidyData <- allData[, lapply(.SD, mean), by = .(subject, activity), .SDcols = keptNames]

# Writing tidy data as a text file
write.table(tidyData,"C:/Amin/Coursera/GettingAndCleaningData/tidyData.txt",row.name=FALSE)