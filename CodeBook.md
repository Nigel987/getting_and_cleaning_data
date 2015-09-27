Code Book

Describes the variables:
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
I've extracted the measurements on the mean and standard deviation.

Describes the data:
The data is a collection of the average values for each subject and activity.  

Describes any transformations or work performed to clean up the data:
1. I've merged the training and test data into one dataset. 
2. I've reduced the data set to get only the columns for standard deviation and mean (grep for -std() and -mean()) variables. 
3. I've replaced the activity numbers by activity descriptions.
4. I've assigned the labels to the variables(from the features text file). 
5. I've added the subject information to the dataset.
6. I've grouped the data set by subject and activitiy; and then calculated the mean of each column. 