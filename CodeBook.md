Course Project Code Book
========================

# Introduction

The script `run_analysis.R`

- The data is downloaded from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html).  If the file doesn't exist, it will be unzipped and saved in the proper path
- The data is merged so that training and test sets are used to create one data set
- Proper descriptors are applied in order to make the data readable by humans.  This one is a hack... couldn't make time to offer a good solution.
- The mean and standard deviation for each measurement are extracted
- Labels the columns with descriptive names
- A tidy dataset with an average of each variable for each each activity and each subject is created and exported.
  
# run_analysis.R

The script also assumes that `plyr` library is already installed.

It is very easy to follow the script - the script is function-based and all processes are guided by main()  To use the script, call main()

# The original data set

The original data set is split into training and test sets (70% and 30%,
respectively) where each partition is also split into three files that contain

- measurements from the accelerometer and gyroscope
- activity label
- identifier of the subject

# Getting and cleaning data

If the data is not already available in the `data` directory, it is downloaded
from UCI repository.

The first step of the preprocessing is to merge the training and test
sets. Two sets combined resulting in a table containing 562 columns (560
measurements, subject identifier and activity label).

After the merge operation, mean and standard deviation features are extracted
for further processing. Out of 560 measurement features, 33 mean and 33 standard
deviations features are extracted, yielding a data frame with 68 features
(additional two features are subject identifier and activity label).

Next, the activity labels are replaced with descriptive activity names, defined
in `activity_labels.txt` in the original data folder.

The final step creates a tidy data set with the average of each variable for
each activity and each subject. 10299 instances are split into 180 groups (30
subjects and 6 activities) and 66 mean and standard deviation features are
averaged for each group. The resulting data table has 180 rows and 66 columns.
The tidy data set is exported to `UCI_HAR_tidy.txt` where the first row is the
header containing the names for each column.