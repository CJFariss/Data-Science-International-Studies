## R_DSIS_week11_linear_model_estimation.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2026, Winter 2025, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
##
## Week 11
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## For this R tutorial, we will learn how:
##
## (1) Simulates two variable OLS regression in R (ordinary least squares regression).
## (2) Find the coordinates of the best estimates using the a "brute force" method.
## (3) Find the best estimates using the linear model lm() function.
## (4) Find the best estimates using a user defined function which is passed to the optim() function
## (5) Visualize the results using the contour plot function from the graphics library
## (6) Simulate the model where the independent variable x is continuous and binary
## (7) Appendix details for logistic regression with a binary Dependent Variable
## (8) Appendix showing relationship between coefficients in a linear model and logistic regression model
##
##########################################################################

## install the library if necessary
## install.packages(c("graphics", "mvtnorm"))

## load necessary libraries
library(graphics)
library(mvtnorm)


##########################################################################
## when x1 (independent variable) is continuous and y (dependent variable) is continuous
##########################################################################

## generate simulated vales
n <- 100
x1 <- rnorm(n,0,1)

## make design matrix
X <- cbind(1, x1)

head(X)

## inspect 
dim(X)

k <- ncol(X)
k

# select true population parameters
alpha <- 1.250000
beta <- 3.500000

# generate y with error
error_term <- rnorm(n)
summary(error_term)

y <- alpha * X[,1] + beta * X[,2] + error_term
#y <- alpha + beta * x1 + error_term

summary(y)

## plot the x1 and y variable in 2D euclidean space
par(mfrow=c(1,1))
plot(x1, y)
abline(a=alpha, b=beta, col=2)

cor(y, x1)

## estimate the fit of the linear model
fit <- lm(y ~ x1)
fit

## print the summary for the fit object
summary(fit)

## plot the line of best fit
abline(reg=fit, col=4)

fit$coefficients

## plot the error lines between the y points and the estimated y_hats (the line of best fit)
for(i in 1:n){
    lines(x=c(x1[i], x1[i]), y=c(fit$coefficients[1]+fit$coefficients[2]*x1[i], y[i]), col=grey(.5), lwd=.5)
}

## use linear algebra to find the Best estimates (this is why we defined X with a column of 1s)
beta_estimate <- solve(t(X) %*% X) %*% t(X)%*%y
beta_estimate

## generate vector of possible values for the parameter estimates of alpha and beta by brute force
alpha_hat <- seq(from=-6,6,.05)
beta_hat <- seq(from=-6,6,.05)

sumsquare <- matrix(NA, nrow=length(alpha_hat), ncol=length(beta_hat))

dim(sumsquare)

## grid search for best linear model parameters
for(i in 1:length(alpha_hat)){
    for(j in 1:length(beta_hat)){
        y_hat <- alpha_hat[i] * X[,1] + beta_hat[j] * X[,2]
        sumsquare[i,j] <- -sum((y-y_hat)^2)
    }
}

sumsquare[1:10, 1:10]

## find the coordinates from the matrix where the minimum of the sum of square residuals resides
coordinates <- which(sumsquare == sumsquare[-sumsquare==min(-sumsquare)], arr.ind = TRUE) ## this is hard to think about 
coordinates
coordinates <- which(sumsquare == max(sumsquare), arr.ind = TRUE)
coordinates

## these coordinates match the best estimates of the alpha and beta parameters
parameters <- c(alpha_hat[coordinates[1]], beta_hat[coordinates[2]])
parameters # notice that these estimates are much less precise than the estimates obtained below

## counter plot from the brute force method (logged for visualization)
par(mar=c(5,5,1,1))
contour(alpha_hat, beta_hat, log(-sumsquare), xlab=expression(hat(alpha)), ylab=expression(hat(beta)), cex.lab=1.5)
abline(v=parameters[1], col=2, lwd=2, lty=2)
abline(h=parameters[2], col=2, lwd=2, lty=2)

## generate variables for monitoring the function
eval <- array(dim=c(1000,3))
iter <- 1

