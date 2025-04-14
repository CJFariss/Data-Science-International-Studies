## R_DSIS_week14_Model_Evaluation_standard_errors_tstats_pvalues_CIs.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2024, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
##
## Week 14 (optional)
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
##
## See Davies chapter on Null Hypothesis testing  
##
## Note: there are a lot of issues with this framework that we don't consider. But these issues are important for interpretation and use when using statistical tools today. And for remembering the context in which these tools were developed, which we link to themes in my Human Rights course.
## 
## Check out this additional resources:
## https://tinystats.github.io/teacups-giraffes-and-statistics/06_standardError.html
##
## And some additional references in case you are really curious:
## 
## Neyman, J. (1937). Outline of a theory of statistical estimation based on the classical theory of probability. Philosophical Transactions of the Royal Society of London Series A, Mathematical and Physical Sciences, 236, 333–380.
##
## Morey, R.D., Hoekstra, R., Rouder, J.N. et al. Continued misinterpretation of confidence intervals: response to Miller and Ulrich. Psychon Bull Rev 23, 131–140 (2016). https://doi.org/10.3758/s13423-015-0955-8
##
##########################################################################
## Introduction to tutorial:
## For this R tutorial, we will learn:
##
## (1) First we will estimate the mean of the estimand (MU)
## (2) How to calculate and interpret standard errors
## (3) How to calculate and interpret t-statistics (or Z-scores)
## (4) How to calculate and interpret p-values
## (5) How to calculate and interpret a 95% Confidence Interval (CI)
##
## Warning!: p-values are weird and confusing. Put another way: WTF is a p-value?
##
## The p-value is a probability but it is not intuitive to think about. Even though p-values are confusing, they are used everywhere so we should try to understand what a p-value means and what it does not mean.
##
## First, to calculate a p-value, we need to first calculate the estimate of interest (e.g., mean, correlation coefficient, regression coefficient). Remember the mean or any other estimate is our representation or summary of our data. Conceptually, we think of the true value of the parameter we are interested in as unobservable so it's theoretical/conceptual in nature. We call this the estimand or sometimes the population parameter (there are lots of ways to denote this idea). We cannot observe this etity but we can estiamte it.
##
## Second, once we have our estimate, we calculate the interval around the estimate, which is the standard error of the estimate (the standard error is technically the standard deviation of the estimate but since we only have one estimate and not a distribution of estimates we cannot simply calculate the standard deviation so we estimate it and call it the standard error). We use an estimator, which is just an algorithm or procedure to calculate this estimate of the standard error.
##
## Third, we calculate the position of the estimate relative to 0 using a density function dt() or dnorm(). Usually, we use the Student's t distribution dt() but sometimes we use the normal density function dnorm(). Note that we are assuming that the distribution is centered at 0 (more on this assumption below).
##
## Fourth, we calculate the p-value. The p-value is the probability that the estimate is contained in the interval around 0, given that we assumed the estimate was 0 in the first place. But there are many other related but not quite correct interpretations of the p-value that exist so be wary!
##
## Put another way, the p-value is the probability that an estimate (e.g., mean, regression coefficient) is not far away from 0, assuming that 0 is the "truth". Rember we cannot observe the theoretical estimand, we can only estimate it.
##
## The assumption that the estimate is 0 is the "truth" is called the null hypothesis (H_{0}). We assume that the estimate is 0 and then see how far away (distance using a density function) it is from the value we actually calculate from the data. So we can define the p-value as the probability of the data given the null hypothesis: p(data | H0).
##
## p-values that are small, usually less than 0.1, 0.05, or 0.01, are used to make the statement that we "reject the null hypothesis" or we "reject the null hypothesis that the true estimate is 0."
##
## If the p-value is relatively large (usually larger than 0.1 or 0.05) then we make the statement that we "fail to reject the null hypothesis" or we "fail to reject the null hypothesis that the true estimate is 0." Note that we do not say (and don't have evidence of) that the estimate is 0.
##
## To review: The p-value is the probability that the estimate is contained in the interval around 0. If the p-value is small, then we reject the null hypothesis and can then say we have evidence that the estimate is different than 0, given that we assumed the estimate was 0 in the first place.
##
## There are more intuitive and easy to understand probability statements that we can use to provide evidence that effects are different than 0 but null-hypothesis testing and its terminology is dominant in many different fields (even if not explicitly so) and are produced by many of the functions we use in R like lm(), t.test(), etc.
##
## We will consider the Bayesian version of the probability of an estimate in another lesson. Note here that formally it flips the conditional probability we defined above from p(data | H0) to p(H | data), where H is the research hypothesis we are testing and not the null hypothesis (H0). Note: see the lego probability lesson or weather probability challange for reminders about what conditional probability is and how to think about it.
##
## Fifth, we can use the standard error to construct a confidence interval (CI) around the estimate calculated in step (1). CIs are useful descriptions of the range of possible estimates and the uncertainty we have about the estimate we have produced.
##
## However, CIs are even stranger to think about than p-values given the above discussion. For the p-value, we assume the truth is 0 and estimate the distance from that point using a density function. For the CIs, we estimate an interval around the value of the estimate (e.g., the mean, regression coefficient, etc). Both the distance and the CI interval are constructed using the standard error of the estimate. For the p-value, we assume the ratio: estimate/se_estimate is a point contained within a density function, usually distributed according to either the Student's t distribution or the standard normal distribution (or the appropriate discrete density function for binary or count data such as the Bernoulli or Poisson). The CI is the estimate +/- the standard error * some value (usually 1.96 standard deviations for large samples of data, which corresponds with 95% Confidence).
##
## So we can say that we have 95% confidence that the interval generated from our data will contain the "true" parameter value or the estimand. But this is not a probability statement. Rather it is a statement about the proportion of times the interval we generate and call a confidence interval will contain 0.
##
## Overall, what does a CI tell us? Essentially, if the CI contains 0, then the "true" estimate could also be 0 which is why choose to not claim a relationship is different from 0 (i.e., we fail to reject the null hypothesis).
##
## A confidence procedure (CP) is a procedure that generates confidence intervals, and is said to have a confidence coefficient of X% if, in repeated sampling, X% of intervals would contain the true parameter value for all values of the true value (Neyman 1937).
##
## p-values and CIs are strange statistical ideas to think about. With some tinkering though, we can alter these values and interpret them in more intuitive ways that are based on simple probabilities. We need to use Bayes rule and flip the conditional probability we defined above from p(data | H0) to p(H | data).

