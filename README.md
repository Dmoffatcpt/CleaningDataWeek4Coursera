# CleaningDataWeek4Coursera
Getting &amp; Cleaning Data Week 4 Assignment Coursera

#README.txt

This file is designed to explain the contents of the script file: run_analysis.R and each operation that is performed until the tidy data set is produced.

The first step loads the required packages, plyr and dplyr and then imports all relevant data from the supplied set linked to on Coursera.
The raw data should should be unzipped and placed in the same working direfctory as the analysis script.

The followiung files are imported into R:
activity_labels - contains the 6 different activites performed by each of the subjects
features - contains a list of each of the data variable names contained within the "X" files
subject_train - the subject ID (between 1-30) corresponding to each line in the X_train/Y_train dataset
subject_test - the subject ID (between 1-30) corresponding to each line in the X_test/Y_test dataset
X_train - readings for each variable listed in "features" for the training dataset
Y_train - the activity number (1-6) for each reading in the training dataset
X_test - readings for each variable listed in "features" for the test dataset
Y_test - the activity number (1-6) for each reading in the test dataset

Column names are applied to each of the X datasets from the features list so all values have an assigned label.
A list of column names/index numbers which contain the "mean" and "standard deviation" of each listed variable are extracted then subset
into new datasets.
The subject ID and activity numbers are then added to these newly creatyed subsets along with appropriate column names so
that every line has a full results set aligned with a subject and activity.

These two new subsets are then combined into one single dataset which lists all the training and test data

This data is then sorted using the "aggregate" comnmand along with the "mean" function to produce an average value for each
of the listed activitiea. This results in a single value for each variable (column) for each possible subject - activity combination,
for a total of 180 rows of data. Each mean value is listed under the same variable heading as used in the imported data so it can be easily identified.
