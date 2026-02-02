## R_DSIS_week05_loops_logic_lists_dataframes_tables.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2026, Winter 2025, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
##
## Week 5
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## For this R tutorial, we will learn how:
## (1) learn to work with logical statements
## (2) learn to use for loops and while loops
## (3) navigate vectors, matrices, lists, dataframes, and tables using logical statements and loops
## (4) apply functions to matrices, lists, dataframes, and tables
## (5) simulation using a for loop
##
##########################################################################

## logical statements return TRUE or FALSE but never both for any statement or compound statement

###########
## EQUAL ##
###########

## these statements are setup as potentially true or false. 
## we are asking R to evaluate whether or not they are true or false

## == tests if the left-hand side of the double-equal sign is the same as the value 
## on the right-hand side of the double-equal sign

## the statements below test the truth status of statements set up to be true
1 == 1

pi == pi

print(pi, digits=22)

## notice that the printed values are different but the underlying test shows that values are the same
print(pi, digits=5) == print(pi, digits=22)


1 == pi

1 == 2

## modulo operator 
1 %% 2 == 0
2 %% 1

## also works with vectors 
1 == 1:5


## elemtwise or pairwise comparisons (compares values at the same coordiante position in each vector)
1:5 == 1:5

letters == letters

2:6 == 1:5

###############
## NOT EQUAL ##
###############

## != tests if the left-hand side of the not-equal sign is NOT the same as 
## the value on the right-hand side of the not-equal sign

## we can also ask for the truth status of statements set up to be false
1 != 1

pi != pi

1 != pi

1 != 2


## so far we have looked at simple statements. 
## we can make these compound statements using the 
## AND operator & (also &&), 
## the OR operator | (also ||) 
## (there are more but let's not worry about these additional operators now)

#########
## AND ##
#########

1 == pi & pi == pi

## the above statement returns an equivalent to:
FALSE & TRUE

## for an AND statement to return TRUE, both the left-hand side and right-hand side of the logical statement must both be TRUE conditions themselves

1 == 1 & pi == pi

TRUE & TRUE

1 == pi & 1 == 2

FALSE & FALSE


## the double AND '&&' works on a single logical statement on each sideo && operator

## legal
1 && 5

## legal
FALSE && FALSE

## Not-legal 
c(FALSE, TRUE) && c(TRUE, TRUE)

## legal with the single AND operator for element-wise comparisons 
c(FALSE, TRUE) & c(TRUE, TRUE)


########
## OR ##
########

## the OR operator looks for at least one condition in a compound set of conditions to be true
## the following statement return TRUE because at least one of the component conditions is TRUE
1 == pi | pi == pi

FALSE | TRUE

TRUE | FALSE

FALSE | FALSE

## the above statements work with the double OR operator too
1 == pi || pi == pi

FALSE || TRUE

TRUE || FALSE

FALSE || FALSE


## if both statements are true then OR returns TRUE
1 == 1 | pi == pi

## if both statements are false then OR returns FALSE
1 == pi | 2 == pi


## Not-legal 
c(FALSE, TRUE) || c(TRUE, TRUE)

## legal with the single OR operator for element-wise comparisons 
c(FALSE, TRUE, FALSE, TRUE) | c(TRUE, TRUE, FALSE, FALSE)


## the above is equivalent to the following 4 comparisons:
FALSE | TRUE
TRUE | TRUE
FALSE | FALSE
TRUE | FALSE



#########
## XOR ##
#########

## exclusive OR

## the xor() function is a function for XOR, 
## in which not both conditions must be true  for XOR to return TRUE (we won't use this much if ever)

## this statement is FALSE because both statements are TRUE
xor(1 == 1, pi == pi)

## this statement is TRUE because one statement is TRUE and one statement is FALSE
xor(1 == 1, pi == 1)

xor(1 == pi, 1 == 1)

## this statement is FALSE because both statements are FALSE
xor(1 == pi, pi == 1)



##########################################################################
## if, else, and ifelse
##########################################################################

## inside an if statement we will use && and || instead of & and |

if(TRUE){ 
  print("print this character string") 
}

if(FALSE){ 
  print("DON'T print this character string") 
}

if(TRUE & TRUE) print("print this character string")

if(1 == 1 & pi == pi){
    print("print this character string")
}

if(1 == pi & pi == pi){
    print("print this character string")
}

## check the condition in the if statement, if that is TRUE print, else print the second statement
## note that the else statement needs to be on the same line as the right sqiggly bracket }
if(1 == pi & pi == pi){
    print("print this character string")
} else{
    print("this is another character string!!")
}

if(FALSE){
    
} else{
    print(2+2)
}

## ifelse() takes three arguments, a logical condition and two values to be returned for either the TRUE or FALSE condition

ifelse(TRUE, 1, 0)

