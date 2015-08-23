# Data Science - Get Data Course Project
Script to compile the Human Activity Recognition Using Smartphones Data Set
files into a single 'tidy' data set.

# Data Set
Human Activity Recognition Using Smartphones Data Set
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Files used from data set
1. features.txt : List of all features.
2. activity_lables.txt : Links the class labels with their activity name
3. .test/subject_test.txt : Links the subject with observation record
4. .test/X_test.txt : test set
5. .test/y_test.txt : test labels
6. .train/subject_train.txt : Links the subject with observation record
7. .train/X_train.txt : training set
8. .train/y_train.txt : training labels

# CodeBook.md
Contains name and description of final data frame measurement variables.

# run_analysis.R
This script will read in the test and training data and compile a final
'tidy', single frame data set.

## Processing steps in script
1. Read in all files from data set

2. Create test.df dataframe of the test data set
* Assign the features labels to names(X_test)
* Column bind subject_test and y_test to X_test so links to the subject and activity
are available in the final dataframe

3. Create train.df dataframe of the training data set
* Assign the features labels to names(X_train)
* Column bind subject_train and y_train to X_train so links to the subject and activity
are available in the final dataframe

4. Create df.full dataframe which is a row binding of test.df and train.df

5. Create df.extract dataframe which is a subset of df.full that only contains
the mean and standard deviations of the signal readings

6. Clean up the variable names from original data set with the following transformations
to remove abbreviations and provide better readability
* 'f' -> 'Frequency'
* 't' -> 'Time'
* 'Acc' -> 'Acceleration'
* 'Mag' -> 'Magnitude'
* 'mean()' -> 'Mean'
* 'std()' -> 'StandardDeviation'
* 'X' -> 'X.Axis'
* 'Y' -> 'Y.Axis'
* 'Z' -> 'Z.Axis'
* 'BodyBody' -> 'Body'

The final output of run_analysis.R is a single dataframe consisting of
10299 observations of 68 variables.
