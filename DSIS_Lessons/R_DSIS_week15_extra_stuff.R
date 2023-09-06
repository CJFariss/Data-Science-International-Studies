## R_DSIS_week15_extra_stuff.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
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
## (1a) learn about the "pipe" operator |> for base R (this is only available in R versions 4.0 or greater)
## (1b) learn about the "pipe" operator %>% for the tidyverse 
##
##########################################################################

library(tidyverse)

## set the number of rows and columns for the plot
par(mfrow=c(3,2))


SIMS <- 500

##########################################################################
## base R examples
##########################################################################

## simulate two variables and storing 2 variables in a matrix
x <- matrix(NA, ncol=2, nrow=SIMS)
x[,1] <- rnorm(SIMS)
x[,2] <- rnorm(SIMS)
## plot the 2 columns in the x matrix
plot(x, col=2)

## more compact version of simulating and storing 2 variables in a matrix
x <- matrix(rnorm(SIMS*2), ncol=2, nrow=SIMS)

## plot the 2 columns in the x matrix
plot(x, col=3)


##########################################################################
## base R examples using the base pipe operator
##########################################################################

## using the base pipe operator
x <- rnorm(SIMS) |>
  matrix(ncol = 2)
## plot the 2 columns in the x matrix
plot(x, col=4)

## do everything at once and don't save the x matrix using the base pipe operator
rnorm(SIMS) |>
  matrix(ncol = 2) |>
  plot(col=1) 


##########################################################################
## base R examples using the tidyverse pipe operator
##########################################################################

## using the tidyverse operator
x <- rnorm(SIMS) %>%
    matrix(ncol = 2)
## plot the 2 columns in the x matrix
plot(x, col=5)

## do everything at once and don't save the x matrix using the tidyverse pipe operator
rnorm(SIMS) %>%
  matrix(ncol = 2) %>%
  plot(col=6) 




