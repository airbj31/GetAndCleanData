## STEP 0. Data preparation and load library

  ## 0-A. Load Library required for the assignment

  require(dplyr)
  require(tidyr) 

  ## 0-B. Initial variable declaration

    ### declare fileURL for download data
    fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
    ### delcare datafolder 
    dir<-"data"

    ### downloaded zip file name
    dfile<-"LastPA.zip"
  
  ## 0-C. dir check
  if(!file.exists(dir)) {
    dir.create(dir)
  }
    
  ## 0-D. download and unzip data
    
    ### make dest file path and name
    dfile2<-paste(dir,dfile,sep="/")
  
    ### download file unzip it into dir folder (testing purpose. evading download file again to save time)
    # if(!file.exists(dfile2) | !file.info(dfile2)$size == 62556944)
    # {download.file(fileURL,destfile=dfile2);unzip(dfile2,exdir=dir)}
    
    ## download file
      download.file(fileURL,destfile=dfile2)
    
    ## unzip downloaded file into dir folder.
      unzip(dfile2,exdir=dir)

    ### set base data directory as dir variable for further usage. 
    dir<-paste(dir,"UCI HAR Dataset",sep="/")
  
## Step 1. Read Data and merge them into temporary data frame
  
  ### 1-A. Define function for merging data   
  
  Merge3DF <-function(dirPATH,File1,File2,File3,...)
  {
    ## 
    filePATH<-paste(dirPATH,File1,sep="/")
    df1<-read.table(filePATH,...)
    filePATH<-paste(dirPATH,File2,sep="/")
    df2<-read.table(filePATH,...)
    filePATH<-paste(dirPATH,File3,sep="/")
    df3<-read.table(filePATH,...)
    
    ### Merge 3 data into 1 data frame.
    cbind(df1,df2,df3)
  }
  
  ## 1-B. get train and test data.
  merged.train<-Merge3DF(dir,"train/subject_train.txt","train/y_train.txt","train/X_train.txt",header=FALSE)
  merged.test <-Merge3DF(dir,"test/subject_test.txt","test/y_test.txt","test/X_test.txt",header=FALSE)
  
  ## 1-C. get merge one data.frame (training + test)
  merged.df<-rbind(merged.train,merged.test)

  ## 1-D. remove temporary merged.train, merged.test 
  rm(merged.train, merged.test)

## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.      

  ## 2-A. read column info
  filePATH<-paste(dir,"features.txt",sep="/")
  VarColname<-as.vector(read.table(filePATH,header=FALSE)[2]$V2)

  ## 2-B. delcare colname of merged.df
  colnames(merged.df)<-c("sampleid","activity",VarColname)
  
  ## 2-C. Extracts only the measurements on the mean and standard deviation for each measurement.
  ExtColName<-grep("-mean\\(\\)|-std\\(\\)",VarColname)
  ExtColName<-VarColname[ExtColName]
  
  ## 2-D. to avoid duplicated related error of dplyr select function
  merged.df <- merged.df[,!duplicated(names(merged.df))]
  merged.df <- select(merged.df, one_of(c("sampleid","activity",ExtColName)))
                 
## Step 3. Uses descriptive activity names to name the activities in the data set

  ## 3-A. read activity_labels.txt for annotation.
  filePATH<-paste(dir,"activity_labels.txt",sep="/")
  activity <- as.vector(read.table(filePATH,col.names = c("id","activity"))[2]$activity)

  ## 3-B. make function to annotate activity.
  num2act <-function(x)
  {
    tolower(activity[x])  
  }
  
  ## 3-C. use mutate function to update activity column values.
  new.df<-mutate(merged.df,activity=num2act(merged.df$activity))
    
  ## 3-D remove temporary data table
  rm(merged.df)

## Step 4. Appropriately labels the data set with descriptive variable names.
  
  ## Using tidyr and dplyr, clean the data.
  
   tidyGalaxy <- new.df  %>% gather(measurement, mean ,contains("mean()")) %>% 
                      gather(measurement2, std ,contains("std()"))  %>% 
                      select(-measurement2) %>%
                      mutate(measurement=sub("-mean\\(\\)-*","",measurement))

## Step 5. make summary data set.
   
   tidyGalaxySummary <- tidyGalaxy %>% group_by(sampleid,activity) %>% summarize(mean=mean(mean),std=mean(std))

   ## clean Environment
   rm(new.df,dfile,dfile2,dir,ExtColName,filePATH,fileURL,VarColname,activity,Merge3DF,num2act)
   
   ##   Save the file 
   write.table(tidyGalaxySummary,file = "./UCISamsungGalaxySIISummary.txt",row.names = FALSE)
   #  write.table(tst,file = "./UCISamsungGalaxySII.txt")
   
    
   ## print summary table.
   print(tidyGalaxySummary)  
   