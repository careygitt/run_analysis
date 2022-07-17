# Installing and loading packages neede for run_analysis.R 
# to work
 
library(dplyr)
library(reshape2)

# Read in the text/train.txt files and the features.txt files
# The features.txt file will be used to provide the column names 
# for the mean andstandard deviation measurement variables

stest <- read.table("subject_text.txt")
strain <- read.table("subject_train.txt")
ytest <- read.table("y_test.txt")
ytrain <- read.table("y_train.txt")
xtest <- read.table("x_test.txt")
xtrain <- read.table("x_train.txt")
datanames <- read.table("features.txt")

# Now to combine the text and train data sets into three; 'subjects,'
# 'activities,' and 'data' 

subjects <- rbind(stest, strain)
subjects <- rename(subjects, subject = V1)
activities <- rbind(ytest, ytrain)
activities <- rename(activities, activity = V1)
activities$activity <- recode(activities$activity, '1' = 'walking',
                              '2' = 'walking_upstairs',
                              '3' = 'walking_downstairs', '4' = 'sitting',
                              '5' = 'standing', '6' = 'laying')
data <- rbind(xtest, xtrain)
names(data) <- datanames$V2

# Subsetting 'data' so that the only column variables included contain 
# "mean()" OR "std()." meanFreq() measurements are excluded.

data <- data[, grep1("mean\\(\\)", names(data)) | grep1("std\\(\\)",
                                                        names(data))]

# Combing 'subjects,' 'activities,' and 'data' into one data set
bigtable <- cbind(subjects, activities, data)

# Reshape 'bigtable' into a tidy data set called 'tidytable' using melt/cast.
# 'tidytable' contains the average for all measurements, organized by subject
# and activity.
melted <- melt(bigtable, id.vars = c("subject", "activity"))
tidytable <- dcast(melted, subject+activity ~ variable, mean)

# Write 'tidytable' to a .csv file in your working directory.
write.csv(tidytable, "tidytable.csv")