## R_DSIS_week07_functions_continued.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2024, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
##
## Week 7
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##
##########################################################################
## Introduction to tutorial:
##
## For this R tutorial, we will learn how:
## (1) learn to write functions using the function called function
## (2) identify the return() value of a function
## (3) use the missing() function to
##
##########################################################################


## define an empty function called function_name
## we use the function called function (which is a little bit confusing)
function_name <- function(){
    return()
}


## print the function definition to the screen
function_name


## the function called function makes a new function instead of an object
## this is the first time we have seen something other than an object created on the left hand side of the <- assignment operator



##########################################################################
## SEE the function week for more information on the code below
## lapply() a function to each element in a list
##########################################################################

## lapply() is one of the most useful and most confusing functions in base R
## lapply() is essential for large scale data manipulatio and simulations when using base R
## but it is confusing!
## I promise it will make sense by the end of the course

## there are number of ways to set up the lapply() function
## my advice for learning to use the lapply() function is to make it "look like a for loop"

## simple for loop
vec <- NA
vec

vec <- c()
vec

for(i in 1:5){
    vec[i] <- i*i
}
vec

## re-write the for loop as a function applied to an empty list
## the content of the function should be identical to that of the for loop (note that we have to specify the specific object we want the function to return
vec <- lapply(1:5, function(i){
    local_variable <- i*i
    return(local_variable)
})
vec
unlist(vec)


## this is a powerful reformulation of the for loop but we can think about the two structures in exactly the same way


## let's do something computationally difficult with a for loop (don't worry about the guts of the function for now)
start_time <- Sys.time()
simulation_values <- NA
for(i in 1:10000){
    simulation_values[i] <- sum(rnorm(100000))
}
summary(simulation_values)

## calculate the elapsed time
Sys.time() - start_time


## let's use the lapply version of the computationally difficult process
start_time <- Sys.time()

simulation_values_list <- lapply(1:10000, function(i){
    return(sum(rnorm(100000)))
})
summary(unlist(simulation_values_list))

## calculate the elapsed time
Sys.time() - start_time

## let's graph the results for comparison
library(MASS)
par(mfrow=c(1,2))
truehist(simulation_values, col="darkorange")
truehist(unlist(simulation_values_list), col="steelblue1")




##########################################################################
## compare apply, for loop, and vectorization (apply is also a form of vectorization)
##########################################################################

## declare variables

## to raise the number of simulations
power <- c(2,3,4)

## don't go above 5!
#power <- c(2,3,4,5)

## calculate the time taken for each operation
simple_time <- NA
apply_time <- NA
loop_time <- NA

## loop through each operation and store the time taken in the variables declared above
for(i in 1:length(power)){
    ## print what power the loop is at
    print(power[i])
    
    ## set the number of draws to take
    n <- 10^power[i]
    
    ## generate 5 0,1 vectors of length n
    v1 <- rbinom(n, 1, 0.5)
    v2 <- rbinom(n, 1, 0.5)
    v3 <- rbinom(n, 1, 0.5)
    v4 <- rbinom(n, 1, 0.5)
    v5 <- rbinom(n, 1, 0.5)
    
    ## column bind the vectors together
    v <- cbind(v1, v2, v3, v4, v5)
    
    ## declare a vector that uses one of the sequence function to store numbers from 1 until n
    j <- 1:n
    
    ## create a variable to store the output
    out <- NA
    d1 <- Sys.time()
    out[j] <- v[j,1]+v[j,2]+v[j,3]+v[j,4]+v[j,5]
    d2 <- Sys.time()
    simple_time[i] <- d2-d1
    
    ## print the summary while the loop is running to compare the output
    ## and make sure each procedure is generating the same answer
    print(summary(out))
    
    ## same as above but use the apply function
    d1 <- Sys.time()
    apply_out <- apply(v, MARGIN=1, FUN=sum)
    d2 <- Sys.time()
    apply_time[i] <- as.list(d2-d1)
    
    print(summary(apply_out))
    
    
    ## same as above but use a for loop
    d1 <- Sys.time()
    loop_out <- NA
    for(k in 1:n){
        loop_out[j] <- sum(v[k,])
    }
    d2 <- Sys.time()
    loop_time[i] <- d2-d1
    print(summary(loop_out))
    
}

## print the results to the screen
cbind(power, simple_time, apply_time, loop_time)




##########################################################################
## recursion function examples
##########################################################################

## recursion means defining a function in terms of itself
recursion_func_example <- function(x){
  if(x<100){
    x <- recursion_func_example(x+1)
  }else{
    return(x)
  }
  return(x)
}
recursion_func_example(-100)

recursion_func_example(120)

## recursive factorial function for integers
factorial_func <- function(x) {
  if(x > 1){
    return(x * factorial_func(x-1)) ## calls itself here
  } else if(x==1 | x==0){
    return(1)
  } else{
    return(NaN)
  }
}

## call function
factorial_func(5)
factorial_func(4)
factorial_func(3)

## compare to base R factorial function
factorial(5)

## call function again and compare it to the base R factorial function
factorial_func(1)
factorial(1)

factorial_func(0)
factorial(0)

factorial_func(-1)
factorial(-1)
