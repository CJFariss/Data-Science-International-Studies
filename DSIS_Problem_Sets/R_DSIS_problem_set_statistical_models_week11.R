## R_DSIS_problem_set_statistical_models_week11.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## CODE CREATED BY: TYLER RONGXUAN CHEN (tylercr@umich.edu)
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2026
##
## Week 11
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Instructions:
##
## This is an optional problem set that covers material in Davies Ch.13
## (Elementary Statistics) and Davies Ch.20 (Simple Linear Regression).
## Please feel free to try any or all of the questions.
## I am happy to go over each question with you individually during office hours.
##
##
##########################################################################
## Problem 1: Mean Estimation
##########################################################################
## (1a) create a numeric vector x with the values 2, 4, 6, 8, 10
## (1b) calculate the mean of x using the mean() function
## (1c) calculate the mean of x by hand using sum() and length()
## (1d) verify that the two values from (1b) and (1c) are the same

## (1e) now let's estimate the mean using the normal density approach from the lesson
## fix sigma to 1 and create a vector of candidate mu_hat values from -5 to 15 in steps of 0.1
## (1f) write a for loop that calculates the sum of the log-densities for each candidate mu_hat value:
##      sum(log(dnorm(x, mean=mu_hat[i], sd=sigma)))
##      store each result in a vector called sum_log_dens
## (1g) which value of mu_hat gives the largest sum of log-densities?
##      use which() to find the coordinate and then index into mu_hat to find the value
## (1h) plot mu_hat on the x-axis and sum_log_dens on the y-axis
##      add a vertical red line at the true mean using abline(v=mean(x), col=2, lwd=3)
## (1i) does the maximum of the log-density loss function match the calculated mean from (1b)?


##########################################################################
## Problem 2: Variance and Correlation Estimation
##########################################################################
## (2a) use rnorm() to simulate 100 observations from a normal distribution with mean=0 and sd=2, call this x1
## (2b) create a second variable x2 that is related to x1:
##      x2 <- -1 + 2.5*x1 + rnorm(100, 0, 1)
## (2c) calculate the variance of x1 by hand:
##      compute the distance from the mean for each value: x1 - mean(x1)
##      square each distance
##      sum the squared distances and divide by (n-1)
## (2d) verify that your hand calculation matches var(x1)
## (2e) calculate the standard deviation of x1 by taking the sqrt() of the variance from (2c) and compare to sd(x1)

## (2f) calculate the covariance of x1 and x2 by hand:
##      compute x1_distance <- x1 - mean(x1)
##      compute x2_distance <- x2 - mean(x2)
##      compute the crossproduct: x1_distance * x2_distance
##      sum the crossproduct values and divide by (n-1)
## (2g) verify that your hand calculation matches cov(x1, x2)

## (2h) calculate the correlation of x1 and x2 by hand:
##      divide the covariance from (2f) by the product of the two standard deviations: sd(x1)*sd(x2)
## (2i) verify that your hand calculation matches cor(x1, x2)

## (2j) make a scatterplot of x1 and x2 using plot(x1, x2)


##########################################################################
## Problem 3: Simple Linear Regression with lm()
##########################################################################
## use the same x1 and x2 variables from Problem 2

## (3a) fit a linear model predicting x2 from x1 using lm() and store it in an object called fit
## (3b) print the summary of the fit object using summary(fit)
## (3c) what is the estimated intercept (alpha)? What is the estimated slope (beta)?
##      how close are these to the true values we used to simulate the data (-1 and 2.5)?
## (3d) plot x1 and x2 using plot(x1, x2) and add the regression line using abline(reg=fit, col=4)
## (3e) add the true line using abline(a=-1, b=2.5, col=2) -- how close are the two lines?

## (3f) extract the r-squared value from the model using summary(fit)$r.squared
## (3g) take the square root of the r-squared value -- what does this equal?
##      compare it to cor(x1, x2)


##########################################################################
## Problem 4: Linear Model Estimation by Brute Force
##########################################################################
## use the same x1, x2 variables and the design matrix approach from the lesson

## (4a) create the design matrix X by binding a column of 1s to x1: X <- cbind(1, x1)
## (4b) use linear algebra to find the best estimates: solve(t(X) %*% X) %*% t(X) %*% x2
##      compare these values to the coefficients from lm() in Problem 3

## (4c) now estimate the parameters using brute force:
##      create candidate values: alpha.hat <- seq(-4, 4, 0.1) and beta.hat <- seq(-1, 5, 0.1)
##      create an empty matrix to store the negative sum of squared residuals:
##      sumsquare <- matrix(NA, nrow=length(alpha.hat), ncol=length(beta.hat))
## (4d) write a nested for loop:
##      for each combination of alpha.hat[i] and beta.hat[j], calculate:
##      y.hat <- alpha.hat[i] * X[,1] + beta.hat[j] * X[,2]
##      sumsquare[i,j] <- -sum((x2 - y.hat)^2)
## (4e) find the coordinates of the maximum value in the sumsquare matrix using which() with arr.ind=TRUE
##      what are the best alpha.hat and beta.hat values?
## (4f) how do they compare to the estimates from lm() and from the matrix algebra solution?
##      why are the brute force estimates less precise?


##########################################################################
## Problem 5: Simulation and the optim() Function (advanced)
##########################################################################
## (5a) write a function called ols.func that takes three arguments: par, X, y
##      inside the function:
##        extract alpha.hat <- par[1] and beta.hat <- par[2]
##        calculate y.hat <- alpha.hat + beta.hat * X[,2]
##        calculate the log-likelihood: out <- sum(log(dnorm(y, mean=y.hat, sd=1)))
##        return(out)
## (5b) pass the function to optim() with initial values par=c(0,0), method="BFGS",
##      and control=list(fnscale=-1) to maximize the log-likelihood
## (5c) compare the optim() estimates to lm() -- they should be very close
## (5d) experiment with different starting values for par (e.g., par=c(-2,1) and par=c(3,5))
##      does optim() still converge to the same answer?
##      what happens if you try very extreme starting values like par=c(10,-10)? why?


##########################################################################
## Problem 6: Binary Independent Variable (advanced)
##########################################################################
## (6a) simulate a new dataset where x1 is binary: x1 <- rbinom(50, size=1, prob=0.5)
## (6b) generate y using: y <- 1.25 + 2.5*x1 + rnorm(50)
## (6c) fit the linear model: lm(y ~ x1) and print the summary
## (6d) what does the intercept represent when x1 is binary?
##      hint: compare the intercept to mean(y[x1==0])
## (6e) what does the slope represent when x1 is binary?
##      hint: compare the slope to mean(y[x1==1]) - mean(y[x1==0])
## (6f) plot x1 and y and add the regression line

