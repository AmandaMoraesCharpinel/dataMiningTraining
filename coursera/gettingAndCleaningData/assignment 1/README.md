## About the script:
1. please source the file run_analysis.R
2. run run_analysis() in R
3. the files reads the data from the default directory "/UCI HAR Dataset"
Please note: During the development phase of this script the data was
downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
at 2015-04-25
4. the results can be found in the tidy data set results.txt

## The script works as follows:
1. it set ups all required variables for the file names
2.  it reads the data
3.  it sets the Appropriately labels in the data set with descriptive variable names
4.  it merges the x and y from test and train data separatly 
5.  it merges the training and test sets into one data set
6.  it extracts only the required mean and standard deviation variables
using grep
7.  it uses the aggregate function group by subject and activity label
ID and calculates the mean of this group
8.  it adds the descriptive activity names into the data set
9.  it stores the data set in the result.txt file


## Variables names:
- the subjectID variable is a number from 1-30 refering to one of the
paticipants of the study
- the activityLabels variable indicating the movement of the
participant as string
- the labeldID variable is the activityLabels variable as an integer
- for detailed information on the variables please refer to the
original source
- please note that the variables from the original data source are
actually the mean for the gropus formed by subjectID and labeldID

