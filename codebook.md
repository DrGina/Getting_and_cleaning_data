Codebook

The original column names are from the features_info.txt file as follows:
Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

REMOVED COLUMNS

As part of the assignment I removed all columns which did not contain the word "mean" or "std". This left me with 89 features from the original list.

RENAME COLUMNS

I did not rename the original features from the assignment. My reasoning is that the descriptions are already very descriptive and I thought it unnecessary to reassign names.
I added a new column which includes the activity or subject "activity_or_subject". I wanted to make the data as tidy as possible so I combined the activity and subject column together. 
Activity is by its name according to the assignment. Subject is according to the subject name.


TRANSFORMATIONS

Step 1: I unzipped and set the working directory to the downloaded folder.
Step 2: I read in and combined all the test and train data into one data frame, which includes the activity and subject.
Step 3: I added column names to all of the columns, for the features they are as the features_info above. For subject it is called "subject" for activity, it is called "activity.
Step 4: I selected only the columns that included the words "mean" and "std". While maintaining the new columns of "activity" and "subject".
Step 5: I changed the numbers of the activities to their corresponding word i.e., 1 for WALKING.
Step 6: I melted all the features columns into one variable column.
Step 7: I found the mean for the 6 types of activities by feature.
Step 8: I found the mean for the 30 subjects by feature.
Step 9: I combined these together to form one dataframe where the first column is either the subject or activity, and the remaining columns are the means of the features.
Step 10: I exported out step 9 into a .txt file "ques5.txt".