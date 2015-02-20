library("gtools")
library("gdata")
library("dplyr")

## unify_dataset
## this will read the test and train data and combine them
## into a single data frame
## this will also apply the feature names from features.txt
## as column names in the x_* frames.
## this is writign colsubsets out to the parent environment,
## so I'll later be able to specify the columns for which I
## need means
unify_dataset <- function() {
  # Read the test data
  test.subject <- read.table("test/subject_test.txt")
  test.x_test <- read.table("test/X_test.txt")
  test.y_test <- read.table("test/y_test.txt")
  # Read the trial data
  train.subject <- read.table("train/subject_train.txt")
  train.x_train <- read.table("train/X_train.txt")
  train.y_train <- read.table("train/y_train.txt")
  
  # Combine the test and the train data
  all.subject <<- rbind(test.subject, train.subject)
  all.x <<- rbind(test.x_test, train.x_train)
  all.y <<- rbind(test.y_test, train.y_train)
  colnames(all.subject) <- "subject"

  # read the features and apply as column names
  features <<- read.table("features.txt")  
  colnames(all.x) <- features[[2]]
  # pull out only those columns whose name contains "mean" or "std"
  colsubsets <- grep("mean", features[[2]])
  colsubsets <<- c(colsubsets, grep("std", features[[2]]))
  
  all.mean_std <- all.x[,colsubsets]
  colnames(all.y) <- "activity"
  
  all.everything <- cbind(all.subject, all.y, all.mean_std)
  ## we need to calculate the means of all variables.
}

## run_analysis
## this calls unify_dataset to combine the datasets together
## maps the activity_names from activity_labels.txt for the 
## corresponding values in all.everything
run_analysis <- function() { 
  all.everything <- unify_dataset()
  
  # replace activity codes in activity with label
  activity_labels <- read.table("activity_labels.txt")
  colnames(activity_labels) <- c("activity", "activity_name")
  # merge activity_labels with all.everything 
  all.merge <- merge(all.everything, activity_labels)
  
  ## extract the mean of all the variables
  write.table(all.merge, "output.txt", row.name=FALSE)
  return (all.merge)
}