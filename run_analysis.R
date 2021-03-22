#Load required packages
library(plyr)
library(dplyr)

#Load in raw data from individual files from default location in data directory
activity_labels <- read.delim("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt", header=FALSE)
features <- read.delim("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt", header=FALSE)
subject_train <- read.delim("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt", header=FALSE)
X_train <- read.delim("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt", header=FALSE, sep="")
Y_train <- read.delim("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\Y_train.txt", header=FALSE, sep="")


# Load data from 'test' folder
subject_test <- read.delim("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt", header=FALSE)
X_test <- read.delim("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt", header=FALSE, sep="")
Y_test <- read.delim("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\Y_test.txt", header=FALSE, sep="")

#Apply list of names extracted from 'features' file to each 'X' dataset
colnames(X_test) <- unlist(features)
colnames(X_train) <- unlist(features)

#Make vectors of column name lists for extraction manipulation
Xtrainnames <- c(names(X_train))
Xtestnames <- c(names(X_test))

#Generate list of column numbers which contain either "mean" or "std" in the title for each X dataset
traincol <- Xtrainnames[grep("^(?=.*\\bmean\\b)|(?=.*\\bstd\\b)(?!.*\\bmeanFreq\\b)",Xtrainnames, perl=TRUE)]
testcol <- Xtestnames[grep("^(?=.*\\bmean\\b)|(?=.*\\bstd\\b)(?!.*\\bmeanFreq\\b)",Xtestnames, perl=TRUE)]

#Extract all relevant mean() and std() data from full sets
Xtrain2 <- X_train[,traincol]
Xtest2 <- X_test[,testcol]

#Rename coumns in 'Y' and 'Subject' data frames in reparation for binding
colnames(Y_train) <- "Activity_Type"
colnames(Y_test) <- "Activity_Type"
colnames(subject_train) <- "Subject_No."
colnames(subject_test) <- "Subject_No."

#Add activity and subject numbers to reduced datasets
Xtrain2 <- cbind(Xtrain2, Y_train)
Xtest2 <- cbind(Xtest2, Y_test)
Xtrain2 <- cbind(Xtrain2, subject_train)
Xtest2 <- cbind(Xtest2, subject_test)

#Bind the test and train data sets together to form one single data frame
Fulldata <- rbind(Xtrain2, Xtest2)

#Aggregate based on each activity for each subject. Each column will have 1 value, for a total of 180 rows.
Tidydata <- aggregate(x=Fulldata, by=list(Fulldata$Activity_Type,Fulldata$Subject_No.), FUN="mean")
#Note that errors occur if variable activity names are adjusted before aggregate command as "mean" cannot be applied.

#Re-label all activity entry with descriptive names taken from "activity labels" file
Tidydata$Activity_Type<- gsub("1","WALKING", Tidydata$Activity_Type)
Tidydata$Activity_Type<- gsub("2","WALKING_UPSTAIRS",Tidydata$Activity_Type)
Tidydata$Activity_Type<- gsub("3","WALKING_DOWNSTAIRS",Tidydata$Activity_Type)
Tidydata$Activity_Type<- gsub("4","SITTING",Tidydata$Activity_Type)
Tidydata$Activity_Type<- gsub("5","STANDING",Tidydata$Activity_Type)
Tidydata$Activity_Type<- gsub("6","LAYING",Tidydata$Activity_Type)

#Output tidy data set to .txt file with no name headings
write.table(Tidydata, file="tidydata.txt", row.names=FALSE)