##
##########################################################################

library(MASS)

## function to calculate the standard error of the mean
mean_se <- function(x){
  sd(x)/sqrt(length(x))
}

## function to calculate the p-value of the mean
mean_pvalue <- function(x, test.alternative="two.sided"){
  if(test.alternative=="one.sided"){
    ## pt() gives the sum of density (cumulative density) for the student's t distribution for a range from -infinity to the value supplied to the function (this is a one-sided test)
    pt(mean(x)/mean_se(x), df=length(x)-1) 
  } else if(test.alternative=="two.sided"){
    ## the value from the min() function is always less than or equal to 0.5 because values from 0 - .5 are less than values from 1 - (0 to .5) and values from .5 to 1 are greater than values from 1 - (.5 to 1)
    ## which is why we have to multiply the value returned by the min() function by 2 (we are adding up two equal size ends of the probability distribution)
    ## this gives us density from both sides of the Student's t distribution
    2 * min(pt(mean(x)/mean_se(x), df=length(x)-1), 1 - pt(mean(x)/mean_se(x), df=length(x)-1))
  } else{
    print("something is wrong!")
  }
}

## generate a simple variable (try different x's to see how the spread of the data influences the standard error, t-stat, p-value, and 95% CI)
x <- 1:5
#x <- c(1,1,3,5,5)
#x <- c(0,0,3,6,6)
#x <- c(-1,-1,3,7,7)
#x <- c(-2,-2,3,8,8)
#x <- c(-3,-3,3,9,9)
#x <- c(-10,-10,3,16,16)
#x <- c(-20,-20,3,26,26)
#x <- c(-100,-100,3,106,106)
#x <- -10:10
#x <- -9:11

