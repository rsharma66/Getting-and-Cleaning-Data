# GettingandCleaningData-CourseProject
This is the Course Project submission for Getting and Cleaning Data Coursera course. 
The attached code file "run_analysis.r" is in R code and its objective is to take raw data from the UCI database generated on Samsung phones and convert into a tidy dataset that can be analyzed further. 

The data was generated using Samsung Galaxy II phones attached to waists of 30 subjects engaging in 6 activites - Walking, Walking_Upstairs, Walking_Downstairs, Sitting, Standing and Laying. The data generated originally was on 561 different variables from the accelerrometer and gyroscope sensors of the Samsung phone. This was in addition parsed into 128 different variables in 9 files. The data was presented in two datasets - training ("Train")  and testing ("Test"), randomly separated into 70%, 30% buckets from the original dataset.

Each dataset Train and Test were cleaned separately at first, binding approriate activity labels and column names merged from the features set. The combined and labelled Train set had a total of 7,352 observations (rows) and 1,716 variables (columns) while the combined and labelled Test set had 2,947 observations (rows) and 1,716 variables (columns). Train and Test were combined into the Total dataset with 10,299 observations (rows) and 1,716 variables (columns). Total was our primary raw dataset to begin the process of tidying from.

Only the mean and standard deviation measurements were extracted from the 1,716 variables. The Acitivity descriptions were added to the dataset. The dataset was grouped by Activity type and then by each of the 30 subjects. The data was then replaced for each one of the remaining variables by its mean. The tidyest dataset now has 180 rows (for the 6 activity sets and each of the 30 subjects) and 68 columns for the mean and std variables. The tidy dataset was written into table form as a "tidydata.txt" file for uploading.


