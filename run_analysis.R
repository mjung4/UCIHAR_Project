##
## run_analysis.R 
##


# install package "LaF" if not existing
if (!is.element("LaF", installed.packages()[,1])) install.packages("LaF")
# install package "plyr" if not existing
if (!is.element("LaF", installed.packages()[,1])) install.packages("plyr")

library(LaF)
library(plyr)

# read files 
features <- read.table("./UCI HAR Dataset/features.txt", 
                      sep = " ", 
                      stringsAsFactors = FALSE,
                      col.names=c("feature_nr", "feature")
                      )


activities <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                              sep = " ", 
                              col.names=c("activity_nr", "activity")
)

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                           sep = "", 
                           col.names=c("subject_nr")
) 

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                           sep = "", 
                           col.names=c("subject_nr")
) 

activities_test <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                               sep = "", 
                               col.names=c("activity_nr")
) 

activities_train <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                              sep = "", 
                              col.names=c("activity_nr")
) 

# read files using package "LaF" for optimized reading
# column names included

open_fwf <- laf_open_fwf("./UCI HAR Dataset/test/X_test.txt", 
                 column_widths = rep(16,561), 
                 column_types =  rep("numeric", 561)
) 

feature_test <- open_fwf[,] 
names(feature_test) <-  features$feature


open_fwf <- laf_open_fwf("./UCI HAR Dataset/train/X_train.txt", 
                         column_widths = rep(16,561), 
                         column_types =  rep("numeric", 561)                         
) 

feature_train <- open_fwf[,] 
names(feature_train) <-  features$feature

rm(open_fwf)

# add further Information to the datasets of test and training

feature_test <- cbind(set = "test", subject_test, activities_test, feature_test)

feature_train <- cbind(set = "train", subject_train, activities_train, feature_train)

# Merge the training and the test sets to create one data set.

feature <- rbind(feature_test, feature_train)  


# descriptive activity names to name the activities in the data set

feature <- merge(activities, feature, by.x="activity_nr", by.y="activity_nr")


# Extract only the measurements on the mean and standard deviation for each measurement. 

select_columns <- c(2,4,                      
                     grep("*-mean()*|*-std()*", 
                     names(feature), 
                     ignore.case = TRUE))

feature_mean_std <- feature[select_columns]


# a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

featureMean <- ddply(
        feature_mean_std, 
        c("activity", "subject_nr"), 
        numcolwise(mean)
)


# Appropriately labels with descriptive variable names. 

names(featureMean) <- gsub("_", "", names(featureMean)) 
names(featureMean) <- gsub("-", "", names(featureMean)) 
names(featureMean) <- gsub("\\(", "", names(featureMean)) 
names(featureMean) <- gsub("\\)", "", names(featureMean)) 
names(featureMean) <- tolower(names(featureMean))

# write.table() using row.name=FALSE 

write.table(featureMean, file = "featureMean.txt", row.name=FALSE)