ifelse(FALSE, 1, 0)


ifelse(FALSE, 1, 2)

ifelse(pi==1, pi, 1)

ifelse(1 == pi & pi == pi, "print this character string", "is this really a helpful example??")


## read data from the current working directory
#survey_data <- read.csv("DSIS_data/survey_498_20200129.csv", header=TRUE)

## this doesn't work quite right
#survey_data <- read.csv("DSIS_data/funYesNoQuestions.csv", header=TRUE)
survey_data <- read.csv("Datasets/373survey.csv")
names(survey_data)
dim(survey_data)
nrow(survey_data)
ncol(survey_data)
head(survey_data)


#survey_data <- read.csv("DSIS_data/funYesNoQuestions.csv", header=TRUE, sep=";")
#names(survey_data)

dim(survey_data)

head(survey_data)

## use ifelse statement to add an age value for the over_21 question
#ifelse(survey_data$over_21==1, "old person", "not old person")

## we can use the same statement above to add a new character variable to the dataframe
#survey_data$old_person <- ifelse(survey_data$over_21==1, "old person", "non old person")

survey_data

table(survey_data[,3])

table(survey_data$Do.you.think.you.could.win.in.a.fight.against.10.beavers.)

table(survey_data$Do.you.like.football.saturdays.)

#table(survey_data$Have.aliens.ever.seen.earth.)

table(survey_data$Do.you.think.you.could.win.in.a.fight.against.10.beavers., survey_data$Do.you.like.football.saturdays.)

summary(survey_data)

head(survey_data)

#test <- ifelse(survey_data$Are.dogs.better.than.cats.=="Yes", 1, 0)

table(survey_data$Have.you.seen.Game.of.Thrones.)

survey_data$Have.you.seen.Game.of.Thrones.=="Yes"

test <- ifelse(survey_data$Have.you.seen.Game.of.Thrones.=="Yes", 1, 0)

table(test)

mean(test)



##########################################################################
## > greater than
## < less than
## >= greater than or equal to
## <= less than or equal to
##########################################################################

## 1 is greater than pi is FALSE
1 > pi

pi > 1

## pi is less than 1 is FALSE
pi < 1


## 1 is greater than 1 is TRUE
pi > 1

## create a vector of logical values for each condition (there will be one FALSE condition)
1:5 > 1

## create a vector of logical values for each condition (there will be 0 FALSE conditions)
1:5 >= 1

1:5 < 1

1:5 <= 1


##########################################################################
## navigating objects with logical statements instead of coordinates
##########################################################################

## read data from the current working directory
social_media_data <- read.csv("Datasets/users-by-social-media-platform.csv", header=TRUE)

## print only values for facebook using the subset function
names(social_media_data)
dim(social_media_data)

subset(social_media_data, Entity=="Facebook")

## print only values for facebook using the subset function
subset(social_media_data, Entity=="Facebook" & Year>=2016)

## print only values for entities that are NOT facebook using the subset function
subset(social_media_data, Entity!="Facebook" & Year>=2016)




##########################################################################
## loops and other iterators 
##########################################################################

## Note: see Matloff Chapter 7 (Control Structures) for more information on the material below

## it's like jumping rope!



##########################################################################
## repeat
##########################################################################

## infinite repetitions
repeat{
  ## do something 
  ## when does this stop?
}


## one repetition 
repeat{
  
  break
}

## conditional number of repetition 
condition <- 0
repeat{
  condition <- condition + 1
  if(condition==10){
    break
  }
}




##########################################################################
## for loops
##########################################################################

## the for loop is constructed so that it iterates for the length of vector, 
## while keeping track of the indicator variable
## loops are like turning pages in a book --- the process is always the same (or usually the same) but we learn new things on each page
##

## print the indicator variable each time the loop iterates
for(i in 1:10){
    print(i)
}

for(i in 1:3){

}

for(i in 1:nrow(social_media_data)){
  #print(i)
  print(social_media_data$monthly_active_users[i])
}


seq(2,10,2)

length(seq(2,10,2))

for(i in seq(2,10,2)){
    print(i)
}


## print the indicator variable times the indicator variable each time the loop iterates
for(i in 1:10){
    print(i*i)
}

## print the indicator variable minus the indicator variable each time the loop iterates
for(i in 1:10){
    print(i-i)
}

myvec <- c("a", "b", "c", "d", "e")
myvec

for(i in 1:length(myvec)){
    print(myvec[i])
}

##
## use something other than numeric information as the index
for(i in letters){
    print(i)
}

## use unordered numbers
for(i in c(1,4,800,5,3)){
    print(i)
}




## declare the object in memory so we can access it later on
vec <- NA
vec
vec[1]
length(vec)

vec <- c()
vec
vec[1]
length(vec)

