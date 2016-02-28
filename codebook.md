## codebook.md

this is the a codebook for tidy dataset named as UCISamsungGalaxySIISummary.txt

## UCISamsungGalaxySIISummary.txt

This file is second tidy dataset containing 5 columnes

- **sampleid**
    
    sampleid is unique identifier assigend to each people who participated the study.

- **measurement** (33 values)

    the values of "measurement" is a measurement method named as [prefix][measurement][signal]
  
    It is somewhat confused since the value itself has different information. 
    but I considered the value is just one measurement which indicated only one value what original investigators measured. 
  
    The definition of each portion of value names are followings:

    - prefix
        - **t**  : time domain signals which were captured at a constant rate of 50 Hz.
        - **f**  : Fast Fourier Transform (FFT) was applied.

    - signal - dimensional signals.
        - **X** : Measurement of X signal
        - **Y** : Measurement of Y signal
        - **Z** : Measurement of Z signal
        - **NA(nothing)** : indicated summarized measurement.
    
    - measurement
        - **BodyAcc** : body acceleration for each of 3 dimensional signals (X/Y/Z).
        - **GravityAcc** : gravity acceleration for each signals (X/Y/Z).
        - **BodyAccJerk** : Jerk signal from body linear acceleration for X/Y/Z.
        - **BodyGyro** : body angular velocity for each signals (X/Y/Z)
        - **BodyGyroJerk** : Jerk signals from body angular velocity for X/Y/Z.
        - **BodyAccMag** : Euclidean normalized tree-dimensional signal for 3 BodyAcc measurement.
        - **GravityAccMag** : Euclidean normalized tree-dimensional signal for 3 GravityAcc measurement.
        - **BodyAccJerkMag** : Euclidean normalized tree-dimensional signal for 3 BodyAccJerk measurement
        - **BodyGyroMag** : Euclidean normalized tree-dimensional signal for 3 BodyGyro measurement
        - **BodyGyroJerkMag** : Euclidean normalized tree-dimensional signal for 3 BodyGyroJerk measurement.

- **activity** 

    measured activity by the smartphone.
    the activity containing **laying**, **sitting**, **standing**, **walking_downstairs** and **walking_upstairs**.

- **mean** : mean of extracted mean() value for the measurement variable.
    
- **std** :  mean of extracted standard deviation for the measurement variable.
    
