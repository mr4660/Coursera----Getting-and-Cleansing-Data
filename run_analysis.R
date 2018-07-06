#  Load needed libraries.
library(reshape2)

#  Set up the environment.
projectFolder        <- "C:/Users/mr4660/Desktop/DPO Level 4 - RealityStone/Assignments/Week4 - Peer-graded Assignment"
datasetURL           <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datasetZipFileName   <- "getdata_dataset.zip"
datasetFolderName    <- "UCI HAR Dataset"
setwd(projectFolder)

#  Download dataset if it doesn't already exist in project's folder.
if (!file.exists(datasetZipFileName)){
   download.file(datasetURL, datasetZipFileName, method="curl")
}

#  Unzip Zip file to retrieve dataset file and folders.
if (!file.exists(datasetFolderName)) {
   unzip(datasetZipFileName)
}

#  Load activity labels.
actLbls     <- read.table(paste(datasetFolderName, "/activity_labels.txt", sep = ""))
actLbls[,2] <- as.character(actLbls[,2])

#  Load activity featuress.
feats       <- read.table(paste(datasetFolderName, "/features.txt", sep = ""))
feats[,2]   <- as.character(feats[,2])

#  Extract the data only when mean and standard deviation exist.
featsToDo <- grep(".*mean.*|.*std.*", features[,2])

#  Retrieve and standardize features' names.
featsToDo.names <- feats[featsToDo,2]
featsToDo.names = gsub('-mean', 'Mean', featsToDo.names)
featsToDo.names = gsub('-std', 'Std', featsToDo.names)
featsToDo.names <- gsub('[-()]', '', featsToDo.names)

#  Load training dataset.
train    <- read.table(paste(datasetFolderName, "/train/X_train.txt", sep = ""))[featsToDo]
trainAct <- read.table(paste(datasetFolderName, "/train/Y_train.txt", sep = ""))
trainSbj <- read.table(paste(datasetFolderName, "/train/subject_train.txt", sep = ""))

#  Combine training subjects, activities from discrete parts.
train    <- cbind(trainSbj, trainAct, train)

#  Load test dataset.
test     <- read.table(paste(datasetFolderName, "/test/X_test.txt", sep = ""))[featsToDo]
testAct  <- read.table(paste(datasetFolderName, "/test/Y_test.txt", sep = ""))
testSbj  <- read.table(paste(datasetFolderName, "/test/subject_test.txt", sep = ""))

#  Combine test subjects, activities from discrete parts.
test     <- cbind(testSbj, testAct, test)

#  Merge training and test datasets.
mrgdData <- rbind(train, test)

#  Add labels to merged datasets.
colnames(mrgdData)<- c("subject", "activity", featsToDo.names)

#  Create factors.
mrgdData$activity <- factor(mrgdData$activity, levels = actLbls[,1], labels = actLbls[,2])
mrgdData$subject  <- as.factor(mrgdData$subject)

#  Melt data and add means.
mrgdData.melted   <- melt(mrgdData, id = c("subject", "activity"))
mrgdData.mean     <- dcast(mrgdData.melted, subject + activity ~ variable, mean)

#  Write data to "tidy.txt" file.
write.table(mrgdData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
