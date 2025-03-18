## R_DSIS_problem_set_lists_dataframes_tables_week4.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2025, Fall 2023, Winter 2023, Winter 2022
##
## Week 4
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Instructions:
##
## This is an optional problem set that covers material in Davies Ch.8.
## Please feel free to try any or all of the questions.
## I am happy to go over each question with you individually during office hours.
##
##
##########################################################################
## Problem 1
##########################################################################
## go to https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/TADPGE/6NUGVO
## download the HumanRightsProtectionScores_v3.01.csv and put it in your working directory
##
## (1a) read the HumanRightsProtectionScores_v3.01.csv file in from your current working directory
## (1b) print the variables names in the object
## (1c) print the dimensions of the object using multiple functions
## (1d) print the first 6 rows in the data set
## (1e) print the last 6 rows in the data set
## (1f) summarize all the variable in the data set
## (1g) calculate the mean value for each numeric variable (hint: you will need to add the ra.rm=T argument to the mean() function)
## (1h) report how many missing values exist for each variable


##########################################################################
## Problem 2
##########################################################################
## go to https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/TADPGE/FD3LHV&version=1.1
## this page contains variable information about each variable in the dataset
##
## (2a) create tabulations for the categorical variables in the data set (DISAP KILL POLPRIS TORT Amnesty State HRW hathaway ITT genocide rummel massive_repression executions negative_sanctions mass_killing)
## (2b) create some cross-tabulations between any pair of these variables


##########################################################################
## Problem 3
##########################################################################
## (3a) subset the dataset into a new object for ONLY one country
## (3b) make a plot with the year variable and one additional variable for the country specific dataset
## (3c) add several additional arguments to make the plot from (2b) more interesting and informative (see the example from R_DSIS_lists_dataframes_week4.R lesson)


##########################################################################
## Problem 4 (Advanced)
##########################################################################
## (4a) using the dataset created in (1a), create a list in which each element is the country specific data frame so that there is one list element for every country
## (4b) use a for loop to generate a graph like the one from (3c) for the first 10 countrys in the list object


##########################################################################
## Problem 5 (Advanced)
##########################################################################
## (5a) select another country-year variable from the ourworldindata.org website
## (5b) download the dataset as csv file and load it into R
## (5c) use the merge function to combine the two csv files that you have loaded in (1) and (5)
## (5d) repeat steps (1b) - (1f) for the new combined file
## (5e) use the plot() function with one variable from each of the two datasets (add additional arguments to make the graph interesting and informative)

