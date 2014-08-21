#Step 0 - Initial settings
library(data.table)

#set working directory
setwd("~/Documents/r_playground/getdata-006")

#Step 1 - download and unzip the raw data set

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#s1.1 download the .zip file in the working directory
download.file(url, destfile = "dataset.zip", method = "curl")

#s1.2 unzipping the file.

unzip("dataset.zip")

#Step 2. load the data in R

testData_xtest <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testData_ytest <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
testData_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainData_xtest <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainData_ytest <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainData_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
testData_ytest$V1 <- factor(testData_ytest$V1,levels=activity_labels$V1,labels=activity_labels$V2)
trainData_ytest$V1 <- factor(trainData_ytest$V1,levels=activity_labels$V1,labels=activity_labels$V2)

# 4. Appropriately labels the data set with descriptive activity names
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(testData_xtest)<-features$V2
colnames(trainData_xtest)<-features$V2
colnames(testData_ytest)<-c("Activity")
colnames(trainData_ytest)<-c("Activity")
colnames(testData_subject)<-c("Subject")
colnames(trainData_subject)<-c("Subject")

# 5. merge test and training sets into one data set, including the activities
testData<-cbind(testData_ytest,testData_subject)
testData<-cbind(testData,testData_xtest)
trainData<-cbind(trainData_ytest,trainData_subject)
trainData<-cbind(trainData,trainData_xtest)
tidyData<-rbind(testData,trainData)

# 6. create factors to aggregate the data by activity and subject
tidyData$Activity <- as.factor(tidyData$Activity)
tidyData$Subject <- as.factor(tidyData$Subject)

# 7. calculate the mean for each subject and activity
tidyData_mean<-aggregate(tidyData, by=list(Activity = tidyData$Activity, Subject=tidyData$Subject), mean)

# 8. Remove the subject and activity column, since a mean of those make no sense
tidyData_mean[,4]=NULL
tidyData_mean[,3]=NULL

# 9. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(tidyData_mean, "tidy.txt", sep="\t", row.name=FALSE)
