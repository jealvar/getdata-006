#Step 0 - Initial settings
library(data.table)

#set working directory
setwd("~/Documents/r_playground/getdata-006")

#Step 1 - download and unzip the raw data set

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

##Download the .zip file in the working directory
download.file(url, destfile = "dataset.zip", method = "curl")

##Unzipping the file.

unzip("dataset.zip")

#Step 2. load the data in R

testData_xtest <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testData_ytest <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
testData_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainData_xtest <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainData_ytest <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainData_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

#Step 3. Extracts only the measurements on the mean and standard deviation
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
msFeatures <- grep("mean\\(\\)|std\\(\\)", features[, 2])

#Step 4. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
testData_ytest$V1 <- factor(testData_ytest$V1,levels=activity_labels$V1,labels=activity_labels$V2)
trainData_ytest$V1 <- factor(trainData_ytest$V1,levels=activity_labels$V1,labels=activity_labels$V2)

#Step 5. Appropriately labels the data set with descriptive activity names

colnames(testData_xtest)<-features$V2
testData_xtest<-testData_xtest[,msFeatures]

colnames(trainData_xtest)<-features$V2
trainData_xtest<-trainData_xtest[,msFeatures]

colnames(testData_ytest)<-c("Activity")
colnames(trainData_ytest)<-c("Activity")
colnames(testData_subject)<-c("Subject")
colnames(trainData_subject)<-c("Subject")

#Step 6. merge test and training sets into one data set, including the activities
testData<-cbind(testData_ytest,testData_subject)
testData<-cbind(testData,testData_xtest)
trainData<-cbind(trainData_ytest,trainData_subject)
trainData<-cbind(trainData,trainData_xtest)
tidyData<-rbind(testData,trainData)

#Step 7. create factors to aggregate the data by activity and subject
tidyData$Activity <- as.factor(tidyData$Activity)
tidyData$Subject <- as.factor(tidyData$Subject)

#Step 8. calculate the mean for each subject and activity
tidyData_mean<-aggregate(tidyData, by=list(Activity = tidyData$Activity, Subject=tidyData$Subject), mean)

#Step 9. Remove the subject and activity column, since a mean of those make no sense
tidyData_mean[,4]=NULL
tidyData_mean[,3]=NULL

#Step 10. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(tidyData_mean, "tidy.txt", sep="\t", row.name=FALSE)
