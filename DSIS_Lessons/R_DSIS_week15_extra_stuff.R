## R_DSIS_week15_extra_stuff.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2023
##
## Week 15
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
##
## tidyverse website:
## https://www.tidyverse.org/
##
##
## tidyverse pipe operator:
## https://style.tidyverse.org/pipes.html
## https://r4ds.had.co.nz/pipes.html
##
##########################################################################
## Introduction to tutorial:
## For this R tutorial, we will learn:
##
## (1) learn about the "pipe" operator and other tidyverse stuff
##
##########################################################################

library(tidyverse)

## simulate two variables and storing 2 variables in a matrix
x <- matrix(NA, ncol=2, nrow=1000)
x[,1] <- rnorm(1000)
x[,2] <- rnorm(1000)

## plot the 2 columns in the x matrix
par(mfrow=c(2,2))
plot(x, col=2)

## more compact version of simulating and storing 2 variables in a matrix
x <- matrix(rnorm(1000*2), ncol=2, nrow=1000)

## plot the 2 columns in the x matrix
plot(x, col=3)


## using the pipe operator
x <- rnorm(1000) %>%
    matrix(ncol = 2)

## plot the 2 columns in the x matrix
plot(x, col=4)


## do everything at once and don't save the x matrix
rnorm(1000) %>%
  matrix(ncol = 2) %>%
  plot() 