x <- rep(1:5,20)
length(x)


x <- 1:5

## calculate an estimate and measures of the uncertainty of the estimate 
mean(x) ## mean (estimate)
mean_se(x) ## standard error (standard deviation of the estimate)
mean(x)/mean_se(x) ## t-statistic (ratio of the estimate and the standard deviation of the estimate, which is interpreted as the position on a density function for the Student's t distribution or normal distribution if it's called the z-score)
mean_pvalue(x) ## p-value (probability of an estimated value far away from 0; assuming that 0 is the "Truth")

x <- 1:5
t.test(x)

t.test(x)$estimate ## mean (estimate)
t.test(x)$stderr ## standard error (standard deviation of the estimate)
t.test(x)$statistic ## t-statistic (ratio of the estimate and the standard deviation of the estimate, which is interpreted as the position on a density function for the Student's t distribution or the normal distribution if it's called the z-score)
t.test(x)$p.value ## p-value (probability of an estimated value far away from 0; assuming that 0 is the "Truth")


## let's look at the complete output from the t.test() function
t.test(x)

## two functions to inspect the output from t.test() function
names(t.test(x))
attributes(t.test(x))

## proofs of equality between algorithms 
mean(x) == t.test(x)$estimate
mean_se(x) == t.test(x)$stderr
mean(x)/mean_se(x) == t.test(x)$statistic
mean_pvalue(x) == t.test(x)$p.value

mean_pvalue(x)
t.test(x)$p.value

## Note that the last test above is FALSE because of a rounding error
## Below, we will use the round function to determine how many digits the test above is TRUE before becoming FALSE

## plot the Student's t distribution
x<-1:5
par(mfrow=c(1,1))
curve(expr=dt(x,df=length(x)), from=-6,to=6, n=101, xlab="t-statistic")
abline(v=mean(x)/mean_se(x), col=2)

## 95% CI
t.test(x)$estimate + 1.96*t.test(x)$stderr
t.test(x)$estimate - 1.96*t.test(x)$stderr

## why not 1.96? note:
pt(q=1.96, df=5) - pt(q=-1.96, df=5)

## the above answer does not give us 95% CI
## we can use the q-type function to determine the t-statistic we need to compute the 95% CI
qt(p=.975, df=5)
qt(p=.025, df=5)

pt(q=2.570582, df=5) - pt(q=-2.570582, df=5)

## let's recompute the 95% CI
t.test(x)$estimate + 2.57*t.test(x)$stderr
t.test(x)$estimate - 2.57*t.test(x)$stderr

## note this works thought with large df argument (degrees of freedom)
pt(q=1.96, df=1000) - pt(q=-1.96, df=1000)

curve(expr=dt(x,df=5), from=-6,to=6, n=101, xlab="t-statistic")
curve(expr=dt(x,df=25), from=-6,to=6, n=101, add=TRUE, col=4)
curve(expr=dt(x,df=1000), from=-6,to=6, n=101, add=TRUE, col="orange")

## compare the density of the Student's t to normal 
curve(expr=dt(x,df=1000), from=-6,to=6, n=101, xlab="t-statistic")
curve(expr=dnorm(x), from=-6,to=6, n=101, add=TRUE, lty=2, col=2)

## Z-score 
pnorm(q=1.96)
pnorm(q=-1.96)

pnorm(q=1.96) - pnorm(q=-1.96)

qnorm(p=.975)
qnorm(p=.025)

pnorm(q=qnorm(p=.975)) - pnorm(q=qnorm(p=.025))


## instead of using 1.96, if we use the t-statistic, notice that the interval now includes 0 (this will always happen)
## this is the range of values that always includes 0 
## note this is not a range that is generally reported in applied data science research
t.test(x)$estimate + t.test(x)$statistic*t.test(x)$stderr
t.test(x)$estimate - t.test(x)$statistic*t.test(x)$stderr


