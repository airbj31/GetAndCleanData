# Final Program Assignment of Getting and Cleaning DATA course on Coursera.org.
Byungju Kim  
Feb 28, 2016  

# Introduction

This is the last program assignment of Getting and Cleaning data course.

The purpose of the assignment is to evaluate if I can get and clean data.

the end-product of the assignment was deposited into my github repository named as [UCISamsungGalaxySIISummary.txt]("./ UCISamsungGalaxySIISummary.txt")

the description is written in [codebook.md]("./codebook.md")

# Description of submitted data into github

- **Readme.md** this file

<!--
- **UCISamsungGalaxySIItidy.txt** tidy data set. which generated after step 4 of the instruction.
-->

- **UCISamsungGalaxySIISummary.txt** second tidy data set.

- **codebook.md** 

# running of the code.

1. download the code into your working directory.

2. source("run_analysis.R") to download andy tidify data.

   two dataset will be generated by the run_analysis.R
   
   - **tidyGalaxy** : first data set.
   - **tidyGalaxySummary** : second, summarized dataset.this is the output of the run_analysis.R
 
   beside of the output, the script generate two function.
   
   - **merge3DF(file1,file2,file3)** : used to merge 3 dataset.
   - **num2act(x)** from the input of digit variable x, it redirect vector value which is human readable activity.
   
# workflows

## Understanding about the data

I grasped the data structures After reading readme.txt and feature_info.txt, 

  * **features.txt** List of all variables. ( total 561 )

  * **activity_labels.txt**  code and activity label. Since the order of the items are same with line-number, we do not need to use 1st column. we need single function which redirects the code and real activity. 

  * **train/X_train.txt** and **test/X_test.txt** Training set data. 
  
      Each row identifies the subject who performed the activity for each window sample. 
      Its range is from 1 to 30.
      
      there is no common id between train and test set.
      
      training set is x 561
      test set is x ~~~.

  * **train/Y_train.txt** and **test/Y_test.txt** Test result.


## Data download


```r
## 1. declare fileURL for download data

  fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
## 2. declare data-folder
   
  dir<-"data"

## 3. downloaded zip file name

    dfile<-"LastPA.zip"

## 4. directory check and declare variable for downloaded file.

  if(!file.exists(dir)) {
    dir.create(dir) ## if directory in not exists, make new one.
  }
  
  dfile2<-paste(dir,dfile,sep="/")  ## used for destfile variable (directory and name of the file)

## 5. download and unarchive data.
  
  download.file(fileURL,destfile=dfile2)
  unzip(dfile2,exdir=dir)
  
## etc. set the directory variable for further step.  
  
  dir<-paste(dir,"UCI HAR Dataset",sep="/")    
```

## Step 1. ReadData and merge.them


```r
  ## 0. Load Library required for the assignment
  
  require(dplyr)
  require(tidyr) ## inspired from swirl lecture.
  
  ## 1. Define function for merging data 
  
  ## alternatively, we can use join() function.
  
  Merge3DF <-function(dirPATH,File1,File2,File3,...)
  {
    ## 
    filePATH<-paste(dirPATH,File1,sep="/")
    df1<-read.table(filePATH,...)
    filePATH<-paste(dirPATH,File2,sep="/")
    df2<-read.table(filePATH,...)
    filePATH<-paste(dirPATH,File3,sep="/")
    df3<-read.table(filePATH,...)
    
    ## Merge 3 data
    cbind(df1,df2,df3)
  }

    merged.train<-Merge3DF(dir,"train/subject_train.txt","train/y_train.txt","train/X_train.txt",header=FALSE)
    merged.test <-Merge3DF(dir,"test/subject_test.txt","test/y_test.txt","test/X_test.txt",header=FALSE)
  
  merged.df<-rbind(merged.train,merged.test)
  rm(merged.train, merged.test)
  colnames(merged.df)<-c("sampleid","activity",VarColname)
```

## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.


```r
  ## Extracts only the measurements on the mean and standard deviation for each measurement.
  ExtColName<-grep("-mean\\(\\)|-std\\(\\)",VarColname)
  ExtColName<-VarColname[ExtColName]
  
  ## to avoid duplicated related error of dplyr select function
  merged.df <- merged.df[,!duplicated(names(merged.df))]
  merged.df <- select(merged.df, one_of(c("sampleid","activity",ExtColName)))
```

## Step 3. Uses descriptive activity names to name the activities in the data set


```r
  filePATH<-paste(dir,"activity_labels.txt",sep="/")
  activity <- as.vector(read.table(filePATH,col.names = c("id","activity"))[2]$activity)
  activity <- as.vector(activity$activity)
  
  num2act <-function(x)
  {
    tolower(activity[x])  
  }
  


  new.df<-mutate(merged.df,activity=num2act(merged.df$activity))
  rm(merged.df)
```


## Step 4. Appropriately labels the data set with descriptive variable names.

- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



```r
  ## Filtering the variables by
  
  
#  dat<-gather(new.df,)
 
   tst <- new.df  %>% gather(measurement, mean ,contains("mean()")) %>% 
                      gather(measurement2, std ,contains("std()"))  %>% 
                      select(-measurement2) %>%
                      mutate(measurement=sub("-mean\\(\\)-*","",measurement))
```

## Step 5. make summary data set.


```r
  tidyGalaxySummary <- tst %>% group_by(sampleid,measurement,activity) %>% summarize(mean=mean(mean),std=mean(std))
  tidyGalaxySummary 
  
##   used to save the file 
#  write.table(tidyGalaxySummary,file = "./data/UCISamsungGalaxySIISummary.txt",row.names = FALSE)
#  write.table(tst,file = "./data/UCISamsungGalaxySII.txt")
```
