---
title: "CodeBook"
author: "Carey"
date: '2022-07-17'
output: html_document
---
** Description of data obtained from UCI HAR**

1. subject_test and subject_train txt files contain a single column variable 'V1' with values 1-30, corresponding to the subject's number.

2. x_text and x_train txt files contains 561 column variables (named V1, V2, etc), corresponding to various measurements obtained from the smartphone device the subjects were wearing during movements/exercise

3. xtext and xtrain - dataframes obtained from reading in X_test and X_train txt files

4. datanames - dataframe obtained from reading in the features.txt file

5. subjects - stest and strain dataframes combined via rbind

6. activities - ytest and ytrain dataframes combined via rbind

7. data - xtest and xtrain dataframes combined via rbind

8. bigtable - subjects, activities, and data dataframes combined via cbind

9. melted - bigtable dataframe, reshaped using melt

10. tidytable - melted dataframe, reshaped using dcast into tidytable dataframe, which contains the average values of all measurements organized by subject number and activity.

**Transformations used to clean up data**

1. 'Stack' the test and train datasets for subject, X, and y txt files with rbind to create the subjects, data, and activities dataframes, respectively. When using rbind, keep the order consistent--for example, in this script, the order was rbind(test, train). This way, the row order between the resulting 'subjects,' 'activities,' and 'data' dataframes is kept consistent.

2. Rename the factor levels in the 'activities' dataframe so that they're descriptive-- for example, instead of '1,' the factor level is now called 'walking.' The recode function from the dplyr package can be used to do this.

3. Rename the columns in the 'data' dataframe so that they're descriptive--for example, instead of 'V1,' the column name is now tBodyAcc-mean()-X. Read in the features.txt file into a new dataframe called 'datanames,' which has a column 'V2' containing the full column names for the 'data' dataframe. Rename the columns in 'data' using the base R names function.

4. Make a new 'data' dataframe containing only the columns with mean and standard deviation measurements. Use grepl to subset for column names that contain the literal matche "mean()" OR "std()".

5. Combine the 'subjects,' 'activites,' and 'data' dataframes into one dataframe called 'bigtable.'

6. Collapse all variables in 'bigtable' EXCEPT for subject and activity using the melt function. Store this collapsed data in the dataframe called 'melted.'

7. Reshape the 'melted' dataframe into tidy data using dcast, with mean as one of the arguments. Store tidy data in a dataframe called 'tidytable.'

8. 'tidytable' dataframe contains the average of all mean() and std() measurements organized by subject and activity.