## set i to the ith position of the vector each ith iteration the loop
for(i in 1:10){
    vec[i] <- i
}
vec


vec <- NA
for(i in 1:10){
    vec[i] <- i*i
}
vec


## we can declared a variable and add 1 to it each iteration of the loop
count <- 0
for(i in 1:10){
    count <- count + 1
}
count
i


## for loops can help us think through a process that happens all at once to a vector

dice_rolls <- c()

simulation_size <- 10
dice_rolls <- list()
for(i in 1:simulation_size){
  dice_rolls[[i]] <- sample(1:6, size=10, replace=TRUE)
}
dice_rolls

## we could also just set the size argument to simulation_size and return the sample result. 
## this is a vectorized version of the loop version above.

dice_rolls <- sample(1:6, size=simulation_size, replace=TRUE)
dice_rolls


##########################################################################
## while loop
##########################################################################

## the while loop is constructed to do something until a logical condition becomes TRUE
i <- 0

## is starts at 0
i

dice_roll <- 1
while(dice_roll != 6){
  dice_roll <- sample(1:6,size=1,T)
  print(dice_roll)
}
## this structure is similar to the for loop in terms of the process; however it ends when a condition is met instead of iterating through the values of an index
while(i <= 10){
    i <- i + 1
}

## i is 11 because the loop stopped once i no longer satisfied the logical condition
i

## i should be reserved for an iterator variable that is designed to keep track of the coordinate position in a vector or matrix

count <- 0

## is starts at 0
count

## this structure is similar to the for loop in terms of the process; however it ends when a condition is met instead of iterating through the values of an index
while(count <= 10){
    count <- count + 1
}

## i is 11 because the loop stopped once i no longer satisfied the logical condition
count


##########################################################################
## using loops to travel through the coordinates of a matrix or vector
##########################################################################

## create a matrix mat
mat <- matrix(1:12, nrow=4, ncol=3)
mat


## we can explore the matrix using the loop and our knowledge of the coordinates of each positions in the 2-D space

for(i in 1:nrow(mat)){
    print(mat[i,])
}


## nested for loop
## we can also nest the two loops together to explore 2 dimensions of the matrix
for(i in 1:nrow(mat)){
    for(j in 1:ncol(mat)){
        print(mat[i,j])
    }
}

## we can switch the order by which we proceed through the coordinates of the matrix
for(j in 1:ncol(mat)){
    for(i in 1:nrow(mat)){
        print(mat[i,j])
    }
}

## let's use the single for loop to calculate values for each row in the matrix

## declare an empty object in memory so that we can store values in later with reference to its coordinates
row_sums <- NA

for(i in 1:nrow(mat)){
    row_sums[i] <- sum(mat[i,])
}
row_sums


## let's repeat this task for columns
column_sums <- NA

for(j in 1:ncol(mat)){
    column_sums[j] <- sum(mat[,j])
}
column_sums

column_proportions <- NA
for(j in 1:ncol(survey_data)){
  column_proportions[j] <- mean(ifelse(survey_data[,j]=="Yes", 1, 0))
}
column_proportions

data.frame(names(survey_data), column_proportions)

survey_data

##########################################################################
## apply() a function to margins (the rows or columns) of an array or matrix
##########################################################################

## create a matrix mat
mat <- matrix(1:12, nrow=4, ncol=3)
mat

## use the sum function on the rows (the first dimension of the matrix)
apply(mat, MARGIN=1, FUN=sum)

mat


## use the sum function on the columns (the second dimension of the matrix)
apply(mat,MARGIN=2,FUN=sum)


## use the mean function on the rows (the first dimension of the matrix)
apply(mat,1,mean)

## use the mean function on the columns (the second dimension of the matrix)
apply(mat,2,mean)

## we can pass any function that works on numbers through the apply function
## the function is applied to every value in the row or column


##########################################################################
## apply() a function to margins (the rows or columns) of a dataframe
##########################################################################

## read data from the current working directory
#survey_data <- read.csv("Datasets/survey_498_20200129.csv", header=TRUE)
survey_data <- read.csv("Datasets/373survey.csv")
survey_data

## use the sum function on the rows (the first dimension of the matrix) but make sure to exclude the first column because it is the subject ids
apply(survey_data[,-1], MARGIN=1, FUN=sum)


ifelse(survey_data[,-1]=="Yes", 1,0)

survey_data[,-1] <- ifelse(survey_data[,-1]=="Yes", 1,0)
dim(survey_data)

## we can add extra arguments to apply
## note that any additional arguments that we add in the apply() function are used for and in reference to the function we specify for the FUN argument in apply()
## since we are using the sum() function, we can use ?sum to find the additional arguments for addressing missing values
apply(survey_data[,-1], MARGIN=1, FUN=sum, na.rm=T)

