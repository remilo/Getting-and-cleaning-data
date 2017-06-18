## Load the packages
library(dplyr)
library(reshape2)
library(data.table)

#************ USER INPUT requested **************

##set the working directory where you saved this file (to be replaced by where you put the data)
setwd("/home/remi/Documents/Cours/Data Science Specialization/03-Getting and Cleaning Data/week4/assignment/project")


#**************************



# Load: activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Load: features
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

#************ Test data **************

# Load and process X_test
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(X_test) = features
# Extract only the measurements on the mean and standard deviation for each measurement.
extract_features <- grepl("mean|std", features)
X_test = X_test[,extract_features]


# Load and process y_test data.
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")

# Load and process subject_test data.
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) = "subject"

# Bind data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

#************ Train data **************

# Load and process X_test
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(X_train) = features
# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,extract_features]


# Load and process y_test data.
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")

# Load and process subject_test data.
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train) = "subject"

# Bind data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

#************ merge data **************

# Merge test and train data
data = rbind(test_data, train_data)

#switch from wide to long form:
id_labels = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to melt data and switch back to long format
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)
