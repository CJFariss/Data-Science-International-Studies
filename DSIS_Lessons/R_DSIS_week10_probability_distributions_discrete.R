## R_DSIS_week10_probability_distributions_discrete.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2024, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
##
## Week 10
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## For this R tutorial, we will learn about:
##
## (1) Discrete probability distributions for discrete events (e.g., a coin flip; rolling a 6-sided dice).
## (2) Continuous probability distributions (e.g., SAT, GRE or LSAT scores; human weight at birth; distance from the center of the board for the beanbag toss or cornhole game)
##
## Note: This lesson contains information you will use in a program challenge this week: select one continuous and/or one discrete probability distribution from below (not including Uniform, Normal, Bernoulli, or Binomial) and describe it in detail with ## comments and R code. See the examples for Uniform, Normal, Bernoulli, or Binomial distributions below. If you select 2 distributions, make sure one is continuous and the other is discrete.
##
##########################################################################

## first we will construct a density function using the now familiar sample() function

## probability mass or probability density: this is just how much probability does each event/outcome have and it all needs to sum to 1 to be a probability measure (see the less from last week)

## What is density? Density is the relative probability of sampling an event at a specific point along the range of possible values defined by the function.

## let's see density in action by simulating the roll of a D6 in R using the sample() function
library(MASS)

## total number of rolls 
## try changing this value from 100 to 1000 to 10000 to 100000
sim_n <- 100000
sim_n

values <- sample(c(1,2,3,4,5,6), size=sim_n, replace=T)
table(values)
table(values)/sim_n

par(mfrow=c(1,2), mar=c(4,4,2,.5)) ## as always we can check the help file for the par() function ?par
barplot(table(values), names.arg=c(1,2,3,4,5,6), space=0, main="Frequency of D6 Rolls")
abline(h=sim_n/6, col=2, lwd=2)
barplot(table(values)/sim_n, names.arg=c(1,2,3,4,5,6), space=0, main="Proportion of D6 Rolls")
abline(h=1/6, col=2, lwd=2)

## what is the probability of getting 1 of the numbers on our fair D6? 
## this is a probability density function for our D6 roll.
par(mfrow=c(1,1), mar=c(4,4,2,.5))
#par(mfrow=c(1,1), mar=c(6,6,4,4))
barplot(rep(1/6, 6), names.arg=c(1,2,3,4,5,6), space=0, main="Proportion of D6 Rolls", ylim=c(0,1/6))
abline(h=1/6, col=2, lwd=2)

mean(values)
var(values)

##########################################################################
##
## Bernoulli distribution
##
## The Bernoulli distribution is a special case of the Binomial distribution
##
## The sample space S for the Bernoulli distribution, is defined to take one element. 
## There are two probabilities estimated by the distribution p and 1-p. 
## The probability distribution for p is in reference to when the variable y=1 and 1-p is in reference to when y=0.
##
## discrete range of the observed binary variable: [0,1]
## distribution function: p^y * (1-p)^(1-y)
## parameters: p is a continuous, real value parameter that ranges from 0 to 1, 
## it is interpreted as the probability of success of a single trial (success is when y=1)
## 
## R function names (all with size argument set to 1):
## dbinom
## pbinom
## qbinom
## rbinom
##
## parameters:
## formula for the mean: p
## formula for the variance: p*(1-p)
##
## let's define our own Bernoulli function
## the argument p can take real (continuous) values between 0 and 1
## the argument y can take discrete values of 0 or 1
Bernoulli_function <- function(p,y){
    return(p^y * (1-p)^(1-y))
}

## call our user defined function
Bernoulli_function(p=.5, y=1)
Bernoulli_function(p=.5, y=0)
Bernoulli_function(p=.25, y=1)
Bernoulli_function(p=.25, y=0)

Bernoulli_function(p=.1, y=1)
Bernoulli_function(p=.1, y=0)

## use R's base function for a Bernoulli distribution
dbinom(x=1, size=1, prob=0.5)
dbinom(x=0, size=1, prob=0.5)
dbinom(x=1, size=1, prob=0.25)
dbinom(x=0, size=1, prob=0.25)
dbinom(x=1, size=1, prob=0.1)
dbinom(x=0, size=1, prob=0.1)

