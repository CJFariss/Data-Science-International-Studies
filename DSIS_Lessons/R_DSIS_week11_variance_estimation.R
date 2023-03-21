## R_DSIS_week11_variance_estimation.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2022, Winter 2021, Winter 2020
##
## Week 11
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
##
## Two websites that let you guess the correlation coefficient:
## 
## http://guessthecorrelation.com/
## http://istics.net/Correlations/
##
## Check out this additional resources:
## https://tinystats.github.io/teacups-giraffes-and-statistics/04_variance.html
## https://tinystats.github.io/teacups-giraffes-and-statistics/05_correlation.html
##
##########################################################################
## Introduction to tutorial:
## For this R tutorial, we will learn:
##
## Variance: a measure of the squared distance from the mean value of a variable to all other values of the variable (strictly positive).
##
## Standard deviation: a measure of the distance from the mean value of a variable to all other values of the variable (strictly positive).
## 
## Covariance: a measure of the product of the distance from the mean values of two variables from each of the other values of the variable (strictly positive).
##
## Correlation: standardized measure of covariance that ranges between -1 and 1.
##
##
##
##########################################################################

## Use the normal distribution to simulate two variables 
sim_n <- 100
x1 <- rnorm(sim_n, 0, 1)

summary(x1)
#x1

library(MASS)
truehist(x1)

x2 <- 0 + 1*x1 + rnorm(sim_n, 0, 1)

## check the simulation visually
plot(x1, x2)
abline(a=0,b=1,col=2)


## calculate the variance and standard deviation of the first variable
var(x1) ## variance 
sqrt(var(x1)) ## standard deviation
sd(x1) ## standard deviation

## calculate the variance and standard deviation of the second variable
var(x2) ## variance
sqrt(var(x2)) ## standard deviation
sd(x2) ## standard deviation

## calculate the relationship between the variance of the two variables (covariance and correlation)
cov(x1, x2) ## covariance
cor(x1, x2) ## correlation


## calculate the distance from the mean
x1_distance <- x1 - mean(x1)
x2_distance <- x2 - mean(x2)

## calculate the squared distance
x1_squared_distance <- x1_distance^2
x2_squared_distance <- x2_distance^2

## summarize the squared distance
summary(x1_squared_distance)
summary(x2_squared_distance)

## calculate the variance of x1
variance_x1 <- sum(x1_squared_distance)/(sim_n - 1)
variance_x1

## calculate the variance of x1
var(x1)

## calculate the variance of x2
variance_x2 <- sum(x2_squared_distance)/(sim_n - 1)
variance_x2

## calculate the variance of x2
var(x2)


## multiply each distance variable, which is called the crossproduct
x1x2_distance_product <- x1_distance * x2_distance

summary(x1x2_distance_product)

covariance_x1x2 <- sum(x1x2_distance_product)/(sim_n - 1)
covariance_x1x2
cov(x1, x2)

## standardize the covariance by dividing by the product of the two standard deviations
covariance_x1x2/(sd(x1)*sd(x2))
cor(x1, x2)


##########################################################################
## the relationship between the simulated correlation estimated by several functions
##########################################################################

## define a function to transform a variable so that it has mean 0 and sd 1
standarize_function <- function(x){
  (x-mean(x))/sd(x)
}

summary(scale(x1))
summary(standarize_function(x1))

## test that all values returned from the two functions are equal
all(scale(x1)==standarize_function(x1))

## view the variance from the returned values of the two function
var(scale(x1))
var(standarize_function(x1))

## view the covariance of the two variables 
cov(x1,x2)

## view the correlation of the two variables 
cor(x1,x2)

## view the covariance of the standardized values of the two variables 
cov(scale(x1), scale(x2))

## test if the values of the standardized values of the two variables are equal to the correlation of hte two variables
cor(x1,x2) == cov(scale(x1), scale(x2))


## use the linear model function lm() to calculate the correlation coefficient 
fit <- lm(x2 ~ x1)
summary(fit)

## print the r-squared value
summary(fit)$r.squared

## calculate the square root of the r-squared value from the bivariate regression which is the correlation coefficient
sqrt(summary(fit)$r.squared)

## test if the r-squared value from the bivariate regression which is the correlation coefficient
cor(x1,x2) == sqrt(summary(fit)$r.squared)

## standardize the x2 variable 
fit <- lm(scale(x2) ~ x1)
summary(fit)

## standardize the x2 variable and set the intercept to 0 (i.e., do not estimate the intercept, alpha, or b0)
fit <- lm(scale(x2) ~ -1 + x1)
summary(fit)

## standardize the x2 variable, the x1 variable, and set the intercept to 0
fit <- lm(scale(x2) ~ -1 + scale(x1))
summary(fit)

## notice that the correlation is the same as the regression coefficient from the summary() function above
cor(x1, x2)

## test 
summary(fit)$coefficients[1] == cor(x1, x2)

## the test above is false because of a round error
## use the round function to determine how many digits the test above is TRUE before becoming FALSE

## THIS IS JUST FOR FUN
significant_digit <- 0
test <- TRUE
repeat{
  test <- round(summary(fit)$coefficients[1], significant_digit) == round(cor(x1, x2), significant_digit)
  if(test==FALSE) break
  significant_digit <- significant_digit + 1
}
significant_digit

## double check
round(summary(fit)$coefficients[1], significant_digit-1) == round(cor(x1, x2), significant_digit-1)
round(summary(fit)$coefficients[1], significant_digit) == round(cor(x1, x2), significant_digit)

## so the correlations coefficient from the lm() function compared to the cor() function are equivalent to the 16th significant digit (i.e., 0.0000000000000000).

print(summary(fit)$coefficients[1], significant_digit-1)
print(cor(x1, x2), significant_digit-1)

## the difference between the two values is 0.0000000000000003
print(summary(fit)$coefficients[1], significant_digit)
print(cor(x1, x2), significant_digit)

## we can print out to 22 significant digits in R (note: that this number may be different depending on your computer)
significant_digit+6

print(summary(fit)$coefficients[1], significant_digit+6)
print(cor(x1, x2), significant_digit+6)
