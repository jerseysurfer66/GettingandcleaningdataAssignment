# Variables #

**trainx**, **trainy**, **testx**, **testy**, **subj_train** and **subj_test** are variables containing data from the original files. 

**x_data**, **y_data** and **subj_data** are variables created from the merged data sets above. 

**features** is the x_data set with corrected names. likewise the **activity** variable is the y_data with corrected names. 

**put_together** merges the corrected x_data, y_data and subject_data in a big dataset.

**finaldata** contains the tidied up put_together data set and writes it to a .txt file. 