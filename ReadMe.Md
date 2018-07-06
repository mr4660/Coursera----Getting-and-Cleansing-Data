###################################################################################################################
#  Topic:   Coursera for AT&T.
#  Project: Getting and Cleaning Data - Final Assignment
#  Purpose: R script which completes the following activities
#  Input:   ./UCI HAR Dataset/
#  Output:  ./tidy.txt
###################################################################################################################
#  Execution Steps
#     A. Determines whether input files exist within input folders; downloads files as needed.
#     B. From files, load all feature and activity data into two categorical containers: training and test.
#     C. Calculate statistics -- Mean and Standard Deviation -- for subsequent analysis.
#     D. Merges factors, features, and activities into a dataframe:  rows=factors; columns=activity; cell=mean.
#     E. Save dataframe as a tidy dataset into output folder.
###################################################################################################################
