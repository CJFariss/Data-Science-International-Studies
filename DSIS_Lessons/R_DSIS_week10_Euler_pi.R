## R_DSIS_week10_Euler_pi.R
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
## Note, we use e and pi in a lot of probability distributions so let's see what the numbers are and why they're interesting (and have been interesting for a long time).
##
## (1) Learn about the number e and pi using an iteration to estimate a close value to the "hard-coded" value available in our computer. 
## (2) Calculate how close the estimate is to the "hard-coded" value.
##
##########################################################################
##
## e
## based on a Taylor expansion

e_values <- c()
sim_n <- 17
out <- 0
x<-1
for(i in 0:sim_n){
  out <- out + ((x^i)/factorial(i))
  #out <- out + (1/factorial(i))
  e_values[i+1] <- out
}
print(e_values, digits=22)
print(exp(1), digits=22)


test <- sum(1/factorial(0:sim_n)) 


print(e_values[sim_n], digits=22)
print(test, digits=22)
print(exp(1), digits=22)

test == exp(1)
e_values[sim_n] == exp(1)



## Gregory-Leibniz series
##π=(4/1)-(4/3)+(4/5)-(4/7)+(4/9)-(4/11)+(4/13)-(4/15) ⋯
(4/1)
(4/1)-(4/3)
(4/1)-(4/3)+(4/5)
(4/1)-(4/3)+(4/5)-(4/7)
(4/1)-(4/3)+(4/5)-(4/7)+(4/9)
(4/1)-(4/3)+(4/5)-(4/7)+(4/9)-(4/11)
(4/1)-(4/3)+(4/5)-(4/7)+(4/9)-(4/11)+(4/13)
(4/1)-(4/3)+(4/5)-(4/7)+(4/9)-(4/11)+(4/13)-(4/15)
(4/1)-(4/3)+(4/5)-(4/7)+(4/9)-(4/11)+(4/13)-(4/15)+(4/17)
(4/1)-(4/3)+(4/5)-(4/7)+(4/9)-(4/11)+(4/13)-(4/15)+(4/17)-(4/19)

Gregory_Leibniz <- function(iterations=3){
  if(iterations==1){
    return(4)
  }else if(iterations==2){
    return((4/1)-(4/3))
  }else{
    odd_numbers <- seq(from=1, to=iterations, by=2)
    value <- 0
    for(i in 1:length(odd_numbers)){
      if(i%%2==1)value <- value + 4/odd_numbers[i]
      if(i%%2==0)value <- value - 4/odd_numbers[i]
    }
    return(value)
  }
}
Gregory_Leibniz(1000)

Gregory_Leibniz_fast <- function(iterations=3){
  if(iterations==1){
    return(4)
  }else if(iterations==2){
    return((4/1)-(4/3))
  }else{
    odd_numbers <- seq(from=1, to=iterations, by=2)
    value <- 0
    pi_additions <- sum(4/odd_numbers[seq(from=1,to=length(odd_numbers), by=2)])
    pi_subtractions <- sum(4/odd_numbers[seq(from=2,to=length(odd_numbers), by=2)])
    value <- pi_additions - pi_subtractions
    return(value)
  }
}
Gregory_Leibniz_fast(1000)


Gregory_Leibniz(1000)
Gregory_Leibniz_fast(1000)
pi

Gregory_Leibniz(100000)
Gregory_Leibniz_fast(100000)
pi

## just go fast now (can't go bigger than this really
print(Gregory_Leibniz_fast(10000000), digits=22)
print(pi, digits=22)

## plot the output
test <- lapply(1:1000, Gregory_Leibniz_fast)
plot(unlist(test), type="l", col=grey(.5))
abline(h=pi, col=2)

## Nilakantha series
##π=3+4/(2·3·4)-4/(4·5·6)+4/(6·7·8)-4/(8·9·10)+4/(10·11·12)-4/(12·13·14) ⋯
3
3+4/(2*3*4)
3+4/(2*3*4)-4/(4*5*6)
3+4/(2*3*4)-4/(4*5*6)+4/(6*7*8)
3+4/(2*3*4)-4/(4*5*6)+4/(6*7*8)-4/(8*9*10)
3+4/(2*3*4)-4/(4*5*6)+4/(6*7*8)-4/(8*9*10)+4/(10*11*12)
3+4/(2*3*4)-4/(4*5*6)+4/(6*7*8)-4/(8*9*10)+4/(10*11*12)-4/(12*13*14)
3+4/(2*3*4)-4/(4*5*6)+4/(6*7*8)-4/(8*9*10)+4/(10*11*12)-4/(12*13*14)+4/(13*14*15)
3+4/(2*3*4)-4/(4*5*6)+4/(6*7*8)-4/(8*9*10)+4/(10*11*12)-4/(12*13*14)+4/(13*14*15)-4/(14*15*16)

Nilakantha_series <- function(iterations=3){
  if(iterations==1){
    return(3)
  }else if(iterations==2){
    return(3+4/(2*3*4))
  }else{
    value <- 3
    even_numbers <- seq(from=2, to=iterations+2, by=2)
    for(i in 1:(length(even_numbers)-1)){
      denominator <- prod(seq(from=even_numbers[i], to=even_numbers[i+1], by=1))
      if(i%%2==0)value <- value - 4/denominator
      if(i%%2==1)value <- value + 4/denominator
    }
    return(value)
  }
}
Nilakantha_series(10)
Nilakantha_series(100)
Nilakantha_series(1000)
Nilakantha_series(10000)

print(Nilakantha_series(10000), digits=22)
print(pi, digits=22)

print(Nilakantha_series(100000), digits=22)
print(pi, digits=22)

print(Nilakantha_series(1000000), digits=22)
print(pi, digits=22)


Nilakantha_series_fast <- function(iterations=3){
  if(iterations==1){
    return(3)
  }else if(iterations==2){
    return(3+4/(2*3*4))
  }else{
    even_numbers <- seq(from=2, to=iterations+2, by=2)
    mat <- cbind(even_numbers, even_numbers+1, even_numbers+2)
    value <- 3
    denominator <- apply(mat,1,prod)
    for(i in 1:length(denominator)){
      if(i%%2==0)value <- value - 4/denominator[i]
      if(i%%2==1)value <- value + 4/denominator[i]
    }
    return(value)
  }
}
Nilakantha_series_fast(10)
Nilakantha_series_fast(100)
Nilakantha_series_fast(1000)
Nilakantha_series_fast(10000)

print(Nilakantha_series_fast(10000), digits=22)
print(pi, digits=22)

print(Nilakantha_series_fast(100000), digits=22)
print(pi, digits=22)

print(Nilakantha_series_fast(1000000), digits=22)
print(pi, digits=22)

print(Nilakantha_series_fast(10000000), digits=22)
print(pi, digits=22)



## plot the output
test <- lapply(1:1000, Nilakantha_series_fast)
plot(unlist(test), type="l", col=grey(.5))
abline(h=pi, col=2)
