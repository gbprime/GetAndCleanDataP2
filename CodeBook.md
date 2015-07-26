CodeBook
========================

# Solution's Outline

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

# Data...

If the data is not already available in the `data` directory, it is downloaded
from the UCI repository and unzipped.

The first step is to merge the training and test
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
The tidy data set is exported to the requested text file where the first row is the
header containing the names for each column.