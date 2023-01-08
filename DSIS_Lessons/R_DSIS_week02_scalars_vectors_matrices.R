## R_DSIS_week02_scalars_vectors_matrices.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2023, Winter 2022, Winter 2021, Winter 2020
##
## Week 2
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## For this R tutorial, we will learn how:
##  (1) how to create objects: scalars, vectors, matrices, and arrays in R
##  (2) how to access the coordinate systems of these objects using [] (bracket notation)
##  (3) learn the difference between [], (), and, {} 
##  (4) manipulate (rotate, flip, overwrite, append to) each of these data objects
##  (5) learn to explore these objects using the coordinate system
##  (6) matrix algebra notation (OPTIONAL)
## 
##########################################################################



##########################################################################
## numeric scalars vectors
##########################################################################

## create a scalar object
s <- 2

## print s to screen
s

## print to screen again 
s[1]

## s is a scalar, it is also a vector of length 1
## length of the object s
length(s)

## we can concatenate numbers to the scalar and create a vector by adding the second arugment to the right of the first argument
c(s,3)

## we can overwright the s obeject so that the new value concatentated to s is saved as a vector s
s <- c(s,3)

## what is the length of s?
length(s)

## use the [] notation to access the coordinate system of s
s[1]

## use the [] notation to access the coordinate system of s
s[2]

## create a vector of length five
v <- c(1, 2, 3, 4, 5)
v

## use the "bracket" [] notation to access the coordinate system of v
v[5]

## calculate the average of the vector
mean(v)
sum(v)/5
sum(v)/length(v)

## we can take the min or max of the vector too
min(v)
max(v)

## use subscript operator [] to get one element from the v vector we just created
v <- c(6,7,8,9,10)
v[1]
v[3]

## use a negative subscript to get all but that specific element from a vector
v[-1]

## use a vector of subscripts to get multiple elements from a vector
v[c(1,2)]

## use a vector of subscripts to exclude multiple elements from a vector
v[c(-3,-4,-5)]

## column bind using the cbind() function
## row bind using the rbind() function
## these two functions let us stack vectors together

## let's create a new numeric vector
a <- c(1,2,5.3,6,-2,4)

## print to screen
a

length(a)

## stack the colums together as columns and as rows
cbind(a,a)
rbind(a,a)



##########################################################################
## vectors as sequences of numbers
##########################################################################

## lets create a seqeuence of values using the seq() function
## create a sequence of integers from 1 to 5
seq(from=1, to=5, by=1)

?seq

seq(from=1, to=5, by=.5)

## we can create the same sequence as above using the : operator
1:5

## : only produces sequences so that the values are 1 unit distance from one another but the start and end values do not need to be integers
1.5:5.5

1.5:4

## we can use the seq() function from above to change the distance between values in the vector
seq(from=1, to=5, by=.5)

## instead of specifing the distance between values we can specify the number of units we wish to produce (i.e., the length of the vector)
seq(from=1, to=5, length.out=3)

seq(from=1, to=5, length.out=5)

seq(from=1, to=5, length.out=10)

seq(from=1, to=5, length.out=100)

## it might also be useful to generate a vector of the same value n number of times
## that is we might want to replicate a specific value n times using rep()
rep(1,10)

rep(1,times=10)

## we can replicate values from another vector
rep(c(1,2,3), times=2)

## notice the difference between using the times argument compared to the each argument
rep(c(1,2,3), each=2)



##########################################################################
## vectors as samples of numbers
##########################################################################

## coin flip
sample(0:1,size=1, replace=TRUE)

## coin flip, 2 flips (or 2 independent coins, each flipped)
sample(0:1,size=2, replace=TRUE)

## coin flip, 10 flips (or 10 independent coins, each flipped)
sample(0:1,size=10, replace=TRUE)



## six-sided die (d6), 1 roll
sample(1:6, size=1, replace=TRUE)

## six-sided die (d6), 2 rolls (or 2 dice rolled once each)
sample(1:6, size=2, replace=TRUE)

## six-sided die (d6), 6 rolls (or 6 dice rolled once each)
sample(1:6, size=6, replace=TRUE)



## 20-sided die (d20), 1 roll
sample(1:20, size=1, replace=TRUE)

## 20-sided die (d20), 2 rolls (or 2 dice rolled once each)
sample(1:20, size=2, replace=TRUE)

## 20-sided die (d20), 6 rolls (or 6 dice rolled once each)
sample(1:20, size=6, replace=TRUE)


## sample 1 element from a vector with character string elements (lower case letters)
sample(letters,size=1,replace=T)

## sample 2 elements from a vector with character string elements (lower case letters)
sample(letters,size=2,replace=T)

## sample 1 element from a vector with character string elements
sample(c("sunny", "partly_cloudy", "cloudy", "rain", "snow", "thunder storm"), size=1, replace=T)



##########################################################################
## vectors of logical variables
##########################################################################

## lets create and manipulate logical vectors (see week 7 lesson for much more detail on this)
TRUE

FALSE

c(TRUE, FALSE)

which(c(TRUE, FALSE))

which(c(FALSE, TRUE))

## use a vector of logical values to get multiple elements from a vector
v <- c(6,7,8,9,10)
v[c(TRUE,TRUE,FALSE,FALSE,FALSE)]

which(v==6)
which(v==7)
which(v==8)
which(v==9)
which(v==10)

## access the coordinate system of v using [] bracket notation and the which() function
v[which(v==6)]
v[which(v==7)]
v[which(v==8)]
v[which(v==9)]
v[which(v==10)]



