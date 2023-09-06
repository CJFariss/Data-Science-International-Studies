## R_DSIS_week14_Model_Evaluation_precision_recall_accuracy.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
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
## Check out this additional resources:
## https://tinystats.github.io/teacups-giraffes-and-statistics/06_standardError.html
##
##########################################################################
## Introduction to tutorial:
##
## Define: Accuracy, Precision, Recall, AUC ROC, AUC PRC, F1-Score
##
## (1) Accuracy
## Accuracy is the proportion of predictions that are correct.
## That is, how many 1s and 0s did the algorithm correctly classify or predict?
##
## (2) Precision
## Precision is the proportion of the predictions which are "relevant".
## This is the true positive predictions divided by the sum of the true positive predictions and the false positive predictions.
## That is, what is the proportion of true positives predictions relative to the total number of positive predictions from the model?
##
## (3) Recall
## Recall is the proportion of predictions that are the "total relevant" ones.
## This is the true positive predictions divided by the sum of the true positive predictions and the false negative predictions.
## That is, what is the proportion of true positives predictions relative to the total number of true predictions and missed predictions from the model?
##
## Depending on the substantive goal of the modeling effort, the researcher may wish to minimize false positives (See the unit on false discovery) or false negatives (identify all potential units that are of some class for further analysis).
##
## (4) AUC ROC
## A receiver operating characteristic curve (ROC curve) and precision recall curve (PRC curve) are both the predictions of a binary classifier system as the discrimination threshold is varied.
## Area Under the Receiver Operating Characteristic (AUC ROC) is the average of the proportion of true positive predictions for all prediction thresholds from 0 to 1.
##
## (5) AUC PRC
## AUC PRC Area Under the Precision Recall Curve is the average recall proportion for all recall thresholds from 0 to 1.
##
## (6) F1-Score
## F1-score is another measure of the accuracy of a test.
## It is calculated using both the precision and recall scores.
##
## more R libraries
## https://rviews.rstudio.com/2019/03/01/some-r-packages-for-roc-curves/
##
##########################################################################


library(MASS)
library(boot)
library(gtools)
library(pROC)
library(PRROC)

## simulated data
n <- 1000
x <- rnorm(n)

## set parameters
beta <- 1

## multiply alpha by beta (if its 0 it doesn't matter and the proportion of 1s and 0s is always 50/50).
## This is useful for illustrative purposes (see R_Demo_Measurement_latent_variable.R file for more information about the logit transformation of a continuous predictor variable)
alpha <- -1.5*beta

## generate probabilities using the inverse logit function
prob_y_true <- inv.logit(alpha + beta*x + rnorm(n))

summary(prob_y_true)

## generate a binary dependent variable with error
y <- rbinom(1:n, size=1, prob=prob_y_true)

table(y)

## fit a logistic regression and estimate the probabity of y
fit <- glm(y ~ x, family=binomial("logit"))
prob_y <- predict(fit, type="response")

summary(prob_y)

cor(prob_y_true, prob_y)

## though we know the true probability, but we can only estimate the probability with observed data
## use the estimated probability to generate binary predictions at a discrimination threshold, often called pi or theta
threshold <- 0.5
y_hat <- ifelse(prob_y > threshold , 1, 0)

table(y)

table(y_hat)

table(y, y_hat)

sum(diag(table(y, y_hat)))/sum(table(y, y_hat))

## tabulate the prediction in the rows and the true value in the columns
## these values can go in either column or row.
## the code below requires them in prediction for rows and observed for columns
table(y_hat, y)

## this table is called a confusion matrix
confusion_matrix <- table(y_hat,y)
confusion_matrix

## set true positive and true negative (the diagonal)
TP <- confusion_matrix[2,2]
TN <- confusion_matrix[1,1]

TP
TN

## set false positive and false negatives (the off diagonal)
FP <- confusion_matrix[2,1] # w.r.t column value
FN <- confusion_matrix[1,2] # w.r.t column value

FP
FN

## accuracy
## how many 1s and 0s did the algorithm correctly classify or predict?
accuracy <- (TP + TN) / (TP + TN + FP + FN)
accuracy

## false negative rate
false_negative_rate <- FN / (TP + TN + FP + FN)
false_negative_rate

## false positive rate
false_positive_rate <- FP / (TP + TN + FP + FN)
false_positive_rate

## recall
## this is equivalent to the proportion of true positives by all positive observations
## if recall is high, there is a low false negative rate
## if recall is low, there is a high false negative rate
recall <- (TP) / (TP + FN)
recall

## precision
## this is equivalent to the proportion of true positives by all positive predicitions
## if precision is low, there is a high false positive rate
## if precision is high, there is a low false positive rate
precision <- (TP) / (TP + FP)
precision


## generalize the measurement of accuracy, precision, and recall across multiple threshold values between 0 and 1
TP <- TN <- FP <- FN <- c()
precision <- c()
recall <- c()
accuracy <- c()
threshold <- seq(0,1,.01)

