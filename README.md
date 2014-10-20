---
title: "Description of run_analysis.R"
author: "M. Jung"
date: "Monday, October 20, 2014"
---

Purpose: 
Preparing a tidy data on base of an 561-feature vector with time and 
frequency domain variables (features)

Raw data: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

desription of the raw data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

R Script run_analysis.R 

Packages:
* the script installs package "LaF" if not existing (for optimized reading)        
* the script installs package "plyr" if not existing (for grouping)

Reading data files

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


add further Information to the featutre datasets test and train


```
## [1] 2947
```

```
##    set subject_nr activity_nr tBodyAcc-mean()-X tBodyAcc-mean()-Y
## 1 test          2           5         0.2571778       -0.02328523
## 2 test          2           5         0.2860267       -0.01316336
## 3 test          2           5         0.2754848       -0.02605042
## 4 test          2           5         0.2702982       -0.03261387
## 5 test          2           5         0.2748330       -0.02784779
## 6 test          2           5         0.2792200       -0.01862040
```


```r
nrow(feature_train)
```

```
## [1] 7352
```

```r
head(feature_train[,1:5])
```

```
##     set subject_nr activity_nr tBodyAcc-mean()-X tBodyAcc-mean()-Y
## 1 train          1           5         0.2885845       -0.02029417
## 2 train          1           5         0.2784188       -0.01641057
## 3 train          1           5         0.2796531       -0.01946716
## 4 train          1           5         0.2791739       -0.02620065
## 5 train          1           5         0.2766288       -0.01656966
## 6 train          1           5         0.2771988       -0.01009785
```

Merge the training and the test sets to create one data set.


```r
nrow(feature)
```

```
## [1] 10299
```

```r
head(feature[,1:5])
```

```
##   activity_nr activity   set subject_nr tBodyAcc-mean()-X
## 1           1  WALKING train         26         0.2314146
## 2           1  WALKING train         29         0.3312213
## 3           1  WALKING train         29         0.3755701
## 4           1  WALKING train         29         0.2332297
## 5           1  WALKING train         29         0.2362494
## 6           1  WALKING train         29         0.2645428
```

add descriptive activity names to name the activities in the data set



```r
head(names(feature),10)
```

```
##  [1] "activity_nr"       "activity"          "set"              
##  [4] "subject_nr"        "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y"
##  [7] "tBodyAcc-mean()-Z" "tBodyAcc-std()-X"  "tBodyAcc-std()-Y" 
## [10] "tBodyAcc-std()-Z"
```


Extract only the measurements on the mean and standard deviation for each measurement.

Filter to the columns with the Regex *mean*|*std*
New dataset: feature_mean_std


```r
head(names(feature_mean_std), 10)
```

```
##  [1] "activity"             "subject_nr"           "tBodyAcc-mean()-X"   
##  [4] "tBodyAcc-mean()-Y"    "tBodyAcc-mean()-Z"    "tBodyAcc-std()-X"    
##  [7] "tBodyAcc-std()-Y"     "tBodyAcc-std()-Z"     "tGravityAcc-mean()-X"
## [10] "tGravityAcc-mean()-Y"
```

generating independent tidy data set with the average of each variable
for each activity and each subject.
ddply von package "plyr" is used
New dataset: featureMean


```r
head(names(feature_mean_std))
```

```
## [1] "activity"          "subject_nr"        "tBodyAcc-mean()-X"
## [4] "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X"
```

Appropriately labels with descriptive variable names. 
Labels for the KPIs: Means_..., 


```r
head(names(featureMean))
```

```
## [1] "activity"      "subjectnr"     "tbodyaccmeanx" "tbodyaccmeany"
## [5] "tbodyaccmeanz" "tbodyaccstdx"
```

write.table() using row.name=FALSE

Creates the new file "featureMean.txt" on base of feature_mean_std_average 
The file is created in the workindg directory fo R 
