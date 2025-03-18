## R_DSIS_problem_set_probability_week9_10.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2025, Fall 2023, Winter 2023, Winter 2022
##
## Week 9 / Week 10
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Instructions:
##
## This is an optional problem set that covers material in Davies Ch.8.
## Please feel free to try any or all of the questions.
## I am happy to go over each question with you individually during office hours.
##
##
##########################################################################
## Problem 1
##########################################################################
## (1a) use the rnorm() function to create 1000 normally distributed random values as an object
## (1b) use the truehist() function from the MASS library to graph the values created in object from step (1a)
## (1c) calculate each of the distances between the mean() value of the object in step (1a) and each value in the object
## (1d) calculate the square of each of the distances calculated of the object from (1c) 
## (1e) calculate the sum() of all the squared distances in the object from step (1d) and create a new object for this sum
## (1f) divide the single sum vakye created in step (1e) by n and also n-1
## (1g) compare the two values calculated in step (1e) to the same value calculated using the var() function and the original object created in step (1a)




##########################################################################
## Problem 2
##########################################################################
## (2a) write a simulation (a repeated process) for problem 1 in which you create a normally distributed random with an increasing sample size (start at about 10)
## (2b) graph the difference between the variance calculated using the var()  function and the squared distance calculated in (1c) and then divide by n and also n-1





##########################################################################
## Problem 3
##########################################################################
## You have 4 red lego pieces, 6 blue lego pieces. 
## (3a) What is the probability of selecting a red piece?
## (3b) What is the probability of selecting a blue piece? 
## (3c) write a simulation with the sample() function to estimate the probability of selecting a red lego or a blue lego
##
## Now suppose that 2 of the lego pieces are blue and red: 
## (3d) What is the probability of selecting a red lego if you have already selected a blue lego
## (3e) What is the probability of selecting a blue lego if you have already selected a red lego
## (3f) write a simulation with the sample() function to estimate the conditional probability of selecting a red lego or a blue lego when you have already selected a lego 




##########################################################################
## Problem 4
##########################################################################
## (4a) describe in your own words: Discrete probability distribution
## (4b) describe in your own words: Continuous probability distribution
## (4c) describe in comments the following line of code: pnorm(q=0, mean=0, sd=1) - pnorm(q=-1, mean=0, sd=1)





##########################################################################
## Problem 5 (advanced)
##########################################################################
## (5a) Calculate the probability of flipping a fair coin (p=0.5) heads 2 times
## (5b) Simulate the probability of flipping a fair coin (p=0.5) heads 2 times
## (5c) Write a function to complete (5a) for a user specified number of trials
## (5d) Write a function to complete (5b) for a user specified number of trials





##########################################################################
## Problem 6
##########################################################################
## Plot the full range of probability/density for a random variable using the d-type function using the curve() plot function: 
## (6a) discrete probability: Poisson, geometric, negative binomial, hypergeometric
## (6b) continuous probability: Student's t-distribution, exponential, chi-squared, f-distribution, gamma, beta





##########################################################################
## Exercise 15.1 (page 313) in the Davies book
##########################################################################
## You have a standard deck of 52 playing cards. There are two colors (black and red) and four suits (spades are black, clubs are black, hearts are red, and diamonds are red). Each suit has 13 cards, in which there is an ace, number cards from 2 to 10, and three face cards (jack, queen, and king).
## 15.1.a. You randomly draw and then replace a card. What's the probability it's an ace?  What's the probability it's the 4 of spades?
## 15.1.b You randomly draw a card, and after replacing it, you draw another. Let A be the event that the card is a club; let B be the event that the card is red. What is Pr(A|B)? That is, what is the probability of the second card is a club, given the first one was a red card? Are the two events independent?
## 15.1.c. Repeate (b), this time assuming that when the first (club) card is drawn, it is not replicated. Would this change your answer to (b) in terms of independence? 