dbinom(x=2, size=1, prob=0.25)

## graph the probability distribution 
barplot(dbinom(x=1, size=1, prob=0.5), names.arg=c(1), ylim=c(0,1), ylab="Pr(X=1)", xlab="x")

## generate a vector with a 0 and 1
values <- dbinom(x=c(0,1), size=1, prob=0.25)
values

barplot(values, names.arg=c(0,1), ylim=c(0,1), ylab="Pr(X=x)", xlab="x")

values <- dbinom(x=c(0,1), size=1, prob=0.95)
barplot(values, names.arg=c(0,1), ylim=c(0,1), ylab="Pr(X=x)", xlab="x")

values <- dbinom(x=c(0,1), size=1, prob=0.05)
barplot(values, names.arg=c(0,1), ylim=c(0,1), ylab="Pr(X=x)", xlab="x")


## we can simulate the Bernoulli process with the sample() function or the rbinom() function

## simulate a Bernoulli trial with two coin flips using the sample() function
sim_n <- 10000
coin_flip_trial <- sample(c(0,1), size=sim_n, replace=TRUE, prob=c(.5,.5))
table(coin_flip_trial)/sim_n

## graph the simulation from above
barplot(table(coin_flip_trial)/sim_n, names.arg=c(0,1), ylim=c(0,1), ylab="Pr(X=x)", main="Bernoulli coin flips using sample()")

## simulate a Bernoulli trial with two coin flips using the rbinom() function
sim_n <- 10000
coin_flip_trial <- rbinom(sim_n, size=1, prob=.5)
table(coin_flip_trial)/sim_n

## graph the simulation from above
barplot(table(coin_flip_trial)/sim_n, names.arg=c(0,1), ylim=c(0,1), ylab="Pr(X=x)", main="Bernoulli coin flips using rbinom()")


##########################################################################
##
## Binomial distribution
##
## The sample space S for the Binomial distribution, is defined to take one element. There are two probabilities estimated by the distribution p and 1-p. The probability distribution for p is in reference to when the variable y=1 and 1-p is in reference to when y=0.
##
## discrete range of the observed binary variable: [0,N]
## distribution function: choose(N, y) * p^y * (1-p)^(N-y)
## parameters: p is a continuous, real value parameter that ranges from 0 to 1, it is interpreted as the probability of success of a single trial (success is when y=1). when N > 1, it is interpreted as the probability of success for each individual N trial
##
## choose(N, y) is the binomial coefficient and is defined as N!/(y!(N − y)!). 
## This turns into a very large number as N increases. 
## It is used to normalize (bound the probability for a binomial outcome) to range from 0 to 1. 
## It is also called the normalization coefficient.
##
## R function names (all with size argument set to N):
## dbinom
## pbinom
## qbinom
## rbinom
##
## parameters:
## formula for the mean: N*p
## formula for the variance: N*p*(1-p)
##
## let's define our own binomial function
## the argument p can take values between 0 and 1
## the argument y can take discrete values of 0 or 1
Binomial_function <- function(p,y,N){
    (factorial(N)/(factorial(y) * factorial(N-y) )) * p^y * (1-p)^(N-y)
}

## quick reminder on factorials
## factorials are just the product of all the integer values in a sequence starting from the largest number in the sequence down to 1
factorial(3) # 3! written out in math but this won't work in R 
prod(3:1)
prod(seq(from=3,to=1,by=-1))
3*2*1

factorial(4)
prod(4:1)
prod(seq(4,1))
4*3*2*1

## careful with this rule though
factorial(0)
prod(0)

## call our user defined function
Binomial_function(p=.5, y=2, N=2)
Binomial_function(p=.5, y=1, N=2)
Binomial_function(p=.5, y=0, N=2)
Binomial_function(p=.25, y=2, N=2)
Binomial_function(p=.25, y=1, N=2)
Binomial_function(p=.25, y=0, N=2)

Binomial_function(p=.25, y=2, N=2) + Binomial_function(p=.25, y=1, N=2) + Binomial_function(p=.25, y=0, N=2)

## probability of rolling D6 1s twice
Binomial_function(p=1/6, y=2, N=2)
1/36

