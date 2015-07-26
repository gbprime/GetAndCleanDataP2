CodeBook
========================

# Solution's Outline

The script `run_analysis.R`

- The data is downloaded from http://archive.ics.uci.edu/ml/index.html  If the file doesn't exist, it will be unzipped and saved in the proper path.
- The data is merged so that training and test sets are used to create one data set.
- Proper descriptors are applied in order to make the data readable by humans.  This one is a hack... couldn't make time to offer a good solution.
- The mean and standard deviation for each measurement are extracted.
- Labels are applied via descriptors instead of numeric values.
- A clean or tidy dataset containing the average of each variable for each each activity (and subject) is created and exported.
  
# run_analysis.R

The script also assumes that `plyr` library is already installed.

It is very easy to follow the script - the script is function-based and all processes are guided by main()  To use the script, call main()

# Interesting Info.

If the data is not already available in the `data` directory, it is downloaded
from the UCI repository and unzipped.

When the training and test sets are combined into one, the resulting dataset contains 562 columns (560
measurements, subject identifier and activity label).

After merging, the mean and standard deviation features are extracted. Out of 560 measurement features, 33 mean and 33 standard deviations features are extracted, resulting in a dataframe with 68 features.

Activity descriptors are applied instead of using the numeric labels in order to make the data readable.  The descriptors are found in `activity_labels.txt`.

A tidy data set is created with the average of each variable for each activity and each subject. 10299 instances are split into 180 groups (30  subjects and 6 activities) and 66 mean and standard deviation features are averaged for each group. The resulting dataset has 180 rows and 66 columns.   The tidy data set is exported to the text file, as per the requirements.