##########################################################################
## matrices and arrays
##########################################################################

## Note: see Davies Chapter 3 (Matrices and Arrays) and Matloff Chapter 3 (Matrices and Arrays) for more information on the material below

## a matrix is just a 2D array (note that byrow=FALSE by default so that the values are added one column at a time from left to right)
m <- matrix( c(1,2,3,4,5,6), nrow=2, ncol=3)
m

?matrix

## covert the matrix back into a vector (note the order of the values)
c(m)

## this is the same function as above but the values are added one row at at time from top to bottom
m <- matrix( c(1,2,3,4,5,6), nrow=2, ncol=3, byrow = TRUE)
m

## covert the matrix back into a vector (note the order of the values)
c(m)

## 2D arrays using the array function which produces the same object as matrix( c(1,2,3,4,5,6), nrow=2, ncol=3)
m <- array( c(1,2,3,4,5,6), dim=c(2,3))
m

## 2D arrays using the array function which produces the same object as matrix( c(1,2,3,4,5,6), nrow=2, ncol=3, byrow = TRUE)
m <- array( c(1,2,3,4,5,6), dim=c(2,3), byrow = TRUE)
m

## arrays with more than 3 dimensions
m3 <- array( c(1:18), dim=c(2,3,3))
m3

## covert the array back into a vector
c(m3)

## create a new matrix
mymat <- rbind(c(1,3,4),5:3,c(100,20,90),11:13)
mymat

## additional functions to learn about the structure of the object (i.e., is it a matrix)
dim(mymat)
nrow(mymat)
ncol(mymat)
dim(mymat)[2]



##########################################################################
## code adapted from Section 3.2 in Davies
##########################################################################

## create a new matrix A with numeric values
A <- matrix(c(0.3,4.5,55.3,91,0.1,105.5,-4.2,8.2,27.9),nrow=3,ncol=3)

## print A
A

## print out one element in matrix A at row 3, column 2
A[3,2]

## print out one column in matrix A at column 2
A[,2]

## print out one row in matrix A at row 1
A[1,]

## print out row 2 and row 3 in matrix A
A[2:3,]

## print out column 3 and column 1 in matrix A
A[,c(3,1)]


## print out elements that exist only in row 2 and row 3 and column 3 and column 1 in matrix A
A[c(3,1),2:3]

## diag is a function that works with matrices
## it returns the diagnoal elements from the upper left to the bottom right of the matrix
## in other words it returns a vector of values from position (1,1), (2,2), ... , (n,n)
diag(x=A)


## as with vectors, we can include or excludes values from the matrix for viewing or analysis
## print A to screen with all rows and without the second column
A[,-2]

## print A to screen without the first row and with only the 3rd and 2nd column
A[-1,3:2]

## print A to screen without the first row and without the second column
A[-1,-2]

#
A[-1,-c(2,3)]

## make a new object B, which is equivalent to and a copy of A
B <- A
B

## let's replace the 2nd row in B with a different vector of numbers
B[2,] <- 1:3
B

## now let's replace the two coordinates in B
B[c(1,3),2] <- 900
B

## reverse order (flip) the 3rd row
B[,3] <- B[3,]
B

## here we are noting two positions and replacing those values with two new values
B[c(1,3),c(1,3)] <- c(-7,7)
B

## replace additional elements
B[c(1,3),2:1] <- c(65,-65,88,-88)
B

## change the diagnoal elements of b
diag(x=B) <- rep(x=0,times=3)
B



##########################################################################
## code adapted from Section 3.3 in Davies
##########################################################################

## create a new matrix A
A <- rbind(c(2,5,2),c(6,1,4))
A

## transpose A, which means to flip and rotate a
t(A)

## take the transpose of the transpose of A which returns A
t(t(A))


## create adiagonal matrix with 3 rows and 3 columns and 1 in the diagnoal positions and 0 otherwise, this is an identity matrix
A <- diag(x=4)
A


## create a new matrix A and multiply it by a scalar
A <- rbind(c(2,5,2),c(6,1,4))
A
a <- 2
a
a*A


## create two new matrices and do elementwise subtration
A <- cbind(c(2,5,2),c(6,1,4))
A
B <- cbind(c(-2,3,6),c(8.1,8.2,-9.8))
B
A+B
A-B


## create two new matrices and determin their dimensions
A <- rbind(c(2,5,2),c(6,1,4))
dim(A)
B <- cbind(c(3,-1,1),c(-3,1,5))
dim(B)

## matrix multiply (we will talk about this more later in the semester)
A %*% B

## matrix multiply (we will talk about this more later in the semester)
B %*% A


## create a matrix
A <- matrix(data=c(3,4,1,2),nrow=2,ncol=2)
A

## find the inverse of the matrix
solve(A)

## this creates an identity matrix
A %*% solve(A)



## The matrix generated after the matrix multiplication is the number of rows of the first matrices first dimension (the rows) and the number of columns of the second matrix. But, the length of the second dimension of the first matrix has to be equal to the lenght of the first dimension of the second matrix. See the example code below

mat1 <- matrix(sample(1:10,20,T), nrow=2,ncol=10)
mat2 <- matrix(sample(1:10,10,T), nrow=10, ncol=3)

## check to see if this works
mat1 %*% mat2

## logical tests based on the comment above
ncol(mat1) == nrow(mat2)

nrow(mat1 %*% mat2) == nrow(mat1) | ncol(mat1 %*% mat2) == ncol(mat2)

## note that this doesn't work:
mat2 %*% mat1