sum(c(1,2,3))
sum(c(1,2,3,NA))
sum(c(1,2,3,NA), na.rm=T)

## use the above function to add a new column to our dataframe
survey_data$subject_sums <- apply(survey_data[,-1], MARGIN=1, FUN=sum, na.rm=T)

## view the data
survey_data

## tablulate the data
table(survey_data$subject_sums)

## graph the tabulation
barplot(table(survey_data$subject_sums))

## use the new count data to examine specific cases with subset() function and logical statements
subset(survey_data, subject_sums>=7)


##########################################################################
## tapply() "table apply" a function to margins (the rows or columns) of a dataframe
##########################################################################

## NOTE: In my applied work, I find tapply() to be a little bit confusing and I have typically been able to create group level summaries using other tools (see above)

## use the cross-tabs function to count the number of values contained in each Entity by Year combination
tabs <- xtabs(monthly_active_users ~ Entity + Year, data= social_media_data)

## tabs is a table
tabs

## we can take the average across the rows of the table using tapply()

## we need to first create an object of the same size as the table with values for which groups we want to apply our funtion to
coordinate_groups <- matrix(rep(1:19,times=18), nrow=19, ncol=18)
coordinate_groups
tapply(tabs, INDEX=coordinate_groups, FUN=mean)

coordinate_groups <- matrix(rep(1:18,each=19), nrow=19, ncol=18)
coordinate_groups
tapply(tabs, INDEX=coordinate_groups, FUN=mean)



##########################################################################
## simulation with a for loop
##########################################################################
##
## (1) Simulate the roll of a D6 dice
## (2) Repeatedly simulate the roll of a D6 dice and see how close the average value is to the expected value. 
## (3) Learn about the central limit theorem from the simulation.
##
## Notes: The Central Limit Theorem (CLT) establishes that when independently generated variables (iid: independent and identically distributed random variables) are added together, the sums or averages of these variables (when normalized) converge towards a normal distribution. 
##
## This property emerges even if the original variables are not individually normally distributed, as with the roll of a die. 
##
## The probability of any value from the single roll of die is equivalent to any other value for the same-sided die in the limit (when the number of rolls approaches infinity).
## 
##########################################################################


library(MASS)


## simulate 20 randomly generated rolls from a D6 (6-sided-die)
sample(1:6, size=20, replace=TRUE)

## true mean is 3.5
(1 + 2 + 3 + 4 + 5 + 6) / 6

## or 
mean(1:6)

## true variance is approximately 2.916667 or exactly 70/24 
(1 - 3.5)^2 * (1/6) + (2 - 3.5)^2 * (1/6) + (3 - 3.5)^2 * (1/6) + (4 - 3.5)^2 * (1/6) + (5 - 3.5)^2 * (1/6) + (6 - 3.5)^2 * (1/6)

## or
sum((1:6 - mean(1:6))^2 * (1/6))

## repeat the simulation 10,000 times and calculate the average
n_sims <- 2000

## number of samples to roll each iteration
n_samples <- 10

## create two objects to hold the calculated mean and variance from each simulated sample
sim_mean_values <- c()
sim_var_values <- c()

## iterate/repeat the simulation n_sims times
for(i in 1:n_sims){
  
  ## create output
  sample_output <- sample(1:6, size=n_samples, replace=TRUE)
  
  ## save the output in the i_th position of the objects
  sim_mean_values[i] <- mean(sample_output)
  sim_var_values[i] <- var(sample_output)
  
}

## calculate the mean and variance of the 10,000 sample means
mean(sim_mean_values)
mean(sim_var_values)

## set graphical parameters
par(mfrow=c(1,2), mar=c(4,3,1,1))

## plot histograms 
truehist(sim_mean_values, main="Mean Estimate")
truehist(sim_var_values, main="Variance Estimate")


## calculate and plot the converging average using increasing sample sizes starting at 1 and ending at all the samples
## set graphical parameters
par(mfrow=c(1,2))

##
plot(0,0, ylim=c(2.5,4), xlim=c(0,n_sims), type="n", main="Mean Estimate")
value <- c()
for(i in 1:n_sims){
  value[i] <- mean(sim_mean_values[1:i])
}
lines(value)
abline(h=3.5, col="orange", lwd=2, lty=2)

##
plot(0,0, ylim=c(2.5,4), xlim=c(0,n_sims), type="n", main="Variance Estimate")
value <- c()
for(i in 1:n_sims){
  value[i] <- mean(sim_var_values[1:i])
}
lines(value)
abline(h=2.916667, col="orange", lwd=2, lty=2)


## recall the variance
sqrt(2.916667)

## the values converge towards normality 
summary((sim_mean_values - 3.5))
mean((sim_mean_values - 3.5))
var((sim_mean_values - 3.5))




