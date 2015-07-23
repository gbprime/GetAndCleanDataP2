# *********************************************************************************************************
# The purpose of this project is to collect, work with, and clean a data set.  The goal is to prepare tidy 
# data that can be used for later analysis.
#
# This R script gets, cleans and performs certain operations on data obtained from the accelerometers 
# used in the Samsung Galaxy S smartphone.
#
# Created by Gabriel Becerra
# Project # 2: Getting & Cleaning Data
# *********************************************************************************************************

library(plyr)

# Creates a directory in the specifid location IFF it doesn't already exists.  Once the folder is ready,
# the file is downloaded and unzipped.
#
# TODO find a script to determine whether or not a user is using OSX/Linux or Windows
getData <- function() {
  "Checks for data directory and creates one if it doesn't exist"
  if (!file.exists("data")) {
    message("Creating data directory...")
    dir.create("data")
  }
  if (!file.exists("data/UCI HAR Dataset")) {
    # download the data
    message("Downloading & unzipping the data...")
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipfile <- "data/UCI_HAR_data.zip"
    
    # download.file(fileURL, destfile=zipfile, method="curl")
    download.file(fileURL, destfile=zipfile)
    unzip(zipfile, exdir="data")
  }
}

# Merges training and test datasets.
# returns a list of data frames accessible by name (e.g. object$name)
mergeCoordinateDataSets <- function() {
  # Read data
  message("reading X_train.txt")
  training_XCoord <- read.table("data/UCI HAR Dataset/train/X_train.txt")
  message("reading y_train.txt")
  training_YCoord <- read.table("data/UCI HAR Dataset/train/y_train.txt")
  message("reading subject_train.txt")
  trainingSubject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
  message("reading X_test.txt")
  test_XCoord <- read.table("data/UCI HAR Dataset/test/X_test.txt")
  message("reading y_test.txt")
  test_YCoord <- read.table("data/UCI HAR Dataset/test/y_test.txt")
  message("reading subject_test.txt")
  testSubject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
  
  # Merge Results
  mergedResultsForX <- rbind(training_XCoord, test_XCoord)
  mergedResultsForY <- rbind(training_YCoord, test_YCoord)
  mergedResultsSubjects <- rbind(trainingSubject, testSubject)
  
  # merge train and test datasets and return
  list(x=mergedResultsForX, y=mergedResultsForY, subject=mergedResultsSubjects)
}

# Extracts only the measurements on the mean and standard deviation for each measurement contained
# in the dataFrame
extractMeanAndStandardDeviation <- function(dataFrame) {
  # Read the feature list file
  features <- read.table("data/UCI HAR Dataset/features.txt")
  
  # Find the mean and std columns
  meanColumn <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
  standardDeviationColumn <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
  
  # Extract the information from the dataframe
  extractedInfo <- dataFrame[, (meanColumn | standardDeviationColumn)]
  colnames(extractedInfo) <- features[(meanColumn | standardDeviationColumn), 2]
  
  return(extractedInfo)
}

# Applies descriptors or names to the activities in the dataframe
applyDescriptors <- function(dataFrame) {
  colnames(dataFrame) <- "activity"
  
  dataFrame$activity[dataFrame$activity == 1] = "WALKING"
  dataFrame$activity[dataFrame$activity == 2] = "WALKING_UPSTAIRS"
  dataFrame$activity[dataFrame$activity == 3] = "WALKING_DOWNSTAIRS"
  dataFrame$activity[dataFrame$activity == 4] = "SITTING"
  dataFrame$activity[dataFrame$activity == 5] = "STANDING"
  dataFrame$activity[dataFrame$activity == 6] = "LAYING"
  
  return(dataFrame)
}

applyDescriptors2 <- function(dataFrame) {
  activities <- read.table("data/activity_labels.txt")
  activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
  Y[,1] = activities[Y[,1], 2]
  names(Y) <- "activity"
}

# Combine mean & st. deviation datasets (datasetA), activities (datasetB) and 
# subjects (datasetC) into one dataframe.
#
# returns a newly created dataframe
bindDataSets <- function(datasetA, datasetB, datasetC) {
  cbind(datasetA, datasetB, datasetC)
}

# Creates a tidy dataframe with the average of each variable for each activity and each subject.
# 
# returns the tidy dataframe that is then exported as a .CSV file
createTidyDataSet <- function(dataFrame) {
  tidy <- ddply(dataFrame, .(subject, activity), function(x) colMeans(x[,1:60]))
  return(tidy)
}

main <- function() {
  # Get the information
  getData()
  
  # Merge training and test datasets
  mergedResults <- mergeCoordinateDataSets()
  
  # For each measurement, the mean and standard deviation are extracted
  msDataframe <- extractMeanAndStandardDeviation(mergedResults$x)
  
  # Applying descriptors to the activities
  descriptorsDataframe <- applyDescriptors(mergedResults$y)
  
  # Apply descriptive names to columns
  colnames(mergedResults$subject) <- c("subject")
  
  # Combines all data frames
  dataframes <- bindDataSets(msDataframe, descriptorsDataframe, mergedResults$subject)
  
  # Create tidy dataset
  tidy <- createTidyDataSet(dataframes)
  
  # Create a .CSV file containing the newly created tidy dataset
  write.csv(tidy, "TidyDataSet.csv", row.names=FALSE)
  write.table(tidy, "tidyDataSet.txt", row.names = FALSE)
}