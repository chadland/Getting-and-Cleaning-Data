# Getting and Cleaning Data - Project 1 / Week 3  

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Clears the current R workspace not to create any conflicts with existing objects.
2. Installs and assigns libraries used in the code. If a library is installed on the R client
   previously it only assigns the library. 
3. Downloads and unzip the data if it does not already exist in the current working directory.
4. Load activity labels and feature names from the text files.
5. Loads both the training and test datasets, keeping only those columns related to mean or standard   
   deviation.
6. Loads the activity and subject data for each dataset, and merges the
   columns.
7. Merges the training and test dataset by rows.
8. Converts the `activity` and `subject` columns into factors.
9. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.
10. Writes the resulting data frame as an output txt file. 

The result dataset is shown in the file `tidy.txt`.