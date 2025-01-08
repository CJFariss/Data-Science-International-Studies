## R_DSIS_week14_Model_Evaluation_false_discovery_rate.R
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
## Introduction to tutorial:
##
## False Discovery Rate:
## the expected proportion of false discoveries among the rejected hypotheses
##
## Use this tool when you have many more columns of data than rows of data
##
## Penalize the calculated p_values.
## There are many possible corrections, many of which are available in R.
## The simplest criterion is to simply increase the threshold (decrease the p-value size) at which the researcher reports evidence of non-zero relationship.
##
## In general, these tools are designed to reduce the rate of false positives with respect to the hypothesis test under consideration.
## In other words, the methods penalize the standard p-value to reduce false discovery rate which is when we incorrectly reject the null hypothesis that there is no real effect.
## This means we pay a cost of more type II errors (false negatives) in an effort to reduce the rate of type I error (false positives).
##
## When the number of observations we have is limited, these corrections are useful to consider.
## In cases of large-scale datasets, consider using an out of sample testing procedure to reduce the false discovery rate.
##
## See for many other options see the R documentation here http://www.strimmerlab.org/notes/fdr.html
##
## As we discussed with the definitions of precision, recall, and accuracy, there is no strict advice on which p-value adjustment to use.
##
## Depending on the substantive goal of the modeling effort, the researcher may wish to minimize false positives or false negatives (identify all potential units that are of some class for further analysis).
##
## In an exploratory study, the researcher may wish to describe all potentially significant relationships as a starting point for additional research.
##
## If there are potential costs associated with the study, in particular for vulnerable populations, then considering a stricter criterion for reporting a statistically significant finding may be advisable.
##
## Keep in mind though, that not passing a threshold for statistically significant and thus rejecting a null hypothesis is distinct from estimating the precision of a null effect.
##
## Usually, these corrections are for large-scale hypothesis testing: i.e., 100s or 1000s of tests. If you had 100s of tests and only a handful produced a significant result, we would want to use a correction to rule out false positives.
##
## On the other hand, 100s of tests in which nearly all produce a significant test statistic probably may provide the researcher with a lot of confidence that the modelled relationships are capturing a true substantive relationship.
##
## There are several methods of correction available in R. Bonferroni is the most conservative but not too bad in scenarios with a small number of tests. The penalty to the p-value increases as the number of tests increases.
##
##########################################################################

library(MASS)

## generate random variable to use as Z-score
n <- 1000
z_score <- rnorm(n, mean = c(rep(0, n/2), rep(3, n/2)))
truehist(z_score)

## transform Z-score into p-value
pvalue <- 2*pnorm(-abs(z_score))
truehist(pvalue)
plot(z_score, pvalue)
abline(v=1.96, col=2)
abline(v=-1.96, col=2)


## adjust for potential false discoveries using the BH (Benjamini & Hochberg) adjustment
pvalue_fdr_BH <- p.adjust(pvalue, method="BH")

## adjust for potential false discoveries using the BY (Benjamini-Yekutieli) adjustment
pvalue_fdr_BY <- p.adjust(pvalue, method="BY")

## plot adjusted p_value by original p_value
plot(z_score, pvalue)
points(z_score, pvalue_fdr_BH, col=3)
points(z_score, pvalue_fdr_BY, col=4)
abline(v=1.96, col=2)
abline(v=-1.96, col=2)
abline(h=.05, col=2)

## plot adjusted p_value by original p_value
plot(pvalue, pvalue_fdr_BH, col=3)
points(pvalue, pvalue_fdr_BY, col=4)


## if you are curious: calculate the BY adjustment in base R use the code below (this is modified from code out of the p.adjust function in R)
index <- length(pvalue):1
o <- order(pvalue, decreasing = TRUE)
ro <- order(o)
q <- sum(1/(1:n))
pvalue_adjusted <- pmin(1, cummin(q * length(pvalue)/index * pvalue[o]))[ro]


## Evaluate the p-value corrections given a vecor of p-values
temp_list <- list()
for(i in 1:7){
  pvalues <- c(.01,.025, .05)
  pvalue_method <- c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr")
  adj_pvalue <- p.adjust(pvalues, method=pvalue_method[i])
  temp_list[[i]] <- data.frame(pvalue_method=pvalue_method[i], pvalues, adj_pvalue)
}
do.call("rbind", temp_list)
