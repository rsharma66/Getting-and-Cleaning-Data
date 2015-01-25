## Getting & Cleaning Data - Beginning of Code
##Q1

library(tools)
library(dplyr)
library(tidyr)

##read test files

setwd("/Users/rajivsharma/Desktop/Coursera/CleaningData/UCI HAR Dataset-3/test")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")

## assign names to columns
setwd("/Users/rajivsharma/Desktop/Coursera/CleaningData/UCI HAR Dataset-3")
features <- read.table("features.txt")
xtestcolnames <- features[,2]
colnames(x_test) <- xtestcolnames
colnames(subject_test) <- c("Subject")
colnames(y_test) <- c("Activity")

## combine test files into one master file with 2947 rows
ysubject_test <- cbind(y_test, subject_test)
xysubject_test <- cbind(ysubject_test, x_test)

## combine xysubject_test with Inertial Signals files
setwd("/Users/rajivsharma/Desktop/Coursera/CleaningData/UCI HAR Dataset-3/test/Inertial Signals")
fnames <- list.files()
mat <- data.frame(matrix(noquote(unlist(strsplit(fnames, "_"))), nrow=length(fnames), byrow=T))

for (i in 1:length(fnames)) {
        fname <- read.table(fnames[i])
        cols <- noquote(colnames(fname))
        inertialtestcolnames <- paste(noquote(paste(mat[i, 1], mat[i, 2], mat[i, 3], sep="_")), cols, sep="_")        
        colnames(fname) <- inertialtestcolnames
        xysubject_test <- cbind(xysubject_test, fname)
}
dataset <- c(rep("test", nrow(x_test)))
dataset <- data.frame(dataset)
test <- cbind(noquote(dataset), xysubject_test)

##read train files

setwd("/Users/rajivsharma/Desktop/Coursera/CleaningData/UCI HAR Dataset-3/train")
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

## assign names to columns
xtraincolnames <- features[,2]
colnames(x_train) <- xtraincolnames
colnames(subject_train) <- c("Subject")
colnames(y_train) <- c("Activity")

## combine train files into one master file with 7352 rows
ysubject_train <- cbind(y_train, subject_train)
xysubject_train <- cbind(ysubject_train, x_train)

## combine xysubject_train with Inertial Signals files
setwd("/Users/rajivsharma/Desktop/Coursera/CleaningData/UCI HAR Dataset-3/train/Inertial Signals")
fnames <- list.files()
mat <- data.frame(matrix(noquote(unlist(strsplit(fnames, "_"))), nrow=length(fnames), byrow=T))

for (i in 1:length(fnames)) {
        fname <- read.table(fnames[i])
        cols <- noquote(colnames(fname))
        inertialtraincolnames <- paste(noquote(paste(mat[i, 1], mat[i, 2], mat[i, 3], sep="_")), cols, sep="_")        
        colnames(fname) <- inertialtraincolnames
        xysubject_train <- cbind(xysubject_train, fname)
}
dataset <- c(rep("train", nrow(x_train)))
dataset <- data.frame(dataset)
train <- cbind(noquote(dataset), xysubject_train)

##combine test with train to create a master database total

total <- rbind(train, test)

##Q2
## extracts only the measurements on the mean and standard deviation for each measurement. also excludes MeanFreq.

library(dplyr)
library(tidyr)

total2a <- total[, grepl("mean|std", names(total))]
total2aa <- total2a[, !grepl("meanFreq", names(total2a))]
total2b <- total[, 1:3]
total2 <- cbind(total2b, total2aa)

##Q3
setwd("/Users/rajivsharma/Desktop/Coursera/CleaningData/UCI HAR Dataset-3")
activity <- read.table("activity_labels.txt")
colnames(activity) <- c("Activity", "ActivityDesc")
total3 <- merge(activity, total2, by="Activity")
total3a <- select(total3, -Activity)

##Q4
##colnames already reflect correct descriptions for all variables
total4 <- total3a

##Q5 - group by Activity and Subject then summarise and collapse each column with mean
total5 <- arrange(total3, Activity, Subject) %>%
        group_by(Activity, Subject) %>%
        summarise_each(funs(mean)) %>%
        select(-ActivityDesc, -dataset)
## had to make sure Activity column had descriptions
total5a <- merge(activity, total5, by="Activity")
total5final <- select(total5a, -Activity)        
total5final[20:35, 1:7]
nrow(total5final)
ncol(total5final)
##tidy dataset
write.table(total5final, "~/Desktop/Coursera/CleaningData/UCI HAR Dataset-3/tidydata.txt", row.name=FALSE)

##end of code