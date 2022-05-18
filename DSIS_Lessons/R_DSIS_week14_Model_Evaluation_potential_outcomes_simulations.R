## R_DSIS_week14_Model_Evaluation_potential_outcomes_simulations.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2022, Winter 2021, Winter 2020
##
## Week 14 (optional)
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## For this R tutorial, we will learn how:
##
## (1) Learn how to generate fake data and analyize it using the potential outcomes framework from Rubin.
##
## Note that we will know with certainty two distinct values of the dependent variable for each individual subject i.
##
## Because we are simulating the data, we will know what the i_th subject's outcome is when given the treatment variable
## and not given the treatment variable (and a continuous range of treatment values).
##
## The simulated experiments in part 1, part 2, and part 4 are equivalent to a two-group,
## Post-test only design using the Trochim and Donnely notation (see also the discussion in Shadish).
##
##########################################################################

##########################################################################
### Generate outcome variable and treatment variable for causal inference
##########################################################################

## set the seed to reproduce random number generation
set.seed(1234567)

## create scalar value for the number of units
n <- 300

## create subject level error (this information might be important for understanding the outcome variable
## but it is orthogonol/indpendent of treatment assignement)
e_i <- rnorm(n)

## create summary of subject level error
summary(e_i)

## potential outcome without treatment
Y_i0 <- -.10 + e_i

## potential outcome with treatment
Y_i1 <- .20 + e_i

## calculate mean for subject without treatment effect
mean(Y_i0)

## calculate mean for subject with treatment effect
mean(Y_i1)

## calculate true difference in means for the potential outcome of subjects with treatment and without treatment effect
mean(Y_i1) - mean(Y_i0)

## create vector of treatment assignments for the units (W_i==1 if treated, W_i==0 if control)
W_i <- c(rep(0,n/2), rep(1, n/2))

table(W_i)

## create vector of observed Y values
Y_obs_i <- W_i * Y_i1 + (1 - W_i) * Y_i0

## summarize observed Y variable
summary(Y_obs_i)


##########################################################################
### potential outcome analysis part 1
##########################################################################

mean(Y_obs_i)

## calculate means for observed Y variable for treated and control units
mean(Y_obs_i[W_i==1])
mean(Y_obs_i[W_i==0])

## calculate difference in means using the mean() function
mean(Y_obs_i[W_i==1]) - mean(Y_obs_i[W_i==0])

## calculate difference in means using the t.test() function
t.test(Y_obs_i ~ W_i)

## calculate difference in means using the lm() function
fit <- lm(Y_obs_i ~ W_i)
summary(fit)

## mean in group 1
summary(fit)$coefficient[2,1] + summary(fit)$coefficient[1,1]

## Graph observed subject values by treatment indicator
plot(c(Y_obs_i[W_i==0], Y_obs_i[W_i==1]), col=c(W_i[W_i==0], W_i[W_i==1])+1)
abline(h=mean(Y_obs_i[W_i==1]), col=grey(.9), lwd=2)
abline(h=mean(Y_obs_i[W_i==0]), col=grey(.9), lwd=2)



##########################################################################
### potential outcome analysis part 2
##########################################################################

## generate propensity score based on true probability of assignment
X_i <- rnorm(n)
Prob_i <- pnorm(X_i, mean = 0, sd = 1)
W_i <- rbinom(n, size=1, prob=Prob_i)

## create vector of observed Y values
Y_obs_i <- W_i * Y_i1 + (1 - W_i) * Y_i0

## calculate means for observed Y variable for treated and control units
mean(Y_obs_i[W_i==1])
mean(Y_obs_i[W_i==0])

## calculate difference in means
t.test(Y_obs_i ~ W_i)

## calculate difference in means using the lm() function
fit <- lm(Y_obs_i ~ W_i)
summary(fit)

## mean in group 1
summary(fit)$coefficient[2,1] + summary(fit)$coefficient[1,1]

## Graph observed subject values by treatment indicator
plot(c(Y_obs_i[W_i==0], Y_obs_i[W_i==1]), col=c(W_i[W_i==0], W_i[W_i==1])+1)
abline(h=mean(Y_obs_i[W_i==1]), col=grey(.9), lwd=2)
abline(h=mean(Y_obs_i[W_i==0]), col=grey(.9), lwd=2)



##########################################################################
### potential outcome analysis part 3
##########################################################################

## use the propensity score generated above to estimate treatment effect
fit <- lm(Y_obs_i ~ Prob_i)

## summarize model fit
summary(fit)

## mean in group 1
summary(fit)$coefficient[2,1] + summary(fit)$coefficient[1,1]

## Graph observed subject values by propensity score
colfunc <- colorRampPalette(c("black", "red"))

index <- order(Prob_i)

plot(Y_obs_i[index] ~ Prob_i[index], col=colfunc(length(seq(0,1, length.out=n))))
abline(reg=fit, col=grey(.9), lwd=2)



##########################################################################
### potential outcome analysis part 4
##########################################################################

## set total number of simulations
sims <- 2000

## vector for storing simulated coefficients
sim.coef <- sim.t <- NA

## loop over simulation resampling the index each time
for(j in 1:sims){
    
    index <- sample(1:n, size=n, replace=FALSE)
    W_i_permutation <- W_i[index]
    fit <- lm(Y_obs_i ~ W_i_permutation)
    sim.coef[j] <- fit$coef[2]
    sim.t[j] <- summary(fit)$coefficient[2,3]
}


## re-calculate difference in means using the lm() function
fit <- lm(Y_obs_i ~ W_i)
summary(fit)
observed.t <- summary(fit)$coefficient[2,3]
observed.t

## Graph the simulated coefficients and add a line showing the observed relationship from the data
hist(sim.coef, col=grey(.9), xlim=c(-.35,.35))
abline(v=fit$coef[2], lwd=2, col=2)


## Calculate permutation p-values
## "In general, if you want a two-sided P-value, compute both one-sided P-values,
## double the smaller one, and take the minimum of this value and 1."
## Rosenbaum (2010), Design of Observational Studies, p. 33, note 2
## The above text was taken from Lin, Green, and Coppock (2016) Version 1.05

p.left <- mean(sim.t <= observed.t)
p.right <- mean(sim.t >= observed.t)
p.value <- min(2 * min(p.left, p.right), 1)
p.value





## loop over simulation resampling the index each time
test <- lapply(1:sims, function(j){
    
    index <- sample(1:n, size=n, replace=FALSE)
    W_i_permutation <- W_i[index]
    fit <- lm(Y_obs_i ~ W_i_permutation)
    sim.coef <- fit$coef[2]
    sim.t <- summary(fit)$coefficient[2,3]
    return(list("index"=index, "W_i_permutation"=W_i_permutation, "fit"=fit, "sim.coef"=sim.coef, "sim.t"=sim.t))
})








