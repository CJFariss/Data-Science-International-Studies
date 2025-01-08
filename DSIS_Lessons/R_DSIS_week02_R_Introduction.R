## R_DSIS_week02_Introduction.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2024, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
##
## week 2 (Week 1 sometimes depending on the schedule)
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## For this R tutorial, we will learn how:
##  (1) to find and change the working directory,
##  (2) what the assignment operator "<-" is and how to use it
##  (3) how to create objects in the workspace and save those objects to the working directory
##  (4) how to load libraries with additional functions
##
##########################################################################
## There are many additional resources available online:
##
## "The Book of R" by Tilman M. Davies
## https://nostarch.com/bookofr
##
## "The Art of R Programming" by Norman Matloff
## http://nostarch.com/artofr.htm
##
## Quick-R for SAS/SPSS/Stata Users
## http://www.statmethods.net
##
## UCLA Statistical Computing (R and Stata)
## http://www.ats.ucla.edu/stat/
##
## R Seek (Search for R code)
## http://www.rseek.org/
##
## Simple R Plots
## http://www.phaget4.org/R/plot.html
##
##########################################################################



##########################################################################
## Getting Started
##########################################################################
##
## Note: see Davies (Ch.1) and Matloff (Ch.1) for more information on the material below
##
## When you open R, you are greeted by a prompt: >
## This is the character that indicates you can type in your command
## Your output will be prefaced by an index for the line number, such as [1]
## The # character is what we call the "comment" character. When you want to write something in your code that you don't want to run, you need to "comment it out." The # character used to be called the "pound sign" or "pound key on a phone. Now though it is probably best known as a hashtag.

# I can write comments to the right of the comment character

##########################################################################
## the work space and working directory
##########################################################################

## The working directory is the location where R will look for outside datasets

## what is the current working directory?
getwd()

## set the working directory to an object using the assignment operator <- or = (more on this later) but always use <-
wd <- getwd()

## print the wd object to the screen
## note that wd is a character or string variable which by convention we usually call the "path" or "file path"
wd

## set the working directory to another folder (actually the same folder in this example)
setwd(wd)

## two ways to move up one directory level
setwd("./..") ## or setwd("..")
getwd()

## move back down one level of the directory (note that you need to know the name of the directory-level or folder to move into)
setwd("./Data-Science-International-Studies")
getwd()

## another way to figure out which directory/folder that R is looking into is to use the list.files() function
list.files()

## list objects in the working environment
ls()

## remove all objects in the working environment
rm(list = ls())

## list objects in the working environment again
ls()

## getting help

## if you remember the function name use  a single question mark
?rm

## if you cannot remember the function name but remember something close try the double question mark
??remove

## OR you can use the help.search function with quotes for the words inside
## this function is especially useful if you want to search for more than one word
help.search("remove")

## you can also try google, Rseek or Quick R for help:
## R Seek (Search for R code)
## http://www.rseek.org/
##
## Quick-R for SAS/SPSS/Stata Users
## http://www.statmethods.net



##########################################################################
## object naming conventions
##########################################################################

## Objects in R can be named with any letter or LETTER from the alphabet, number, the dot sign ".", or the underscore sign "_"
## Objects cannot start with a number or "_" but can technically start with "."
## No other special characters or reserved operators can be used (e.g., @ $ & + - * or /)
##
## R uses $ in a manner analogous to the way other languages use "." dot.
## We will look at the use of $ in more detail later
## R uses "." dot in a similar way to the underscore
## The underscore character was once the assignment character in S (R's predecessor)
## You can use the underscore character now but more often dot is used instead
## I go back and forth between both but I try to avoide using "." most of the time now in my own code.


dice.roll <- 2
dice_roll <- 2

##########################################################################
## assignment operator
##########################################################################

## there are special functions called operators, which you are well familiar with like the plus sign: "+"

## the operator + takes two numeric arguments on it's left-hand and right-hand side and returns the sum of those two numbers
2+2

## the assignment operator is two symbols "<" the left chevron and the "-" minus sign or dash sign
## put these two symbols together with no space "<-" this is the assignment operator
## the assignment operator is a special function that takes two arguments
## the left-hand side argument is the object that R holds in memory
## the right-hand side argument is any value or function (which returns a value)

## the usage can look like:

## object <- some_value
object <- 2
object

## object <- some_function()
object <- sum(2,2)
object

## some_other_function <- function() ## note that function() is a function that creates a function() which we will talk about in a few weeks (week 6 and week 7)
some_other_function <- function(){}
some_other_function


##########################################################################
## more examples using the assignment operator
##########################################################################

## create an object and assign a scalar to it (it's really just a vector with one element)
obj1 <- 3

## display the value of the object
obj1

## redefine obj1
4 -> obj1
obj1

obj1 = 2
obj1

## use an object in a calculation
obj1 + 2
obj1 * 2
obj1 ^ 2

## remove just obj1 from memory
rm(obj1)

## removing objects is often not necessary but memory management is sometimes important if your
## code is making new objects from old ones instead of overwriting old objects.
## I had to learn this the hard way.


##########################################################################
## loading other functions from packages/libraries
##########################################################################

## library(LIBRARY) loads a previously installed library
## install.packages("LIBRARY")

## unless you have previously installed this package, the following line should generate an error
library(MASS)

## install the new package
install.packages("MASS")

## load the new package once it is installed by the line above
library(MASS)

## this function updates packages (we won't use this one too much)
#update.packages()


##########################################################################
## save the workspace as a binary file
##########################################################################

obj <- 3

## the save() function allows you to save individual objects that are currently loaded in memory
save(obj1, file="Datasets/Myobject.Rdata")

## the save.image() function allows you to save all of the objects that are currently loaded in memory
save.image(file="Datasets/Myworkspace.Rdata")


## we will use other functions to save datasets later in the course but we often do not need to save dataset files. Instead we will practice saving and updating the .R or R-script file (which is this lesson file is an example of).

