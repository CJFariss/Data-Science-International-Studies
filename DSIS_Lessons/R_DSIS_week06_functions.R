## R_DSIS_week06_functions.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
##
## Week 6
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
## (3) use the missing() function to determine if a user-supplied argument is missing in the function 
## (4) review lots of familiar function examples
## (5) recursive functions (we will consider this in week 7)
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
## let's make some functions that actually return something of use
##########################################################################

## define a function to create an object out of the value given to it as its argument
## this is a one-to-one mapping function
one_to_one_mapping <- function(value){
    return(value)
}
one_to_one_mapping


one_to_one_mapping(1)
one_to_one_mapping(2)
one_to_one_mapping("this may be dumb")
one_to_one_mapping(TRUE)
one_to_one_mapping("Hello world!")

one_to_one_mapping(1:10)

obj1 <- one_to_one_mapping(1)
obj1

##########################################################################
## Notes:
## This function is probably not that useful but it illustrates an important concept for functions
## Important concept: functions take input and return output.
## In this example the input and the output are the same
##########################################################################


input_ouput_func <- function(input){
    
    ## use the input object to create the output object
    ## note here that the output object is dependent on the value of the input object
    output <- input
    
    ## return the output object
    return(output)
}
input_ouput_func

input_ouput_func("stuff")
input_ouput_func(1)
input_ouput_func(2)


## This simple function can take a more complex object and return it
## This will come in handy later on, see especially the program challenges
one_to_one_mapping(list(2,TRUE,"message in a list, which is kind of like a message in a bottle"))


##########################################################################
## more function examples
##########################################################################

## define a function for addition of two numbers
## the arguments a and b should be numeric scalars or vectors
add_numbers <- function(a,b){
    a+b
}
add_numbers
add_numbers(1,2)

## this function and the version above will both return a+b
## explicitly defining the object to return is good programming practice so we will build on this version from here on out
add_numbers <- function(a,b){
    return(a+b)
}

## print the function definition to the screen
add_numbers

add_numbers(2,2)

add_numbers(a=2,b=2)

add_numbers(2,1:10)


## a and b are arguments that allow the user of the function to supply two input values into the function, which returns one output value
add_numbers <- function(a,b){
    output <- a+b
    return(output)
}

add_numbers(1,4)


## define a function to add or subtract two numbers
add_numbers <- function(a,b,sign){
    if(sign=="+"){
        return(a+b)
    }
    
    if(sign=="-"){
        return(a-b)
    }
}
add_numbers

add_numbers(2,2, sign="+")
add_numbers(2,2, sign="-")


## if one of the arguments is missing, an error will occur
add_numbers(2,2)

## there are a couple of options, make sure to supply all the necessary arguments of add additional checks in the function to deal with specific situations as they arrise

## define a function to add or subtract two numbers with a warning for the sign argument
add_numbers <- function(a,b,sign){
    if(missing(sign)) return("WARNING: missing sign argument") ## print a warning
    if(sign=="+") return(a+b)
    if(sign=="-") return(a-b)
}

## call the function
add_numbers(2,2)

add_numbers(2,2, sign="+")

## define a function to add or subtract two numbers with a warning for the sign argument
add_numbers <- function(a,b,sign){
    if(missing(sign)){
        print("warning: missing sign argument, set to + by default") ## print a warning
        sign <- "+"
    }
    if(sign=="+") return(a+b)
    if(sign=="-") return(a-b)
}

## call the function
add_numbers(2,2)

add_numbers(2,2,sign="-")


## a and b are arguments are assigned default values
add_numbers <- function(a=3,b=5){
  output <- a+b
  return(output)
}

add_numbers()
add_numbers(4,6)


##########################################################################
## let's look back as some function examples we may have already seen
##########################################################################



##########################################################################
## create a function that returns the same values as the code above
## see the R_DSIS_Challenge_vector_matrix_distances_answer.R for more details about this function
##########################################################################
vector_distance <- function(len, coordinate_position){
    
    vec <- rep(NA, len)
    coordinates <- 1:length(vec)
    distance <- sqrt((coordinate_position - coordinates)^2)
    return(distance)
}

## call the function
vector_distance(5,4)

## call the function with a longer vector but the same position
vector_distance(10,4)

## call the function with the same length vector as above but a different position
vector_distance(10,7)

vector_distance(100,7)






## practice reverse coding the function

## these are the arguments for the function defined above

len <- 10
coordinate_position <- 4

vec <- rep(NA, len)
coordinates <- 1:length(vec)
distance <- sqrt((coordinate_position - coordinates)^2)
distance




##########################################################################
## define the function with one argument (vector is the user defined vector myvec from above)
## see R_DSIS_Challenge_1max_2max_3max_nmax_answer.R for more details about this function
##########################################################################
my_vector_sort <- function(vector){
    
    ## same as above but specified in the function call
    myvec <- vector
    
    ## same as above but inside the function now
    max_locations <- which(myvec==max(myvec))
    
    ## same as above but inside the function now
    for( i in 2:length(unique(myvec))){
        max_locations <- c(max_locations, which(myvec==max(myvec[-max_locations], na.rm=TRUE)))
    }
    
    ## inside the function we need to specify which value it returns
    #return(myvec[max_locations])
    
    ## return the coordinates instead
    return(max_locations)
}
## end of the function definition

