# Final Program Assignment of Getting and Cleaning DATA course on Coursera.org.
Byungju Kim  
Feb 28, 2016  

# Introduction

This is the last program assignment of Getting and Cleaning data course.

The purpose of the assignment is to evaluate if I can get and clean data.

the end-product of the assignment was deposited into my github repository named as [UCISamsungGalaxySIISummary.txt](https://github.com/airbj31/GetAndCleanData/blob/master/UCISamsungGalaxySIISummary.txt)

the description is written in [codebook.md](https://github.com/airbj31/GetAndCleanData/blob/master/codebook.md)

# Description of submitted data into github

- **[readme.md](https://github.com/airbj31/GetAndCleanData/blob/master/readme.md)** - this file

- **[run_analysis.R](https://github.com/airbj31/GetAndCleanData/blob/master/analysis.R)** : assignment R code used to get and clean UCI samsung galaxy SII wearable device data.

- **[UCISamsungGalaxySIISummary.txt](https://github.com/airbj31/GetAndCleanData/blob/master/UCISamsungGalaxySIISummary.txt)** : summary tidy dataset generated from [run_analysis.R](https://github.com/airbj31/GetAndCleanData/blob/master/analysis.R)

- **[codebook.md](https://github.com/airbj31/GetAndCleanData/blob/master/codebook.md)** : [UCISamsungGalaxySIISummary.txt](https://github.com/airbj31/GetAndCleanData/blob/master/UCISamsungGalaxySIISummary.txt) and detailed workflow are described in this file.

# Running of the code.

1. download the [run_analysis.R](https://github.com/airbj31/GetAndCleanData/blob/master/analysis.R) into your working directory.

2. source("run_analysis.R") to download andy tidify data.

   two dataset will be generated by the run_analysis.R
   
   - **tidyGalaxy** : first data set.
   - **tidyGalaxySummary** : second, summarized dataset.this is the output of the run_analysis.R It would be written in *UCISamsungGalaxySIISummary.txt* in working directory. 