for(i in 1:length(threshold)){
  
  ## vary the discrimination threshold over the full range of possible values
  y_hat <- ifelse(prob_y > threshold[i] , 1, 0)
  
  confusion_matrix <- table(y_hat,y)
  
  ## set true positive and true negative (the diagonal)
  TP[i] <- sum(y==1 & y_hat==1)
  TN[i] <- sum(y==0 & y_hat==0)
  ## set false positive and false negatives (the off diagonal)
  FP[i] <- sum(y==0 & y_hat==1)
  FN[i] <- sum(y==1 & y_hat==0)
  
  accuracy[i] <- (TP[i] + TN[i]) / (TP[i] + TN[i] + FP[i] + FN[i])
  recall[i] <- (TP[i]) / (TP[i] + FN[i])
  precision[i] <- (TP[i]) / (TP[i] + FP[i])
  
}

## AUC PRC Area Under the Precision Recall Curve is the average recall proportion for all recall thresholds from 0 to 1.
## AUC for the precision-recall curve
par(mfrow=c(1,1), mar=c(5,4,4,4))
plot(recall, precision, type="l", ylim=c(0,1), xlim=c(0,1), lwd=2, col=3, main="Precision Recall Curve")

## Area Under the Receiver Operating Characteristic (AUC ROC) is the average of the proportion of true positive predictions for all prediction thresholds from 0 to 1.
## AUC for the ROC curve
plot(FP/sum(y==0), TP/sum(y==1), type="l", ylim=c(0,1), xlim=c(0,1), lwd=2, col=4, main="Receiver Operator Characteristic Curve")

## proportion of True Positives
##proportion_TP <- TP/sum(y==1)
proportion_TP <- TP/sum(confusion_matrix)
proportion_TP

## proportion of FALSE Positives
##proportion_FP <- FP/sum(y==0)
proportion_FP <- FP/sum(confusion_matrix)
proportion_FP

## package versions
## area under the precision recall curve and graph

## use the functions in pROC
roc_fit <- roc(y, prob_y)
roc_fit
names(roc_fit)
summary(roc_fit)
plot(roc_fit)

## use the fucntions in PRROC
roc_fit <- roc.curve(scores.class0 = prob_y[y==1], scores.class1 = prob_y[y==0], curve=TRUE)
precsion_recall_fit <- pr.curve(scores.class0 = prob_y[y==1], scores.class1 = prob_y[y==0], curve=TRUE)

## print
roc_fit
precsion_recall_fit

## plot curves
par(mfrow=c(1,1), mar=c(5,4,4,4))
plot(roc_fit)

par(mfrow=c(1,1), mar=c(5,4,4,4))
plot(precsion_recall_fit)


mean(abs(precision - recall),na.rm=T)



## F-score is another measure of the accuracy of a test.
## It is calculated using both the precision and recall scores.
## F-score is the harmonic mean of precision and recall.
## So highest F1 score is based on the equally weighted pair of best precision + recall
F1_score <- 2 * (precision * recall) / (precision + recall)
F1_score

## best F1-score, precision and recall, based on the best F1-Score
F1_score[which(F1_score==max(F1_score, na.rm=T))]
precision[which(F1_score==max(F1_score, na.rm=T))]
recall[which(F1_score==max(F1_score, na.rm=T))]
accuracy[which(F1_score==max(F1_score, na.rm=T))]

proportion_TP[which(F1_score==max(F1_score, na.rm=T))]
proportion_FP[which(F1_score==max(F1_score, na.rm=T))]

## note that this is this is roughly equivalent to the best F1 score
proportion_TP[which(F1_score==max(F1_score, na.rm=T))] + proportion_FP[which(F1_score==max(F1_score, na.rm=T))]


## which prediction threshold is best based on the best F1-score?
threshold[which(F1_score==max(F1_score, na.rm=T))]


## plot accuracy, precision, recall and the F1-Score by the threshold values used to predict 1s and 0s
par(mfrow=c(2,2), mar=c(5,4,4,4))
plot(threshold, F1_score, type="l", ylim=c(0,1), lwd=2, col=1, main="F1-Score", xlab="Prediction threshold", ylab="F1-Score")
abline(v=threshold[which(F1_score==max(F1_score, na.rm=T))])
plot(threshold, precision, type="l", ylim=c(0,1), lwd=2, col=2, main="Precision", xlab="Prediction threshold", ylab="Precision")
abline(v=threshold[which(F1_score==max(F1_score, na.rm=T))])

plot(threshold, recall, type="l", ylim=c(0,1), lwd=2, col=3, main="Recall", xlab="Prediction threshold", ylab="Recall")
abline(v=threshold[which(F1_score==max(F1_score, na.rm=T))])

plot(threshold, accuracy, type="l", ylim=c(0,1), lwd=2, col=4, main="Accuracy", xlab="Prediction threshold", ylab="Accuracy")
abline(v=threshold[which(F1_score==max(F1_score, na.rm=T))])

## plot TP and FP proportions by the F1-Score
par(mfrow=c(1,2), mar=c(5,4,4,4))
plot(threshold, proportion_TP, type="l", ylim=c(0,1), lwd=1, col=4, main="Proportion of True Positives", xlab="Prediction threshold", ylab="Proportion of True Positives")
abline(v=threshold[which(F1_score==max(F1_score, na.rm=T))])

plot(threshold, proportion_FP, type="l", ylim=c(0,1), lwd=1, col=4, main="Proportion of False Positives", xlab="Prediction threshold", ylab="Proportion of False Positives")
abline(v=threshold[which(F1_score==max(F1_score, na.rm=T))])


## recall the true proportion of 1s and 0s from the simulated data
table(y)
