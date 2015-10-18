library(dplyr)

#Get zip file from the web and unzip it.
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "smartdata.zip", method="curl")
unzip("smartdata.zip") 

#Get the features we need to kept. 
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
row_number_keptfeatures <- grep(".*mean.*|.*std.*", features[,2])
keptfeaturesNames <- features[row_number_keptfeatures,2]
keptfeaturesNames <- gsub('-mean', 'Mean', keptfeaturesNames)
keptfeaturesNames <- gsub('-std', 'Std', keptfeaturesNames)
keptfeaturesNames <- gsub('[-()]', '', keptfeaturesNames)
#79 variables are kept.

#Read train set with kept variables.
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")[row_number_keptfeatures]
str(X_train)
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
str(Y_train)
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
str(trainSubjects)
train <- cbind(trainSubjects, Y_train, X_train)

#Read test set with kept variables.
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")[row_number_keptfeatures]
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, Y_test, X_test)

#Merge train and test.
alldata <- rbind(train, test)
str(alldata)
#Total 10299 observations and 81 variables.

#Add Column Names.
colnames(alldata) <- c("subject", "activity", keptfeaturesNames)

#Label the activities with descriptive variable names from activity_labels.txt. 
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
alldata$activity <- factor(alldata$activity, levels = activityLabels[,1], labels = activityLabels[,2])

meandata <-alldata %>% group_by(subject, activity) %>%
  summarise_each(funs(mean))
write.table(meandata, "tidy_mean.txt", row.names = FALSE, quote = FALSE)