## call the function
my_vector_sort(vector=c(1,2,800,4,5))


my_vector_sort(c(1,2))



## same as above but specified in the function call
myvec <- c(1,500,3,2,0,-1,800,500)
myvec

## same as above but inside the function now
max_locations <- which(myvec==max(myvec))
max_locations

## same as above but inside the function now
for( i in 2:length(unique(myvec))){
  max_locations <- c(max_locations, which(myvec==max(myvec[-max_locations], na.rm=TRUE)))
}
max_locations
myvec[max_locations]


myvec <- c(1,500,3,2,0,-1,800,500)
myvec
max_locations <- which(myvec==max(myvec))
max_locations
max_locations <- c(max_locations, which(myvec==max(myvec[-max_locations], na.rm=TRUE)))
max_locations
max_locations <- c(max_locations, which(myvec==max(myvec[-max_locations], na.rm=TRUE)))
max_locations
max_locations <- c(max_locations, which(myvec==max(myvec[-max_locations], na.rm=TRUE)))
max_locations
max_locations <- c(max_locations, which(myvec==max(myvec[-max_locations], na.rm=TRUE)))
max_locations
max_locations <- c(max_locations, which(myvec==max(myvec[-max_locations], na.rm=TRUE)))
max_locations
max_locations <- c(max_locations, which(myvec==max(myvec[-max_locations], na.rm=TRUE)))
max_locations
max_locations <- c(max_locations, which(myvec==max(myvec[-max_locations], na.rm=TRUE)))
max_locations

##########################################################################
## see R_DSIS_Challenge_shuffle_index_answer.R for more details about this function
##########################################################################

## define the shuffle function
shuffle <- function(vector, times){
    
    ## set the user specificed vector to a local variable called shuffle_vector
    shuffle_vector <- vector
    
    ## cut_point calcuation
    ## this is just the value at the midpoint in the vector (we want equal sized halves of the deck of cards)
    cut_point <- round(length(shuffle_vector)/2)
    cut_point
    
    ## the for loop iterates based on the number in the times argument supplied by the user
    for(i in 1:times){
        
        ## take the current version of the shuffle_vector and cut it into top and bottom halves
        top <- shuffle_vector[1:cut_point]
        bottom <- shuffle_vector[(cut_point+1):length(shuffle_vector)]
        
        ## alternate which half is the top/bottom half so that the first and last position move through the shuffle too
        if(i%%2==TRUE){
            shuffle_vector <- rbind(top, bottom)
        }
        else{
            shuffle_vector <- rbind(bottom, top)
            
        }
        
        ## do the shuffle
        shuffle_vector <- c(shuffle_vector)
        
    }
    
    ## return the shuffled vector
    return(shuffle_vector)
}


shuffle(1:10, 1)
shuffle(1:10, 2)
shuffle(1:10, 7)




shuffle_vector <- 1:10

## cut_point calcuation
## this is just the value at the midpoint in the vector (we want equal sized halves of the deck of cards)
cut_point <- round(length(shuffle_vector)/2)
cut_point


## the for loop iterates based on the number in the times argument supplied by the user
times <- 2
for(i in 1:times){
  
  ## take the current version of the shuffle_vector and cut it into top and bottom halves
  top <- shuffle_vector[1:cut_point]
  bottom <- shuffle_vector[(cut_point+1):length(shuffle_vector)]
  
  top
  bottom
  
  ## alternate which half is the top/bottom half so that the first and last position move through the shuffle too
  i <- 1
  if(i%%2==TRUE){
    shuffle_vector <- rbind(top, bottom)
  }
  else{
    shuffle_vector <- rbind(bottom, top)
    
  }
  
  ## do the shuffle
  shuffle_vector <- c(shuffle_vector)
  
}

## return the shuffled vector
shuffle_vector

shuffle(1:10, 2)


##########################################################################
## see R_DSIS_Challenge_matrix_exploration.R for more details about this function
##########################################################################

myfunc <- function(user_dims){
    
    temp <- array(NA, dim=user_dims)
    
    even_coords_dim1 <- seq(2,dim(temp)[1],2)
    even_coords_dim2 <- seq(2,dim(temp)[2],2)
    even_coords_dim3 <- seq(2,dim(temp)[3],2)
    value <- length(temp[even_coords_dim1,even_coords_dim2,even_coords_dim3])/length(temp)
    return(value)
}


myfunc(user_dims=c(4,4,4))
myfunc(user_dims=c(8,8,8))
myfunc(user_dims=c(7,11,6))

myfunc(user_dims=c(16,12,8))


user_dims <- c(4,4,8)
user_dims

temp <- array(NA, dim=user_dims)
temp

even_coords_dim1 <- seq(2,dim(temp)[1],2)
even_coords_dim2 <- seq(2,dim(temp)[2],2)
even_coords_dim3 <- seq(2,dim(temp)[3],2)

even_coords_dim1
even_coords_dim2
even_coords_dim3

value <- length(temp[even_coords_dim1,even_coords_dim2,even_coords_dim3])/length(temp)
value



