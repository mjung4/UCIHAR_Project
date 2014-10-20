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

number of columns in the test dataset:

```
## [1] 2947
```

first five columns of the test dataset:

```
##    set subject_nr activity_nr tBodyAcc-mean()-X tBodyAcc-mean()-Y
## 1 test          2           5         0.2571778       -0.02328523
## 2 test          2           5         0.2860267       -0.01316336
## 3 test          2           5         0.2754848       -0.02605042
## 4 test          2           5         0.2702982       -0.03261387
## 5 test          2           5         0.2748330       -0.02784779
## 6 test          2           5         0.2792200       -0.01862040
```

number of columns in the train dataset:

```
## [1] 7352
```

first five columns of the train dataset:

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
names(feature_mean_std)
```

```
##  [1] "activity"                        "subject_nr"                     
##  [3] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"              
##  [5] "tBodyAcc-mean()-Z"               "tBodyAcc-std()-X"               
##  [7] "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"               
##  [9] "tGravityAcc-mean()-X"            "tGravityAcc-mean()-Y"           
## [11] "tGravityAcc-mean()-Z"            "tGravityAcc-std()-X"            
## [13] "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"            
## [15] "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"          
## [17] "tBodyAccJerk-mean()-Z"           "tBodyAccJerk-std()-X"           
## [19] "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"           
## [21] "tBodyGyro-mean()-X"              "tBodyGyro-mean()-Y"             
## [23] "tBodyGyro-mean()-Z"              "tBodyGyro-std()-X"              
## [25] "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"              
## [27] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"         
## [29] "tBodyGyroJerk-mean()-Z"          "tBodyGyroJerk-std()-X"          
## [31] "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"          
## [33] "tBodyAccMag-mean()"              "tBodyAccMag-std()"              
## [35] "tGravityAccMag-mean()"           "tGravityAccMag-std()"           
## [37] "tBodyAccJerkMag-mean()"          "tBodyAccJerkMag-std()"          
## [39] "tBodyGyroMag-mean()"             "tBodyGyroMag-std()"             
## [41] "tBodyGyroJerkMag-mean()"         "tBodyGyroJerkMag-std()"         
## [43] "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"              
## [45] "fBodyAcc-mean()-Z"               "fBodyAcc-std()-X"               
## [47] "fBodyAcc-std()-Y"                "fBodyAcc-std()-Z"               
## [49] "fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"          
## [51] "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"          
## [53] "fBodyAccJerk-mean()-Y"           "fBodyAccJerk-mean()-Z"          
## [55] "fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"           
## [57] "fBodyAccJerk-std()-Z"            "fBodyAccJerk-meanFreq()-X"      
## [59] "fBodyAccJerk-meanFreq()-Y"       "fBodyAccJerk-meanFreq()-Z"      
## [61] "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"             
## [63] "fBodyGyro-mean()-Z"              "fBodyGyro-std()-X"              
## [65] "fBodyGyro-std()-Y"               "fBodyGyro-std()-Z"              
## [67] "fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"         
## [69] "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"             
## [71] "fBodyAccMag-std()"               "fBodyAccMag-meanFreq()"         
## [73] "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-std()"      
## [75] "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"        
## [77] "fBodyBodyGyroMag-std()"          "fBodyBodyGyroMag-meanFreq()"    
## [79] "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-std()"     
## [81] "fBodyBodyGyroJerkMag-meanFreq()"
```

generating independent tidy data set with the average of each variable
for each activity and each subject.
ddply von package "plyr" is used
New dataset: featureMean


```r
names(feature_mean_std)
```

```
##  [1] "activity"                        "subject_nr"                     
##  [3] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"              
##  [5] "tBodyAcc-mean()-Z"               "tBodyAcc-std()-X"               
##  [7] "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"               
##  [9] "tGravityAcc-mean()-X"            "tGravityAcc-mean()-Y"           
## [11] "tGravityAcc-mean()-Z"            "tGravityAcc-std()-X"            
## [13] "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"            
## [15] "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"          
## [17] "tBodyAccJerk-mean()-Z"           "tBodyAccJerk-std()-X"           
## [19] "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"           
## [21] "tBodyGyro-mean()-X"              "tBodyGyro-mean()-Y"             
## [23] "tBodyGyro-mean()-Z"              "tBodyGyro-std()-X"              
## [25] "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"              
## [27] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"         
## [29] "tBodyGyroJerk-mean()-Z"          "tBodyGyroJerk-std()-X"          
## [31] "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"          
## [33] "tBodyAccMag-mean()"              "tBodyAccMag-std()"              
## [35] "tGravityAccMag-mean()"           "tGravityAccMag-std()"           
## [37] "tBodyAccJerkMag-mean()"          "tBodyAccJerkMag-std()"          
## [39] "tBodyGyroMag-mean()"             "tBodyGyroMag-std()"             
## [41] "tBodyGyroJerkMag-mean()"         "tBodyGyroJerkMag-std()"         
## [43] "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"              
## [45] "fBodyAcc-mean()-Z"               "fBodyAcc-std()-X"               
## [47] "fBodyAcc-std()-Y"                "fBodyAcc-std()-Z"               
## [49] "fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"          
## [51] "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"          
## [53] "fBodyAccJerk-mean()-Y"           "fBodyAccJerk-mean()-Z"          
## [55] "fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"           
## [57] "fBodyAccJerk-std()-Z"            "fBodyAccJerk-meanFreq()-X"      
## [59] "fBodyAccJerk-meanFreq()-Y"       "fBodyAccJerk-meanFreq()-Z"      
## [61] "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"             
## [63] "fBodyGyro-mean()-Z"              "fBodyGyro-std()-X"              
## [65] "fBodyGyro-std()-Y"               "fBodyGyro-std()-Z"              
## [67] "fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"         
## [69] "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"             
## [71] "fBodyAccMag-std()"               "fBodyAccMag-meanFreq()"         
## [73] "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-std()"      
## [75] "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"        
## [77] "fBodyBodyGyroMag-std()"          "fBodyBodyGyroMag-meanFreq()"    
## [79] "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-std()"     
## [81] "fBodyBodyGyroJerkMag-meanFreq()"
```

Appropriately labels with descriptive variable names. 
Labels for the KPIs: Means_..., 


```r
names(featureMean)
```

```
##  [1] "activity"                     "subjectnr"                   
##  [3] "tbodyaccmeanx"                "tbodyaccmeany"               
##  [5] "tbodyaccmeanz"                "tbodyaccstdx"                
##  [7] "tbodyaccstdy"                 "tbodyaccstdz"                
##  [9] "tgravityaccmeanx"             "tgravityaccmeany"            
## [11] "tgravityaccmeanz"             "tgravityaccstdx"             
## [13] "tgravityaccstdy"              "tgravityaccstdz"             
## [15] "tbodyaccjerkmeanx"            "tbodyaccjerkmeany"           
## [17] "tbodyaccjerkmeanz"            "tbodyaccjerkstdx"            
## [19] "tbodyaccjerkstdy"             "tbodyaccjerkstdz"            
## [21] "tbodygyromeanx"               "tbodygyromeany"              
## [23] "tbodygyromeanz"               "tbodygyrostdx"               
## [25] "tbodygyrostdy"                "tbodygyrostdz"               
## [27] "tbodygyrojerkmeanx"           "tbodygyrojerkmeany"          
## [29] "tbodygyrojerkmeanz"           "tbodygyrojerkstdx"           
## [31] "tbodygyrojerkstdy"            "tbodygyrojerkstdz"           
## [33] "tbodyaccmagmean"              "tbodyaccmagstd"              
## [35] "tgravityaccmagmean"           "tgravityaccmagstd"           
## [37] "tbodyaccjerkmagmean"          "tbodyaccjerkmagstd"          
## [39] "tbodygyromagmean"             "tbodygyromagstd"             
## [41] "tbodygyrojerkmagmean"         "tbodygyrojerkmagstd"         
## [43] "fbodyaccmeanx"                "fbodyaccmeany"               
## [45] "fbodyaccmeanz"                "fbodyaccstdx"                
## [47] "fbodyaccstdy"                 "fbodyaccstdz"                
## [49] "fbodyaccmeanfreqx"            "fbodyaccmeanfreqy"           
## [51] "fbodyaccmeanfreqz"            "fbodyaccjerkmeanx"           
## [53] "fbodyaccjerkmeany"            "fbodyaccjerkmeanz"           
## [55] "fbodyaccjerkstdx"             "fbodyaccjerkstdy"            
## [57] "fbodyaccjerkstdz"             "fbodyaccjerkmeanfreqx"       
## [59] "fbodyaccjerkmeanfreqy"        "fbodyaccjerkmeanfreqz"       
## [61] "fbodygyromeanx"               "fbodygyromeany"              
## [63] "fbodygyromeanz"               "fbodygyrostdx"               
## [65] "fbodygyrostdy"                "fbodygyrostdz"               
## [67] "fbodygyromeanfreqx"           "fbodygyromeanfreqy"          
## [69] "fbodygyromeanfreqz"           "fbodyaccmagmean"             
## [71] "fbodyaccmagstd"               "fbodyaccmagmeanfreq"         
## [73] "fbodybodyaccjerkmagmean"      "fbodybodyaccjerkmagstd"      
## [75] "fbodybodyaccjerkmagmeanfreq"  "fbodybodygyromagmean"        
## [77] "fbodybodygyromagstd"          "fbodybodygyromagmeanfreq"    
## [79] "fbodybodygyrojerkmagmean"     "fbodybodygyrojerkmagstd"     
## [81] "fbodybodygyrojerkmagmeanfreq"
```

write.table() using row.name=FALSE

Creates the new file "featureMean.txt" on base of feature_mean_std_average 
The file is created in the workindg directory fo R 
