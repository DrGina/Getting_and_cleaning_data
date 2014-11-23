##Set the working directory to the folder containing the zipped downloaded folder
##Make sure dplyr is installed
##Make sure reshape2 is installed

unzip("getdata-projectfiles-UCI HAR Dataset.zip")
##this unzips the folder

setwd("./UCI HAR Dataset")
##this sets the working directory to the folder you just unzipped

##This is my solution to question 1 of the assignment
xtest <- read.table("./test/X_test.txt") ##creates table from X_test data
ytest <- read.table("./test/Y_test.txt") ## creates table from Y_test data
subjecttest <- read.table("./test/subject_test.txt") ##creates table from subject_test

xtrain <- read.table("./train/X_train.txt") ##creates table from X_train data
ytrain <- read.table("./train/Y_train.txt") ## creates table from Y_train data
subjecttrain <- read.table("./train/subject_train.txt") ##creates table from subject_train

features <- read.table("features.txt") ##creates table from features data
newfeatures <- features[, 2] ## extracts the column with just the features
newerfeatures <- as.character(newfeatures) ##converts from a factor to character class
renamefeatures <- make.names(newerfeatures, unique=TRUE) ##removes duplicate column names

colnames(xtest) <- c(renamefeatures) ##adds feature column names to xtest dataframme
colnames(xtrain) <- c(renamefeatures) ##adds feature column names to xtest dataframme

colnames(ytest) <- "activity" ##adds "activity" column names to ytest
colnames(ytrain) <- "activity" ##adds "activity" column names to ytrain

colnames(subjecttest) <- "subject" ##adds "subject" column names to subjecttest
colnames(subjecttrain) <- "subject" ##adds "subject" column names to subjecttrain

testcombo <- cbind(ytest, xtest) ## column binds ytest to xtest
testcombofinal <- cbind(subjecttest, testcombo) ## column binds subjecttest to testcombo

traincombo <- cbind(ytrain, xtrain) ## column binds ytrain to xtrain
traincombofinal <- cbind(subjecttrain, traincombo) ## column binds subjecttrain to traincombo

alldata <- rbind(testcombofinal,traincombofinal) ##all test and train data merged

##Answer to question 2

library(dplyr)
rownumber <- data.frame(1:10299) ##I use rownumber here as an index for when I merge the mean and std dev dataframes together
colnames(rownumber) <- "rownumber" ##Adding a column name.
meanselect <- select(alldata, contains("mean"), ignore.case = FALSE, matches("activity"), matches("subject"))##selects all columns that contain the word mean
meanselect2 <- cbind(rownumber, meanselect)##adds the index rownumber back in
stdevselect <- select(alldata, contains("std"), ignore.case = FALSE, matches("activity"), matches("subject"))##selects all columns that contain the word std
stdevselect2 <- cbind(rownumber, stdevselect)##adds the index rownumber back in
stdevselect3 <- stdevselect2[, 1:34]##removes the activity and subject columns out so there are not duplicates in the merged dataframe
meanstdselect <- merge(meanselect2, stdevselect3, by.x="rownumber", by.y="rownumber")##merges the selected mean and std dev columns dataframes together

##Answer to question 3
meanstdselect$activity[meanstdselect$activity == 1] <- "WALKING" ##renames activity 1 as WALKING
meanstdselect$activity[meanstdselect$activity == 2] <- "WALKING_UPSTAIRS" ##renames activity 2 as WALKING_UPSTAIRS
meanstdselect$activity[meanstdselect$activity == 3] <- "WALKING_DOWNSTAIRS" ##renames activity 3 as WALKING_DOWNSTAIRS
meanstdselect$activity[meanstdselect$activity == 4] <- "SITTING" ##renames activity 4 as SITTING
meanstdselect$activity[meanstdselect$activity == 5] <- "STANDING" ##renames activity 5 as STANDING
meanstdselect$activity[meanstdselect$activity == 6] <- "LAYING" ##renames activity 6 as LAYING

##Answer to quesion 4

##Already completed on lines 24-31

##Answer to question 5
library(reshape2)
newdata <- meanstdselect[, 2:89] ##removed the rownumber index column
meltdf <- melt(newdata, id=c("activity", "subject")) ##melts the dataframe by activity and subject id's, with all the features in a variable
avdfactivity <- dcast(meltdf, activity ~ variable, mean) ##finds the mean for all the features by activity
avdfsubject <- dcast(meltdf, subject ~ variable, mean) ##finds the mean for all the features by subject
colnames(avdfactivity)[1] <- "activity_or_subject" ##renames the activity column
colnames(avdfsubject)[1] <- "activity_or_subject" ##renames the subject column
avgall2 <- rbind(avdfactivity, avdfsubject) ##row binds the activity and subject means features together, with column one being either activity or subject
ques5 <- write.table(avgall, file="ques5.txt", row.names = FALSE, col.names = TRUE, sep=" ") ##Writes out a table of the wide dataframe.

