## Initial variable declaration

  ## declare fileURL for download data
  fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  ## delcare datafolder 
  dir<-"data"

  ## downloaded zip file name
  dfile<-"LastPA.zip"
  
## Load Library required for the assignment
  
  require(dplyr)
  require(tidyr)
  
## Data Preparation  
  
    
## dir check

  if(!file.exists(dir)) {
    dir.create(dir)
  }
  
  dfile2<-paste(dir,dfile,sep="/")
  download.file(fileURL,destfile=dfile2)

  unzip(dfile2,exdir=dir)
  
  dir<-paste(dir,"UCI HAR Dataset",sep="/")
  
## now I got the folder named "$dir/UCI HAR Dataset" which contains various data for the assignment,

  ## read column info
  filePATH<-paste(dir,"features.txt",sep="/")
  VarColname<-as.vector(read.table(filePATH,header=FALSE)[2]$V2)

## ReadData and merge.them
  
  ## Define function for merging data   
  
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
  colnames(merged.df)<-c("sampleid","activity",VarColname)
  
  ## remove merged.train, merged.test 
  rm(merged.train, merged.test)
  
  ## Extracts only the measurements on the mean and standard deviation for each measurement.
  ExtColName<-grep("-mean\\(\\)|-std\\(\\)",VarColname)
  ExtColName<-VarColname[ExtColName]
  
  ## to avoid duplicated related error of dplyr select function
  merged.df <- merged.df[,!duplicated(names(merged.df))]
  merged.df <- select(merged.df, one_of(c("sampleid","activity",ExtColName)))
                 
  ## Uses descriptive activity names to name the activities in the data set
  filePATH<-paste(dir,"activity_labels.txt",sep="/")
  activity <- as.vector(read.table(filePATH,col.names = c("id","activity"))[2]$activity)

  num2act <-function(x)
  {
    tolower(activity[x])  
  }
  
  new.df<-mutate(merged.df,activity=num2act(merged.df$activity))
  rm(merged.df)
  
  ## Using tidyr and dplyr, clean the data.
  
   tidyGalaxy <- new.df  %>% gather(measurement, mean ,contains("mean()")) %>% 
                      gather(measurement2, std ,contains("std()"))  %>% 
                      select(-measurement2) %>%
                      mutate(measurement=sub("-mean\\(\\)-*","",measurement))
   
   ## make summarized dataset.
   
   tidyGalaxy2 <- tidyGalaxy %>% group_by(sampleid,measurement,activity) %>% summarize(mean=mean(mean),std=mean(std))

   ## clear Environment
   rm(new.df,activity,dfile,dfile2,dir,ExtColName,filePATH,fileURL,VarColname)
   
   ## print summary table.
   print(tidyGalaxy2)  
   