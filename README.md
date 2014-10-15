## Introduction

Purpose: 
Preparing a tidy data on base of an 561-feature vector with time and 
frequency domain variables (features)
         
Raw data: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

desription of the raw data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## R Script run_analysis.R 

run_analysis.R script does the following

####Packages:
* the script installs package "LaF" if not existing (for optimized reading)	
* the script installs package "plyr" if not existing (for grouping)

####Reading data files

The directory "UCI HAR Dataset" form the downloaded zip file 
with the needed files hast to be located in the working directory of R.  

Files:
* features: features.txt
* activities: activity_labels.txt
* subject_test: subject_test.txt
* subject_train: subject_train.txt
* activities_test: y_test.txt
* activities_train: y_train.txt
* feature_test: X_test.txt (LaF package needed) 
* feature_train: X_train.txt (LaF package needed)

####add further Information to the featute datasets

Adding subjects and activities to feature_test
Adding subjects and activities to feature_train

####Merge the training and the test sets to create one data set.

New dataset: feature

####descriptive activity names to name the activities in the data set

Merging acitivties and feature

####Extract only the measurements on the mean and standard deviation for each measurement.

Filter to the columns with the Regex *mean*|*std*
New dataset: feature_mean_std

####generating independent tidy data set with the average of each variable
####for each activity and each subject.

ddply von package "plyr" is used
New dataset: feature_mean_std_average

# Appropriately labels with descriptive variable names. 
Labels for the KPIs: Means_..., 

####write.table() using row.name=FALSE

Creates the new file "feature_mean_std_average.txt" on base of feature_mean_std_average 
The file is created in the workindg directory fo R 