# user defined function passed to optim
ols_func <- function(par, X, iterate=TRUE){
    alpha_hat <- par[1]
    beta_hat <- par[2]
    y_hat <- alpha_hat + beta_hat * X[,2]
    #out <- -sum((y-y_hat)^2)
    out <- sum(log(dnorm(y, mean=y_hat, sd=1)))
    
    if(iterate==TRUE){
        eval[iter,1] <<- alpha_hat
        eval[iter,2] <<- beta_hat
        eval[iter,3] <<- out
        iter <<- iter+1
    }
    return(out)
}

## pass function to optim with initial values
optim_out <- optim(par = c(0,0), ols_func, X=X, method="BFGS", control=list(fnscale = -1), hessian = TRUE)
optim_out

## estiamte additional quantities of interest
se <- sqrt(diag(solve(-optim_out$hessian))) #calculate standard errors
VCV <- solve(-optim_out$hessian) #compute variance-covariance matrix
se
VCV

## compare with results from the lm function
summary(lm(y~x1))


## plot gradient paths for the following algorithims: "Nelder-Mead", "BGFS", "CG", "L-BFGS-B", "SANN"
eval <- array(dim=c(1500,4))
iter <- 1
optim_out <- optim(par = c(-2,-2), ols_func, X=X, method="Nelder-Mead", control=list(fnscale = -1), hessian = TRUE)
contour(alpha_hat, beta_hat, log(-sumsquare), xlab=expression(hat(alpha)), ylab=expression(hat(beta)), cex.lab=1.5)
lines(eval[1:iter,1], eval[1:iter,2], col="purple", lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim_out <- optim(par = c(0,0), ols_func, X=X, method="BFGS", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=2, lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim_out <- optim(par = c(0,0), ols_func, X=X, method="CG", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=3, lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim_out <- optim(par = c(0,0), ols_func, X=X, method="L-BFGS-B", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=4, lwd=4)
optim.out$par
iter

eval <- array(dim=c(20000,4))
iter <- 1
optim_out <- optim(par = c(0,0), ols_func, X=X, method="SANN", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=5, lwd=4)
optim.out$par
iter






##########################################################################
## when x1 (independent variable) is binary and y (dependent variable) is continuous
##########################################################################


## generate simulated vales
n <- 50
x1 <- rbinom(n,size=1,.5)

## make design matrix
X <- cbind(1, x1)

k <- ncol(X)

## select true population parameters
alpha <- 1.250000
beta <- 2.500000

## generate y with error
error_term <- rnorm(n)
y <- alpha * X[,1] + beta * X[,2] + error_term

## plot the x1 and y variable in 2D euclidean space
plot(x1, y)
abline(a=alpha, b=beta, col=2)

## estimate the fit of the linear model
fit <- lm(y~x1)

## print the summary for the fit object
summary(fit)

## plot the line of best fit
abline(reg=fit, col=4)

## plot the error lines between the y points and the estimated y_hats (the line of best fit)
for(i in 1:n){
    lines(x=c(x1[i], x1[i]), y=c(fit$coefficients[1]+fit$coefficients[2]*x1[i], y[i]), col=grey(.5), lwd=.5)
}

## use linear algebra to find the Best estimates (this is why we defined X with a column of 1s)
beta_estimate <- solve(t(X) %*% X) %*% t(X)%*%y
beta_estimate

## what is the beta estimate here? It is also the difference in proportion of y when x==1 and x==0
mean(y[x1==1]) - mean(y[x1==0])

## this is the proportion of y when x==1
mean(y[x1==1])

## this is the interce`pt  (the proportion of y when x==0)
mean(y[x1==0])


## generate vector of possible values for the parameter estimates of alpha and beta by brute force
alpha_hat <- seq(from=-6,6,.05)
beta_hat <- seq(from=-6,6,.05)

sumsquare <- matrix(NA, nrow=length(alpha_hat), ncol=length(beta_hat))
for(i in 1:length(alpha_hat)){
    for(j in 1:length(beta_hat)){
        y_hat <- alpha_hat[i] + beta_hat[j] * X[,2]
        sumsquare[i,j] <- -sum((y-y_hat)^2)
    }
}

## find the coordinates from the matrix where the minimum of the sum of square residulas resides
coordinates <- which(sumsquare == sumsquare[-sumsquare==min(-sumsquare)], arr.ind = TRUE) ## this is weird 
coordinates <- which(sumsquare == max(sumsquare), arr.ind = TRUE)
coordinates

## these coordinates match the best estimates of the alpha and beta parameters
parameters <- c(alpha_hat[coordinates[1]], beta_hat[coordinates[2]])
parameters # notice that these estimates are much less precise than the estiamtes obtained below

## counter plot from the brute force method (logged for visualization)
par(mar=c(5,5,1,1))
contour(alpha_hat, beta_hat, log(-sumsquare), xlab=expression(hat(alpha)), ylab=expression(hat(beta)), cex.lab=1.5)
abline(v=parameters[1], col=2, lwd=2)
abline(h=parameters[2], col=2, lwd=2)


## generate variables for monitoring the function
eval <- array(dim=c(1000,3))
iter <- 1

# user defined function passed to optim
## see above

## pass function to optim with initial values
optim_out <- optim(par = c(0,0), ols_func, X=X, method="BFGS", control=list(fnscale = -1), hessian = TRUE)
optim_out

## estiamte additional quantities of interest
se <- sqrt(diag(solve(-optim_out$hessian))) #calculate standard errors
VCV <- solve(-optim_out$hessian) #compute variance-covariance matrix
se
VCV

## compare with results from the lm function
summary(lm(y~x1))


## plot gradient paths for the following algorithims: "Nelder-Mead", "BGFS", "CG", "L-BFGS-B", "SANN"
eval <- array(dim=c(1500,4))
iter <- 1
optim_out <- optim(par = c(-2,-2), ols_func, X=X, method="Nelder-Mead", control=list(fnscale = -1), hessian = TRUE)
contour(alpha_hat, beta_hat, log(-sumsquare), xlab=expression(hat(alpha)), ylab=expression(hat(beta)), cex.lab=1.5)
lines(eval[1:iter,1], eval[1:iter,2], col="purple", lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim_out <- optim(par = c(0,0), ols_func, X=X, method="BFGS", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=2, lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim_out <- optim(par = c(0,0), ols_func, X=X, method="CG", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=3, lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim_out <- optim(par = c(0,0), ols_func, X=X, method="L-BFGS-B", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=4, lwd=4)
optim.out$par
iter

eval <- array(dim=c(20000,4))
iter <- 1
optim_out <- optim(par = c(0,0), ols_func, X=X, method="SANN", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=5, lwd=4)
optim.out$par
iter


##########################################################################
## Appendix
## logistic regression simulation
##########################################################################

# One variable simulation of a binary dependent variable y and one independent variable x
# using (1) a user defined numerical function, (2) a user defined function optimized with the
# optim function in R, (3) the generalized linear model function glm in R, (4) a Gibbs sampler

#install.packages("graphics")
library(graphics)

# simulate x1 and set the "true" population values alpha and beta
n <- 100
x1 <- rnorm(n,0,1)
alpha <- 1.250000
beta <- 2.500000

# systematic component of the model
xb <-  alpha + beta * x1

# transform the linear term xb using the logit function so that theta is bound from 0 to 1
prob_y <-  1 / (1 + exp(-xb))

# generate the dependent variable y with theta and measurment error
#error <- runif(n,0,1)
#y <- ifelse(error < prob_y,1,0)
y <- rbinom(n, size=1, prob=prob_y)

# column bind all x variables (there is only one x in this version of the simulation)
x <- cbind(x1)

# generate the number of k variables in the regression
k <- ncol(x) 

# column bind the x variables to a vector of 1s to form the X-variable matrix
X <- cbind(1, x)

# create a likelihood-matrix of possible values for beta0 and beta1 as the corrdinates within that matrix
alpha_hat <- seq(-5, 5, 0.1)  # these sequences should technically range from -Inf to Inf
beta_hat <- seq(-5, 5, 0.1)  # but we know that the parameter values that maximize the likelihood lie within their range
likelihood <- matrix(NA, nrow=length(b0), ncol=length(b1))


## define inverse logit function
inverse_logit_func <- function(value){
  return(as.numeric(1/(1 + exp(-value))))
}

# fill in the values of the matrix using the coordinates in b0 and b1 as possible parameter values that will maximize the likelihood
for(i in 1:length(alpha_hat)){
  for(j in 1:length(beta_hat)){ 
    prob_hat <- inverse_logit_func(alpha_hat[i] + beta_hat[j] * X[,2])
    #likelihood[i,j] <- sum(log(dbinom(y, size=1, prob=prob_hat)))
    likelihood[i,j] <- sum(log((prob_hat^y * (1-prob_hat)^(1-y)))) ## p^y * (1-p)^(1-y) from the Bernoulli distribution
  }
}

coordinates <- which(likelihood == max(likelihood), arr.ind = TRUE)
coordinates

## these coordinates match the best estimates of the alpha and beta parameters
parameters <- c(alpha_hat[coordinates[1]], beta_hat[coordinates[2]])
parameters # notice that these estimates are much less precise than the estiamtes obtained below

## counter plot from the brute force method (logged for visualization)
par(mar=c(5,5,1,1), mfrow=c(1,1))
contour(alpha_hat, beta_hat, likelihood, xlab=expression(hat(alpha)), ylab=expression(hat(beta)), cex.lab=1.5)
abline(v=parameters[1], col=2, lwd=2)
abline(h=parameters[2], col=2, lwd=2)


# print the maximum value from the matrix, which should approximate the maximum likelihood estimate
max(likelihood)

# find the coordinates from the matrix where the likelihood resides
max(likelihood) == likelihood[coordinates[1], coordinates[2]]




# use the optim function R for faster and more precise results

# create a function that is passed to the optim function below
# par is the initial parameter values that optim starts with to maximize the function
# X is the matrix of covariates with a column of 1s, y is the observed dependent variable
# out the value of the log likelihood function that is returned by the function


logit_loglikelihood <- function(par, X, y){
  alpha_hat <- par[1]
  beta_hat <- par[2]
  prob_hat <- inverse_logit_func(alpha_hat + beta_hat * X[,2])
  #out <- sum(log(dbinom(y, size=1, prob=prob_hat)))
  out <- sum(log(prob_hat^y * (1-prob_hat)^(1-y))) ## p^y * (1-p)^(1-y) from the Bernoulli distribution
  return(out)
}

# pass the user defind function to optim with 0s as starting values for each parameter estimate
optim_out <- optim(par = c(0,0), logit_loglikelihood, y = y, X = X, method="BFGS", control=list(fnscale = -1), hessian = TRUE)

se <- sqrt(diag(solve(-optim_out$hessian))) #calculate standard errors
VCV <- solve(-optim_out$hessian) #compute variance-covariance matrix

# print the maximum likelihood, parameter estimates and standard errors of the parameter estimates
optim_out$value
optim_out$par
se

# check the values using the glm function
model <- glm(y ~ x1, binomial(link = "logit"))
logLik(model)
summary(model)$coefficients


# plot the likelihood function in space 
# 3D plot
persp(alpha_hat, beta_hat,  likelihood, theta = 45, phi = 30, shade=NA, col=5)

# 2D plots
par(mfrow=c(1,2))
plot(alpha_hat, likelihood[,coordinates[2]], type="l", ylim=c(min(likelihood), max(likelihood)), lwd=3, col=4, xlab="alpha", ylab="Likelihood Function")
points(alpha_hat[coordinates[1]], likelihood[coordinates[1],coordinates[2]], col=2, pch=19)

plot(beta_hat, likelihood[coordinates[1],], type="l", ylim=c(min(likelihood), max(likelihood)), lwd=3, col=4, xlab="beta", ylab="Likelihood Function")
points(beta_hat[coordinates[2]], likelihood[coordinates[1],coordinates[2]], col=2, pch=19)


##########################################################################
## Appendix
## relationship between coefficients in a linear model and logistic regression model
## note that the relationships below become more comlicated in models with more than 1 variable
##########################################################################

## define inverse logit function
inverse_logit_func <- function(value){
  return(as.numeric(1/(1 + exp(-value))))
}

n <- 10000

x <- c(rep(0,n/2),rep(1,n/2))

y <- -0.1 + .5 * x + rnorm(n)

mean(y[x==0])
mean(y[x==1])

mean(y[x==1]) - mean(y[x==0])

t.test(y~x)

lm(y~x)


## transform the linear component xb into a probability using the inverse logit function
xb <- -0.1 + .5 * x + rnorm(n)
prob_y <- inverse_logit_func(xb)
summary(prob_y)

mean(prob_y[x==0])
mean(prob_y[x==1])

y <- rbinom(n, size=1, prob=prob_y)

mean(y[x==0])
mean(y[x==1])
mean(y[x==1]) - mean(y[x==0])

fit <- glm(y ~ x, family=binomial("logit"))
summary(fit)

fit_lm <- lm(y ~ x)
summary(fit_lm)


## notice when we transform the logistic regression coefficients using the inverse logit function, we return the same coefficients from the linear model
inverse_logit_func(fit$coefficients[1] + fit$coefficients[2] * 1)

inverse_logit_func(fit$coefficients[1] + fit$coefficients[2] * 0)

inverse_logit_func(fit$coefficients[1] + fit$coefficients[2] * 1) - inverse_logit_func(fit$coefficients[1] + fit$coefficients[2] * 0)


fit1 <- glm(I(y[x==1]) ~ 1, family=binomial("logit"))
summary(fit1)

fit0 <- glm(I(y[x==0]) ~ 1, family=binomial("logit"))
summary(fit0)

inverse_logit_func(fit1$coefficients[1])
inverse_logit_func(fit0$coefficients[1])



##########################################################################
## Apendix: 
##distances and contour plot
##########################################################################

## create empty distance matrix
dist_mat <- matrix(NA, nrow=10, ncol=10)

dim(dist_mat)

coordinate_row <- 4
coordinate_col <- 4

## nested for loop calculation 
for(i in 1:10){
  for(j in 1:10){
    dist_mat[i,j] <- sqrt((i-coordinate_row)^2 + (j-coordinate_col)^2)
  }
}

dist_mat

## find the coordinates from the matrix where the minimum of the sum of square residuals resides
coordinates <- which(dist_mat == min(dist_mat), arr.ind = TRUE)
coordinates

## these coordinates match the best estimates of the alpha and beta parameters
parameters <- c(coordinates[1], coordinates[2])
parameters # notice that these estimates are mch less precise than the estimates obtained below

## counter plot from the brute force method (logged for visualization)
par(mar=c(5,5,1,1))
contour(1:10, 1:10, dist_mat, xlab="", ylab="", cex.lab=1.5)
abline(v=parameters[1], col=2, lwd=2)
abline(h=parameters[2], col=2, lwd=2)
points(parameters[1], parameters[2], col=1, pch="0")
points(parameters[1], parameters[2], col=2, cex=1.5)


## elementwise matrix calculation 
coordinate_row <- 4
coordinate_col <- 4
mat_row_coordinates <- matrix(rep(1:10,times=10), nrow=10, ncol=10)
mat_row_coordinates
mat_col_coordinates <- matrix(rep(1:10,each=10), nrow=10, ncol=10) 
mat_col_coordinates
dist_mat <- sqrt((mat_row_coordinates - coordinate_row)^2 + (mat_col_coordinates - coordinate_col)^2)
dist_mat

par(mar=c(5,5,1,1))
contour(1:10, 1:10, dist_mat, xlab="", ylab="", cex.lab=1.5)
abline(v=parameters[1], col=2, lwd=2)
abline(h=parameters[2], col=2, lwd=2)
points(parameters[1], parameters[2], col=2, cex=3)



## plots all the distances around the contours of the contour plot
par(mar=c(5,5,1,1))
contour(1:10, 1:10, dist_mat, xlab="", ylab="", cex.lab=1.5)
for(i in 1:10){
  for(j in 1:10){
    text(x=i, y=j, labels=as.character(round(dist_mat[i,j], digits=2)))
  }
}
points(parameters[1], parameters[2], col=2, cex=3)
points(parameters[1], parameters[2], col=2, cex=16)

