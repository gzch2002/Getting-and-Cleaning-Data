#Introduction
The script perform the following tasks:

1. Download the zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Unzip the file

3. Read into the train set and test set, but only keep the measurements that are for mean and std values.

4. Merge the train set and test set.

5. Merge the subject and feature columns into the dataset.

6. Label the activities with descriptive variable names.

7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Variable
The variables in mean_data.txt are taken from the orginal files X_train, Y_train, X_test, Y_test, subject_train, subject_test and features.txt. 
subject has values from 1 to 30 which represents the 30 people who participate in the test.
activity includes 6 activities each subject is asked to do.
the other 79 variables are the mean or std measurements of these activites.