## use R's base function for a Binomial distribution
dbinom(x=2, size=2, prob=0.5)
dbinom(x=1, size=2, prob=0.5)
dbinom(x=0, size=2, prob=0.5)
dbinom(x=2, size=2, prob=0.25)
dbinom(x=1, size=2, prob=0.25)
dbinom(x=0, size=2, prob=0.25)

## write out binomial function using the choose() function instead of factorial
Binomial_function_2 <- function(p,y,N){
    choose(N,y) * p^y * (1-p)^(N-y)
}
Binomial_function_2(p=.5, y=2, N=2)
Binomial_function(p=.5, y=2, N=2)
dbinom(x=2, size=2, prob=0.5)


## simulate a binomial trial with two coin flips
sim_n <- 10000
coin_flip_trial1 <- sample(c(0,1),size=sim_n, replace=TRUE)
coin_flip_trial2 <- sample(c(0,1),size=sim_n, replace=TRUE)
table(coin_flip_trial1)/sim_n
table(coin_flip_trial2)/sim_n

table(coin_flip_trial1 + coin_flip_trial2)/sim_n

## graph the simulation from above
barplot(table(coin_flip_trial1 + coin_flip_trial2)/sim_n, names.arg=c(0,1,2), ylim=c(0,1), ylab="Pr(X=x)", main="Binomial trial (2 coin flips) using sample()")

## simulate a Bernoulli trial with two coin flips using the rbinom() function
sim_n <- 10000
coin_flip_trial <- rbinom(sim_n, size=2, prob=.5)
table(coin_flip_trial)/sim_n

## graph the simulation from above
barplot(table(coin_flip_trial)/sim_n, names.arg=c(0,1,2), ylim=c(0,1), ylab="Pr(X=x)", main="Binomial trial (2 coin flips) using rbinom()")


## graph the density or mass of the binomial trial with two coin flips
values <- dbinom(x=c(0,1,2), size=2, prob=0.5)
values
par(mfrow=c(1,1))
barplot(values, names.arg=c(0,1,2), ylim=c(0,1), ylab="Pr(X=x)")

## graph the density or mass of the binomial trial with two coin flips but with a different probability
values <- dbinom(x=c(0,1,2), size=2, prob=1/3)
values
barplot(values, names.arg=c(0,1,2), ylim=c(0,1), ylab="Pr(X=x)")

## graph the density or mass of the binomial trial with six coin flips
values <- dbinom(x=c(0,1,2,3,4,5,6), size=6, prob=1/2)
values
sum(values)
barplot(values, names.arg=c(0:6), ylim=c(0,1), ylab="Pr(X=x)")

## graph the density or mass of the binomial trial with five coin flips
values <- dbinom(x=c(0,1,2,3,4,5), size=5, prob=1/2)
values
barplot(values, names.arg=c(0:5), ylim=c(0,1), ylab="Pr(X=x)")


## graph the density or mass of the binomial trial with ten coin flips
values <- dbinom(x=0:10, size=10, prob=.5)
values
barplot(values, names.arg=c(0:10), ylim=c(0,1), ylab="Pr(X=x)")


## graph the density or mass of the binomial trial with ten coin flips but with a higher probability of getting "heads"
values <- dbinom(x=0:10, size=10, prob=.9)
values
barplot(values, names.arg=c(0:10), ylim=c(0,1), ylab="Pr(X=x)")


## here is where the program challenge questions start

##########################################################################
## Additional probability distributions for discrete variables (integers that are usually strictly positive)
##########################################################################
##
##########################################################################
## Poisson distribution
##
## R function names:
## dpois
## ppois
## qpois
## rpois
##
##########################################################################
## geometric distribution
##
## R function names:
## dgeom
## pgeom
## qgeom
## rgeom
##
##########################################################################
## negative binomial distribution
##
## R function names:
## dnbinom
## pnbinom
## qnbinom
## rnbinom
##
##########################################################################
## hypergeometric distribution
##
## R function names:
## dhyper
## phyper
## qhyper
## rhyper
##
##########################################################################
## multinomial distribution
##
## R function names:
## rmultinom
## dmultinom
##
##########################################################################
## Wilcoxon distributions
##
## R function names:
## dwilcox
## pwilcox
## qwilcox
## rwilcox
##
##########################################################################
