## R_DSIS_problem_set_vectors_matrices_week2.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2025, Fall 2023, Winter 2023, Winter 2022
##
## Week 2
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Instructions:
##
## This is an optional problem set that covers material in Davies Ch.2 and Ch.3.
## Please feel free to try any or all of the questions.
## I am happy to go over each question with you individually during office hours.
## If there is sufficient interest (majority vote), I will go over specific problems in class.
##
##########################################################################
## Problem 1
##########################################################################
## (1a) Create a numeric vector that contains the numbers -5 to 11 by 1.
## (1b) Create a numeric vector that contains the numbers -5 to 11 by 0.3.
## (1c) Create a numeric vector that contains the numbers -5 to 11 that is length 100.


##########################################################################
## Problem 2
##########################################################################
## (2a) Create a numeric vector that contains the set of numbers: -1,3,-5,7,-9.
## (2b) Sort the vector and print the results.
## (2c) Use the order() function instead of the sort() function to accomplish the same task in (2b).
## (2d) Replicate the vector created in (2a) 3 times.
## (2e) Replicate each value in the vector created in (2a) 2 times so that the same number is positioned next to itself in the vector.


##########################################################################
## Problem 3
##########################################################################
## (3a) Use the Fahrenheit_Celsius() function defined below to convert the following vector to Celsius: 45, 77, 20, 19, 101, 120, 212.

Fahrenheit_Celsius <- function(Fahrenheit_vector){
    Celsius <- (5/9) * (Fahrenheit_vector - 32)
    return(Celsius)
}

Fahrenheit_Celsius()

## (3b) Use the relevant portions of the Fahrenheit_Celsius() function to program the same equation (i.e., take the equation in the function and use it outside of the function).
## (3c) Convert the Fahrenheit_Celsius function into a Celsius_Fahrenheit function (i.e., a function that convers Celsius values into Fahrenheit (hint: start with the code outside of the function).
## (3d) Create a program that converts miles into kilometers.
## (3e) Convert (3d) into a function that converts miles into kilometers.


##########################################################################
## Problem 4
##########################################################################
## (4a) Create two numeric vectors of the same length.
## (4b) Use R to prove that the vectors are the same length.
## (4c) Use the c(), cbind(), and rbind() functions to put these two vectors together.
## (4d) Describe the output of these three functions in the comment section of your code.
## (4e) Use additional functions from R to generate additional numeric information about the output of these three functions.


##########################################################################
## Problem 5
##########################################################################
## (5a) Create a numeric matrix of any size. What are the dimension sizes for this new object?
## (5b) Create a new numeric matrix using the odd columns of the matrix created in (5a). What are the dimension sizes for this new object?
## (5c) Create a new numeric matrix using the even columns and even rows of the matrix created in (5b). What are the dimension sizes for this new object?
## (5d) Repeat (5a) - (5c) for an array of 3 dimensions. What are the dimension sizes for this new object?


##########################################################################
## Problem 6
##########################################################################
## (6) If you are feeling adventurous, complete exercise 3.2 on page 52 in Davies Ch.3. Please note that this set of problems requires a little more knowledge of linear algebra than we have covered in class so far and I do not expect you to master this material in this course. We will cover it a little more in detail in Week 12.