## set the parameters for a small simulation: sample size, mean, standard deviation
sim_n <- 10
MU <- .75
SD <- 1

## define objects
test_mean <- test_se <- test_t <- test_p <- test_p.value <- c()
test_CI <- list()

## run the simulation 
for(i in 1:1000){
  x1 <- rnorm(sim_n, mean=MU, sd=SD)
  test_mean[i] <- mean(x1)
  test_se[i] <- mean_se(x1)
  test_t[i] <- test_mean[i]/test_se[i]
  test_p[i] <- mean_pvalue(x1)
  test_p.value[i] <- t.test(x1)$p.value
  test_CI[[i]] <-  c(test_mean[i] + qt(.025,sim_n)*test_se[i], test_mean[i] + qt(.975,sim_n)*test_se[i])
}

library(MASS)

## plot the results
par(mfrow=c(1,2))
truehist(test_mean)
truehist(test_p)

##
mean(test_mean)
sd(test_mean)

##
mean(test_mean>0)
mean(test_mean<=0)

##
par(mfrow=c(1,1))
plot(test_mean, test_p)

## we will test this more thoroughly with a simulation below
table(test_p.value == test_p)
summary(test_p.value - test_p)


## loop through the list object and calculate
test_CI_0 <- test_CI_diff <- test_CI_MU <- c()
for(i in 1:length(test_CI)){
  test_CI_0[i] <- xor(all(test_CI[[i]]>0), all(test_CI[[i]]<0))
  test_CI_diff[i] <- test_CI[[i]][2] - test_CI[[i]][1] 
  test_CI_MU[i] <- MU <= test_CI[[i]][2] & MU >= test_CI[[i]][1] 
}

summary(test_CI_diff)

table(test_CI_MU)
table(test_CI_0)

##
par(mfrow=c(2,2), mar=c(4,4,1,1))
plot(test_CI_diff, test_mean)
plot(test_CI_diff, test_se)
plot(test_CI_diff, test_t)
plot(test_CI_diff, test_p)

## plot all the CIs from the simulation
par(mfrow=c(1,1), mar=c(4,4,1,1))
plot(test_CI[[1]], c(1,1), xlim=c(-2,2), ylim=c(0,length(test_CI)), type="n")
for(i in 1:length(test_CI)){
  lines(test_CI[[i]], c(i,i), col=ifelse(test_CI_MU[i], grey(.8),1), lwd=0.5)
}
abline(v=MU, col=2)

## the CI generating procedure always produces intervals that contain the "true" estimate 95% or X%of the time.
table(test_CI_MU)

## So what does this all tell us? Essentially, if the CI contains 0, then the "true" estimate could also be 0 which is why choose to not claim a relationship is different from 0 (i.e., we fail to reject the null hypothesis).


## Here, we will use the round function to determine how many digits the test above is TRUE before becoming FALSE
## THIS IS JUST FOR FUN!
significant_digit <- 0
test <- TRUE
repeat{
  test <- round(t.test(x)$p.value, significant_digit) == round(mean_pvalue(x), significant_digit)
  if(test==FALSE) break
  significant_digit <- significant_digit + 1
}
significant_digit

## double check
round(t.test(x)$p.value, significant_digit-1) == round(mean_pvalue(x), significant_digit-1)
round(t.test(x)$p.value, significant_digit) == round(mean_pvalue(x), significant_digit)

## print out the rounded digits
print(t.test(x)$p.value, significant_digit-1)
print(mean_pvalue(x), significant_digit-1)

## the difference between the two values is 0.0000000000000003
print(t.test(x)$p.value, significant_digit)
print(mean_pvalue(x), significant_digit)

## we can print out to 22 significant digits in R (note: that this number may be different depending on your computer)
significant_digit+6

## print out the entire digit to the 22nd place
print(t.test(x)$p.value, significant_digit+6)
print(mean_pvalue(x), significant_digit+6)


