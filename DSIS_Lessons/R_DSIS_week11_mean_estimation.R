## R_DSIS_week11_mean_estimation.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
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
## (1a) Use the normal density function to see that it is useful for many applications
## (1b) Specifically, we will estimate a mean instead of calculating it directly using a combination of values from the normal density function
## (1c) Use a normal density function to construct a likelihood function or loss function to evaluate how well/close the estimate mean is to the observed data values
## (2) Observe that calculating the true mean is very simple so it is easy to verify that the combination of density functions gives the same answer as the simple calculation
## (3) Note that there are more complicated models where estimating the best set of parameters is not as easy as simply calculating the mean. We will use this combination of density function values to find the best set of parameters. Sometimes this is called maximum likelihood estimation or MLE for short
##
##########################################################################

## install the library if necessary
## load packages
pkgs <- c("MASS")
invisible(sapply(pkgs, require, character.only = TRUE))

## create sequence of real numbers
#x <- seq(-3,3,.1)
x <- 1:5
x
mean(x)
sum(x)/length(x)


## reminnders
curve(expr=dnorm(x, mean=0, sd=1), ylab="Pr(X=x)", type="l", xlim=c(-4,4), ylim=c(0,1.05), lwd=3, col="navy", main="N(0,.5^2) Density")

curve(expr=dnorm(x, mean=3, sd=1), ylab="Pr(X=x)", type="l", xlim=c(-4,4), ylim=c(0,1.05), lwd=3, col="navy", main="N(0,.5^2) Density")


## set mean and variance parameters
mu <- 0
sigma <- 1
sigma_pow2 <- sigma^2

## calculate the density using the normal distribution function
x_density <- 1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)
x_density

## plot the two estimated densities to verify that they are the same
plot(x, x_density)

## calculate the density using the normal distribution function built into R
x_dnorm <- dnorm(x, mean=mu, sd=sigma)
x_dnorm

## plot the two estimated densities to verify that they are the same
plot(x, x_dnorm)

## program a function
normal_density <- function(data, mu, sigma){
    1/(sigma*sqrt(2*pi)) * exp(-(data - mu)^2/2*sigma^2)
}

## let's change the mean
normal_density(data=x, mu=3, sigma=1)

## plot the two estimated densities to verify that they are the same
par(mfrow=c(1,1), mar=c(4,4,1,1))
plot(x, normal_density(data=x, mu=0, sigma=1))
plot(x, normal_density(data=x, mu=1, sigma=1))
plot(x, normal_density(data=x, mu=2, sigma=1))
plot(x, normal_density(data=x, mu=3, sigma=1))
plot(x, normal_density(data=x, mu=4, sigma=1))
plot(x, normal_density(data=x, mu=5, sigma=1))

## data (we want the mean estimate for this numeric vector)
x <- c(1,2,3,4,5)
x

mean(x)
sum(x)/length(x)

## fix sigma to 1
sigma <- 1

## let's check to see if the best estimate for the mean is 1
mu <- 1
sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))
prod(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2))

prod(1:3)

## let's check to see if the best estimate for the mean is 2
mu <- 2
sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))

## let's check to see if the best estimate for the mean is 3
mu <- 3
sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))

## let's check to see if the best estimate for the mean is 4
mu <- 4
sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))

## let's check to see if the best estimate for the mean is 5
mu <- 5
sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))

## is there any value of mu that generates a larger sum of logged values than 3?


## data (we want the mean estimate for this numeric vector)
x <- c(1,2,3,4,5)
x

#x <- runif(100)
truehist(x)

## vector to keep track of the loss function values
sum_log_dens <- NA
sum_log_dens_dnorm <- NA
sum_dens_ssqd <- NA
min_sum_dens_ssqd <- NA

## candidate values for our estimate of mu, which is the mean value we are trying to estimate
mu_hat <- seq(-10,10,.5)
mu_hat

## loop through all the mu_hat values to determine which one is the best using the sum of the logged densities
for(i in 1:length(mu_hat)){
    
    ## set mu_hat value to mu for the loss evaluation (mu is different for each iteration of the loop)
    mu <- mu_hat[i]
    
    ## normal density loss function
    sum_log_dens[i] <- sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))

    ## dnorm loss function
    sum_log_dens_dnorm[i] <- sum(log(dnorm(x=x,mean=mu,sd=sigma)))

    ## ssdq sum of squared differences loss function (maximize)
    sum_dens_ssqd[i] <- sum((x-mu)^2)

    ## negative ssdq sum of squared differences loss function (minimize)
    min_sum_dens_ssqd[i] <- -sum((x-mu)^2)

}

par(mfrow=c(2,2), mar=c(4,4,2,.5))

## plot the normal density loss function
plot(mu_hat, sum_log_dens, main="normal density loss function")
abline(v=mean(x), col=2, lwd=3)

## plot the dnorm loss function
plot(mu_hat, sum_log_dens_dnorm, main="normal density loss function")
abline(v=mean(x), col=2, lwd=3)

## plot the ssdq sum of squared differences loss function
plot(mu_hat, sum_dens_ssqd, main="minimized squared differences loss function")
abline(v=mean(x), col=2, lwd=3)

## plot the ssdq sum of squared differences loss function
plot(mu_hat, min_sum_dens_ssqd, main="squared differences loss function")
abline(v=mean(x), col=2, lwd=3)

which(sum_log_dens_dnorm==max(sum_log_dens_dnorm))
coord <- which(sum_log_dens_dnorm==max(sum_log_dens_dnorm))

mu_hat[coord]

which(sum_dens_ssqd==min(sum_dens_ssqd))
which(min_sum_dens_ssqd==max(min_sum_dens_ssqd))

