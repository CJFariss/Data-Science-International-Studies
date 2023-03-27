## R_DSIS_week11_linear_model_estimation.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2023, Winter 2022, Winter 2021, Winter 2020
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
## (1) Simulates two variable OLS regression in R.
## (2) Find the coordinates of the best estimates using the a "brute force" method.
## (3) Find the best estimates using the linear model lm() function.
## (4) Matrix algebra
## (5) Find the best estimates using a user defined function which is passed to the optim function
## (6) Visualize the results using the contour plot function from the graphics library
## (7) Simulate the model where the independent variable x is continous and binary
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
n <- 500
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
alpha.hat <- seq(from=-6,6,.05)
beta.hat <- seq(from=-6,6,.05)

sumsquare <- matrix(NA, nrow=length(alpha.hat), ncol=length(beta.hat))

dim(sumsquare)

for(i in 1:length(alpha.hat)){
    for(j in 1:length(beta.hat)){
        y.hat <- alpha.hat[i] * X[,1] + beta.hat[j] * X[,2]
        sumsquare[i,j] <- -sum((y-y.hat)^2)
    }
}

sumsquare[1:10, 1:10]

## find the coordinates from the matrix where the minimum of the sum of square residulas resides
coordinates <- which(sumsquare == sumsquare[-sumsquare==min(-sumsquare)], arr.ind = TRUE)
coordinates

## these coordinates match the best estimates of the alpha and beta parameters
par <- c(alpha.hat[coordinates[1]], beta.hat[coordinates[2]])
par # notice that these estimates are much less precise than the estimates obtained below

## counter plot from the brute force method (logged for visualization)
par(mar=c(5,5,1,1))
contour(alpha.hat,beta.hat,log(-sumsquare), xlab=expression(hat(alpha)), ylab=expression(hat(beta)), cex.lab=1.5)
abline(v=par[1], col=2, lwd=2)
abline(h=par[2], col=2, lwd=2)

## generate variables for monitoring the function
eval <- array(dim=c(1000,3))
iter <- 1

# user defined function passed to optim
ols.func <- function(par, X, iterate=TRUE){
    alpha.hat <- par[1]
    beta.hat <- par[2]
    y.hat <- alpha.hat + beta.hat * X[,2]
    out <- -sum((y-y.hat)^2)
    out <- sum(log(dnorm(y, mean=y.hat, sd=1)))
    
    if(iterate==TRUE){
        eval[iter,1] <<- alpha.hat
        eval[iter,2] <<- beta.hat
        eval[iter,3] <<- out
        iter <<- iter+1
    }
    return(out)
}

## pass function to optim with initial values
optim.out <- optim(par = c(0,0), ols.func, X=X, method="BFGS", control=list(fnscale = -1), hessian = TRUE)
optim.out

## estiamte additional quantities of interest
se <- sqrt(diag(solve(-optim.out$hessian))) #calculate standard errors
VCV <- solve(-optim.out$hessian) #compute variance-covariance matrix
se
VCV

## compare with results from the lm function
summary(lm(y~x1))


## plot gradient paths for the following algorithims: "Nelder-Mead", "BGFS", "CG", "L-BFGS-B", "SANN"
eval <- array(dim=c(1500,4))
iter <- 1
optim.out <- optim(par = c(-2,-2), ols.func, X=X, method="Nelder-Mead", control=list(fnscale = -1), hessian = TRUE)
contour(alpha.hat,beta.hat,log(-sumsquare), xlab=expression(hat(alpha)), ylab=expression(hat(beta)), cex.lab=1.5)
lines(eval[1:iter,1], eval[1:iter,2], col="purple", lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim.out <- optim(par = c(0,0), ols.func, X=X, method="BFGS", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=2, lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim.out <- optim(par = c(0,0), ols.func, X=X, method="CG", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=3, lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim.out <- optim(par = c(0,0), ols.func, X=X, method="L-BFGS-B", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=4, lwd=4)
optim.out$par
iter

eval <- array(dim=c(20000,4))
iter <- 1
optim.out <- optim(par = c(0,0), ols.func, X=X, method="SANN", control=list(fnscale = -1), hessian = TRUE)
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

## this is the intercent  (the proportion of y when x==0)
mean(y[x1==0])


## generate vector of possible values for the parameter estimates of alpha and beta by brute force
alpha.hat <- seq(from=-6,6,.05)
beta.hat <- seq(from=-6,6,.05)

sumsquare <- matrix(NA, nrow=length(alpha.hat), ncol=length(beta.hat))
for(i in 1:length(alpha.hat)){
    for(j in 1:length(beta.hat)){
        y.hat <- alpha.hat[i] + beta.hat[j] * X[,2]
        sumsquare[i,j] <- -sum((y-y.hat)^2)
    }
}

## find the coordinates from the matrix where the minimum of the sum of square residulas resides
coordinates <- which(sumsquare == sumsquare[-sumsquare==min(-sumsquare)], arr.ind = TRUE)

## these coordinates match the best estimates of the alpha and beta parameters
par <- c(alpha.hat[coordinates[1]], beta.hat[coordinates[2]])
par # notice that these estimates are much less precise than the estiamtes obtained below

## counter plot from the brute force method (logged for visualization)
par(mar=c(5,5,1,1))
contour(alpha.hat,beta.hat,log(-sumsquare), xlab=expression(hat(alpha)), ylab=expression(hat(beta)), cex.lab=1.5)
abline(v=par[1], col=2, lwd=2)
abline(h=par[2], col=2, lwd=2)


## generate variables for monitoring the function
eval <- array(dim=c(1000,3))
iter <- 1

# user defined function passed to optim
## see above

## pass function to optim with initial values
optim.out <- optim(par = c(0,0), ols.func, X=X, method="BFGS", control=list(fnscale = -1), hessian = TRUE)
optim.out

## estiamte additional quantities of interest
se <- sqrt(diag(solve(-optim.out$hessian))) #calculate standard errors
VCV <- solve(-optim.out$hessian) #compute variance-covariance matrix
se
VCV

## compare with results from the lm function
summary(lm(y~x1))


## plot gradient paths for the following algorithims: "Nelder-Mead", "BGFS", "CG", "L-BFGS-B", "SANN"
eval <- array(dim=c(1500,4))
iter <- 1
optim.out <- optim(par = c(-2,-2), ols.func, X=X, method="Nelder-Mead", control=list(fnscale = -1), hessian = TRUE)
contour(alpha.hat,beta.hat,log(-sumsquare), xlab=expression(hat(alpha)), ylab=expression(hat(beta)), cex.lab=1.5)
lines(eval[1:iter,1], eval[1:iter,2], col="purple", lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim.out <- optim(par = c(0,0), ols.func, X=X, method="BFGS", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=2, lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim.out <- optim(par = c(0,0), ols.func, X=X, method="CG", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=3, lwd=4)
optim.out$par
iter

eval <- array(dim=c(1500,4))
iter <- 1
optim.out <- optim(par = c(0,0), ols.func, X=X, method="L-BFGS-B", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=4, lwd=4)
optim.out$par
iter

eval <- array(dim=c(20000,4))
iter <- 1
optim.out <- optim(par = c(0,0), ols.func, X=X, method="SANN", control=list(fnscale = -1), hessian = TRUE)
lines(eval[1:iter,1], eval[1:iter,2], col=5, lwd=4)
optim.out$par
iter



