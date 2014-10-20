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


add further Information to the featute datasets


```r
nrow(feature_test)
```

```
## [1] 2947
```

```r
head(feature_test[,1:5])
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
head(feature_mean_std, 5)
```

```
##   activity subject_nr tBodyAcc-mean()-X tBodyAcc-mean()-Y
## 1  WALKING         26         0.2314146       -0.01772244
## 2  WALKING         29         0.3312213       -0.01850237
## 3  WALKING         29         0.3755701       -0.02472861
## 4  WALKING         29         0.2332297       -0.03445146
## 5  WALKING         29         0.2362494       -0.01439694
##   tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y tBodyAcc-std()-Z
## 1        -0.1222005       -0.4194264     -0.139233660      -0.38623228
## 2        -0.1697166       -0.1451590     -0.098248375      -0.02385757
## 3        -0.1566118       -0.1066708      0.066085029      -0.19732937
## 4        -0.1048158       -0.1749531      0.004314354      -0.31542637
## 5        -0.1244713       -0.2096845     -0.074924698      -0.24701239
##   tGravityAcc-mean()-X tGravityAcc-mean()-Y tGravityAcc-mean()-Z
## 1            0.9651497           -0.1278560           0.10839432
## 2            0.9618718           -0.1199869           0.12752434
## 3            0.9663872           -0.1264032           0.09008320
## 4            0.9649919           -0.1243834           0.05997480
## 5            0.9615592           -0.1191251           0.06653936
##   tGravityAcc-std()-X tGravityAcc-std()-Y tGravityAcc-std()-Z
## 1          -0.9903452          -0.9657133          -0.9741482
## 2          -0.9716624          -0.9773611          -0.7786102
## 3          -0.9799480          -0.9758916          -0.7450934
## 4          -0.9773091          -0.9693733          -0.9491850
## 5          -0.9821222          -0.9922347          -0.9587335
##   tBodyAccJerk-mean()-X tBodyAccJerk-mean()-Y tBodyAccJerk-mean()-Z
## 1             0.1251425            0.14075681          -0.078549608
## 2             0.5916113           -0.48054711          -0.396945150
## 3            -0.2286522           -0.09032896          -0.122481120
## 4            -0.3779065            0.37863010          -0.003286214
## 5             0.1000604            0.28614885           0.082186902
##   tBodyAccJerk-std()-X tBodyAccJerk-std()-Y tBodyAccJerk-std()-Z
## 1           -0.3661997          -0.29906902           -0.4441453
## 2           -0.2445938          -0.07203393           -0.4461538
## 3           -0.1613368           0.11376187           -0.4252052
## 4           -0.1730546          -0.05940801           -0.5454782
## 5           -0.2501782          -0.11680450           -0.3795120
##   tBodyGyro-mean()-X tBodyGyro-mean()-Y tBodyGyro-mean()-Z
## 1       -0.016338534        -0.08773062         0.06960195
## 2        0.386299190        -0.31133548        -0.04935706
## 3        0.149969000        -0.11555688         0.10899323
## 4        0.046158297        -0.16855217         0.11431636
## 5        0.005325148        -0.16710460         0.08796786
##   tBodyGyro-std()-X tBodyGyro-std()-Y tBodyGyro-std()-Z
## 1        -0.4336478        -0.6153580        -0.3780977
## 2        -0.4820286        -0.2010878        -0.4856610
## 3        -0.5048411        -0.1292515        -0.4152537
## 4        -0.5777703        -0.1174994        -0.4812644
## 5        -0.5703666        -0.1582659        -0.4995593
##   tBodyGyroJerk-mean()-X tBodyGyroJerk-mean()-Y tBodyGyroJerk-mean()-Z
## 1            -0.03105034            -0.09293637             0.19151786
## 2            -0.25584631             0.21893014             0.14629859
## 3            -0.16852305            -0.21030297             0.05236963
## 4             0.03474500            -0.34490216            -0.30408831
## 5            -0.13816832             0.21668828             0.06643956
##   tBodyGyroJerk-std()-X tBodyGyroJerk-std()-Y tBodyGyroJerk-std()-Z
## 1            -0.4160253            -0.6100932            -0.5228585
## 2            -0.3535572            -0.6241647            -0.5466053
## 3            -0.2920817            -0.5390352            -0.4574731
## 4            -0.3390115            -0.5469191            -0.5183173
## 5            -0.3632713            -0.6012724            -0.5144808
##   tBodyAccMag-mean() tBodyAccMag-std() tGravityAccMag-mean()
## 1        -0.28812469        -0.4714890           -0.28812469
## 2        -0.03067504        -0.2074919           -0.03067504
## 3        -0.01440399        -0.1561914           -0.01440399
## 4        -0.09576088        -0.2342917           -0.09576088
## 5        -0.13013867        -0.2349664           -0.13013867
##   tGravityAccMag-std() tBodyAccJerkMag-mean() tBodyAccJerkMag-std()
## 1           -0.4714890             -0.3519155           -0.28513496
## 2           -0.2074919             -0.2431826           -0.13862962
## 3           -0.1561914             -0.1496203           -0.02385259
## 4           -0.2342917             -0.2309222           -0.12518641
## 5           -0.2349664             -0.2543079           -0.10014186
##   tBodyGyroMag-mean() tBodyGyroMag-std() tBodyGyroJerkMag-mean()
## 1          -0.3852718         -0.5268377              -0.5309704
## 2          -0.1188414         -0.3926661              -0.5251469
## 3          -0.1899519         -0.3370412              -0.4443999
## 4          -0.2363190         -0.3736770              -0.4788976
## 5          -0.2699431         -0.3689933              -0.5106389
##   tBodyGyroJerkMag-std() fBodyAcc-mean()-X fBodyAcc-mean()-Y
## 1             -0.6255857       -0.43289941       -0.16309026
## 2             -0.6172983       -0.06635472       -0.08094075
## 3             -0.5535678       -0.04902701        0.12728080
## 4             -0.5545788       -0.05876463        0.03307113
## 5             -0.6045877       -0.18855505       -0.02012303
##   fBodyAcc-mean()-Z fBodyAcc-std()-X fBodyAcc-std()-Y fBodyAcc-std()-Z
## 1        -0.4095017       -0.4140984      -0.18079921      -0.42181783
## 2        -0.1200727       -0.1781642      -0.16466661      -0.04796129
## 3        -0.2250829       -0.1303938      -0.03617979      -0.24577518
## 4        -0.3569095       -0.2253944      -0.07516387      -0.34628546
## 5        -0.2436891       -0.2181229      -0.16448279      -0.31030253
##   fBodyAcc-meanFreq()-X fBodyAcc-meanFreq()-Y fBodyAcc-meanFreq()-Z
## 1           -0.44562295           -0.06691033            0.06495441
## 2           -0.14196195            0.17360119            0.10772626
## 3           -0.34784239            0.14740276            0.07071010
## 4           -0.04316465            0.14253667           -0.04689711
## 5           -0.45138990            0.22142551            0.17088628
##   fBodyAccJerk-mean()-X fBodyAccJerk-mean()-Y fBodyAccJerk-mean()-Z
## 1            -0.4485954          -0.331941590            -0.5000580
## 2            -0.2324242          -0.003359272            -0.3631373
## 3            -0.1321307           0.059718204            -0.3592970
## 4            -0.1267209          -0.020735143            -0.4736242
## 5            -0.2308970          -0.105151530            -0.2943254
##   fBodyAccJerk-std()-X fBodyAccJerk-std()-Y fBodyAccJerk-std()-Z
## 1           -0.3391579          -0.30977243           -0.3969144
## 2           -0.3287917          -0.23715573           -0.5314676
## 3           -0.2746044           0.09878874           -0.4901547
## 4           -0.3079329          -0.18039491           -0.6197728
## 5           -0.3427533          -0.19657954           -0.4659184
##   fBodyAccJerk-meanFreq()-X fBodyAccJerk-meanFreq()-Y
## 1                -0.2817373               -0.38199992
## 2                -0.4273802               -0.07150824
## 3                -0.2411413               -0.23923895
## 4                -0.2090457               -0.01944162
## 5                -0.2397851               -0.09977367
##   fBodyAccJerk-meanFreq()-Z fBodyGyro-mean()-X fBodyGyro-mean()-Y
## 1               -0.47040704         -0.3360786         -0.5978750
## 2               -0.04494914         -0.2920502         -0.3753169
## 3               -0.04801012         -0.3417427         -0.3062254
## 4               -0.08150905         -0.4158063         -0.2394297
## 5                0.02308074         -0.4200726         -0.3412578
##   fBodyGyro-mean()-Z fBodyGyro-std()-X fBodyGyro-std()-Y fBodyGyro-std()-Z
## 1         -0.2936970        -0.4655297       -0.62924814        -0.4652207
## 2         -0.4339672        -0.5431750       -0.11580774        -0.5507351
## 3         -0.3566873        -0.5569102       -0.04202031        -0.4891964
## 4         -0.3997619        -0.6301374       -0.05606668        -0.5583501
## 5         -0.4340564        -0.6185528       -0.06866830        -0.5687167
##   fBodyGyro-meanFreq()-X fBodyGyro-meanFreq()-Y fBodyGyro-meanFreq()-Z
## 1            -0.16192982              0.2019204            0.001341174
## 2             0.22905502             -0.3956292            0.011877219
## 3             0.07900231             -0.3602495           -0.080647345
## 4             0.36325849             -0.2322154            0.191352620
## 5             0.15073527             -0.3361743            0.136941990
##   fBodyAccMag-mean() fBodyAccMag-std() fBodyAccMag-meanFreq()
## 1         -0.4393853        -0.5721291            0.065587291
## 2         -0.1957024        -0.3371416            0.019849609
## 3         -0.1325686        -0.3006773            0.007309349
## 4         -0.2131681        -0.3652589            0.162234300
## 5         -0.2395945        -0.3510095            0.042907638
##   fBodyBodyAccJerkMag-mean() fBodyBodyAccJerkMag-std()
## 1                -0.35283306               -0.20905606
## 2                -0.07881588               -0.22208270
## 3                -0.03223038               -0.01858232
## 4                -0.11664124               -0.14179747
## 5                -0.05718407               -0.15778110
##   fBodyBodyAccJerkMag-meanFreq() fBodyBodyGyroMag-mean()
## 1                    -0.18236429              -0.5533732
## 2                     0.06739462              -0.4271319
## 3                    -0.11896546              -0.3586391
## 4                    -0.16818518              -0.4134816
## 5                     0.01563592              -0.4158387
##   fBodyBodyGyroMag-std() fBodyBodyGyroMag-meanFreq()
## 1             -0.5897705                 0.145953240
## 2             -0.4730829                -0.006845346
## 3             -0.4362836                 0.120109120
## 4             -0.4535152                 0.166810500
## 5             -0.4449268                 0.052872633
##   fBodyBodyGyroJerkMag-mean() fBodyBodyGyroJerkMag-std()
## 1                  -0.6510374                 -0.6191883
## 2                  -0.6215335                 -0.6383168
## 3                  -0.5864619                 -0.5431835
## 4                  -0.5700217                 -0.5646317
## 5                  -0.6548946                 -0.5728283
##   fBodyBodyGyroJerkMag-meanFreq()
## 1                      0.06441463
## 2                      0.13569223
## 3                      0.15578012
## 4                      0.12061859
## 5                     -0.04744557
```

```r
head(names(feature_mean_std), 10)
```

```
##  [1] "activity"             "subject_nr"           "tBodyAcc-mean()-X"   
##  [4] "tBodyAcc-mean()-Y"    "tBodyAcc-mean()-Z"    "tBodyAcc-std()-X"    
##  [7] "tBodyAcc-std()-Y"     "tBodyAcc-std()-Z"     "tGravityAcc-mean()-X"
## [10] "tGravityAcc-mean()-Y"
```

Appropriately labels with descriptive variable names. 
Labels for the KPIs: Means_..., 


```r
head(names(feature_mean_std), 10)
```

```
##  [1] "activity"             "subject_nr"           "tBodyAcc-mean()-X"   
##  [4] "tBodyAcc-mean()-Y"    "tBodyAcc-mean()-Z"    "tBodyAcc-std()-X"    
##  [7] "tBodyAcc-std()-Y"     "tBodyAcc-std()-Z"     "tGravityAcc-mean()-X"
## [10] "tGravityAcc-mean()-Y"
```

write.table() using row.name=FALSE

Creates the new file "featureMean.txt" on base of feature_mean_std_average 
The file is created in the workindg directory fo R 
