## R_DSIS_week1_Introduction_week1.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2022
##
## week 1
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## For this R tutorial, we will learn how:
##  (1) to find and change the working directory,
##  (2) how to create objects in the workspace and save those objects to the working directory
##  (3) how to load libraries with additional functions
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
## The # character is what we call the "comment" character. When you want to write something in your code that you don't want to run, you need to "comment it out."

# I can write comments to the rigth of the comment character

##########################################################################
## the work space and working directoy
##########################################################################

## The working directory is the location where R will look for outside datasets

## what is the current working directory?
getwd()

## set the working directory to an object using the assignment operator <- or = (more on this later)
wd <- getwd()

## set the working directory to another folder (actually the same folder in this example)
setwd(wd)

setwd("/Users/cjfariss/Documents")

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
## naming conventions
##########################################################################

## R uses $ in a manner analogous to the way other languages use dot.
## we will look at the use of $ in more detail later
## R used dot in a similar way to the underscore
## The underscore character was once the assignment character in S (R's predecessor)
## you can use the underscore character now but more often dot is used instead
## I go back and forth between both


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
obj1+2
obj1*2
obj1^2

## remove just obj1 from memory
rm(obj1)

## removing objects is often not necessary but memory managment is sometimes important if your
## code is making new objects from old ones instead of overwriting old objects.
## I had to learn this the hard way.


##########################################################################
## packages/libraries
##########################################################################

## library(LIBRARY) loads a previously installed library
## install.packages("LIBRARY")

## unless you have previously installed this package, the following line should generate an error
library(ks)

## install the new package
install.packages("ks")

## load the new package once it is installed by the line abvove
library(ks)

## this function updates packages (we won't use this one too much)
#update.packages()


##########################################################################
## save the workspace as a binary file
##########################################################################

## the save() function allows you to save individual objects that are currently loaded in memory
save(obj1, file="Myobject.Rdata")

## the save.image() function allows you to save all of the objects that are currently loaded in memory
save.image(file="Myworkspace.Rdata")


## we will use other functions to save datasets later in the course

