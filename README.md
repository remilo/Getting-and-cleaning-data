---
title: "README.md"
date: June 18, 2017
---
#Getting and cleaning Data

#Project description

The goal of this project is to:

1- Merges the training and the test sets to create one data set.

2- Extracts only the measurements on the mean and standard deviation for each measurement.

3- Uses descriptive activity names to name the activities in the data set

4- Appropriately labels the data set with descriptive variable names.

5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##How all of the scripts work and how they are connected

- Download the data source and put into a folder on your local drive. You'll have a UCI HAR Dataset folder

- Put run_analysis.R in the parent folder of UCI HAR Dataset

- Set the working directory (at the top of run_analysis.R)

- Run source("run_analysis.R"), then it will generate a new file tiny_data.txt in your working directory.
