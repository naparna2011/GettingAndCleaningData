# GettingAndCleaningData
Week4-Course Project

Download the dataset and extract All the zip file in the working directory under "./data/dataset" folder

Load dplyr and data.table package in R

Run the script on the R console and it would create a secTidySet.txt in the working directory.

The script reads the datasets from the ./data/dataset directory
Then assigns the column names to all the tables

Then use cbind to merge the data sets to create a big dataset
 the next step creates a new dataset, with activityID, subjectID and the mean and the standard deviation of the colNames
 
 using the merge function it sets the descriptive activity labels
 
 the next steps creates the tidy data sets and writes in a text file.
