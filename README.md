## This directory contains the following files:

README.md -- this file

run_analysis.R -- contains the code for run_analysis() to process the data in the directory UCI HAR Dataset. 

UCI HAR Dataset -- this directory contains the unzipped contents of the Human Activity Recognition dataset.

CODEBOOK.md -- describes the data in the resulting file


## Usage 

run_analysis() runs following steps:

1. Merges the training and test datasets
2. The file UCI HAR Dataset/features.txt is a list of the columns in the datasets. The names of the columns in the resulting dataset will have these descriptive names. The dataset will include only measurements whose name includes "mean" or "std"
3. The activity encoded in the field "Activity" is mapped to a field "Activity_Name," whose values come from the file UCI HAR Dataset/activity_labels.
4. The dataset is melted by the subject, activity_name, and variable
5. ddply is used to calculate the average of each set of variables
6. The resulting table is written with name output.txt

