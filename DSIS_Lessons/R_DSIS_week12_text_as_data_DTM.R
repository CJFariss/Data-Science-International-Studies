## R_DSIS_week12_text_as_data_DTM.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
##
## Week 12
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## (3) Text as data is represented as a high-dimensional, sparse feature vector where the elements of the vector are the frequencies of specific words and phrases in the document.
##
## (4) For the DTM, we let i = 1, ..., N index documents and w = 1, ..., W index the unique terms in the collection of documents. 
## For each of the i documents, we determine the frequency of each of the unique $w$ words. 
## Each of the D_iw entries in a DTM represents  the number of times the w-th word appears in the i-th document.
##
##########################################################################

## load data
data <- read.csv("DSIS_Data/SIMpoliticalTweets.txt", header=FALSE)
data
names(data) <- "text"
data

## Warning: this is a larger file so takes a bit longer to run on most laptops
#trumptweets <- fromJSON("trump_json_files_20190707.txt")
#data <- trumptweets

## check first 6 rows of data
head(data)

## load stop words to remove from text (these are very common words)
stopwords <- read.delim("DSIS_Data/stopwords_twitter.txt", header=FALSE)
head(stopwords)

## define a function to remove some characters using the gsub() function
textEdit <- function(text.vector){
  TEXT <- text.vector
  ## ----- remove stuff ---------- #
  TEXT <- gsub("http:.*$", "", TEXT) # replace just the urls/http/www part
  TEXT <- gsub("https:.*$", "", TEXT) # replace just the urls/http/www part
  TEXT <- gsub("www.*$", "", TEXT) #
  TEXT <- gsub("http:.*", "", TEXT) # replace all of the urls
  TEXT <- gsub("https:.*", "", TEXT) # replace all of the urls
  TEXT <- gsub("www.*", "", TEXT) #
  TEXT <- gsub("[[:punct:]]", "", TEXT) # remove all punctuation
  TEXT <- gsub("[^\x20-\x7F\x0D\x0A]", "", TEXT) # remove all non-ascii characters
  TEXT <- gsub("[0-9]", "", TEXT) # remove numbers
  TEXT <- gsub("^\\s+|\\s+$", "", TEXT) # remove extra leading and trailing whitespace
  TEXT <- tolower(TEXT) # turn all letters lower case
  ## ----- function return ---------- #
  return(TEXT)
} ## end function


## use textEdit function to process text
newtext <- textEdit(as.character(data$text))
head(newtext)


## create list object
## each element is a tweet
## within each element are each of terms used in the tweet
tweet.term.list <- strsplit(newtext, split=" ")
tweet.term.list

table(tweet.term.list[[1]])

## are the numbers 1 and 2 in the second vector using the %in% function.
c(1,2) %in% c(0,3)

c(1,2) %in% c(1,2,3)

c(1,2,4,5,6) %in% c(1,2,3)

c("a") %in% c("a", "b", "c")

letters %in% c("a", "b", "c")

## view logical sub-setting command to remove stop-words from the first tweet
tweet.term.list[[1]] %in% as.character(stopwords$V1)

## remove stopwords with not ! symbol for first elemnet in list of words (! flips FALSE to TRUE and TRUE to FALSE)
! FALSE

tweet.term.list[[1]][ ! tweet.term.list[[1]] %in% as.character(stopwords$V1) ]


## loop through elements of loop and remove stop words from each tweet
for(i in 1:length(tweet.term.list)){
  tweet.term.list[[i]] <- tweet.term.list[[i]][! tweet.term.list[[i]] %in% as.character(stopwords$V1) ]
}
tweet.term.list


## instead of using a loop, use the lapply function to accomplish the same task as the for loop above
tweet.term.list <- lapply(1:length(tweet.term.list), function(i){
  value <- tweet.term.list[[i]][! tweet.term.list[[i]] %in% as.character(stopwords$V1) ]
  return(value)
})
tweet.term.list

## take the unique terms that remain in the full list of tweets after revmoing stop words
unique.terms <- unique(unlist(tweet.term.list))

## print to screen the total length of the unique term vector
length(unique.terms)

## print to screen the first 6 terms from the unique.terms object
head(unique.terms)
unique.terms



## set time start variable
time1 <- Sys.time()
print(Sys.time() - time1)

## create temporary dataset to append one term dataset per tween
## each term dataset is appended to the one before creating a long data stucture
## the units or records in this dataset are tweet-terms
## each record is the document-term combination


data.list <- list()

## this for loop takes a long time if the number of documents is large
for(i in 1:nrow(data)){
  ## test to make sure there is at least one term in the tweet
  if(length(tweet.term.list[[i]])!=0){
    data.list[[i]] <- data.frame(Doc=i, as.data.frame(table(tweet.term.list[[i]])))
  }
  
  ## if there are not terms in the tweet than return NA values
  else{
    data.list[[i]] <- data.frame(Doc=i, Var1=NA, Freq=NA)
  }
  
}

data.list[[1]]

data.list

## create dataframe from the first dataframe in the data.list object
newdata <- data.list[[1]]
newdata

## row bind each additional dataset from data.list to the newdata object
for(i in 2:length(data.list)){
  newdata <- rbind(newdata, data.list[[i]])
}

newdata

## the do.call() does the same as the for loop structure above
## do.call() takes a list as the second argument (which is weird) and applies to function name in quotes to each element (this setup looks a bit strange compared to other functions we have seen before)
newdata <- do.call("rbind", data.list)
newdata


## create matrix of documents by terms with xtabs() function
DTM <- xtabs(Freq ~ Doc + Var1, data=newdata)
DTM

## print dimensions of the DTM
dim(DTM)


## inspect the frequency of terms (columns) for each document (rows)
DTM
#DTM[1:5,1:25] ## inspect the frequency of terms for 25 terms in the first 5 tweets


## calculate total calculation time for the loop version
print(Sys.time() - time1)




# set time start variable
time1 <- Sys.time()
print(Sys.time() - time1)


# for each j document, get the vector of terms seperated by white space
# use the table() function to determine the frequency of each term
# transform the table of frequencies into a datafram with j document indicator

data.list <- lapply(1:length(tweet.term.list), function(i) {
  if(length(tweet.term.list[[i]])!=0){
    value <- data.frame(Doc=i, as.data.frame(table(tweet.term.list[[i]])))
  }
  else{
    value <- data.frame(Doc=i, Var1=NA, Freq=NA)
  }
  return(value)
})

# rbind the list of data.frames together
newdata <- do.call("rbind", data.list)

## create matrix of documents by terms with xtabs() function
DTM <- xtabs(Freq ~ Doc + Var1, data=newdata)

## print dimensions of the DTM
dim(DTM)


## inspect the frequency of terms (columns) for each document (rows)
DTM
##DTM[1:5,1:25] ## inspect the frequency of terms for 25 terms in the first 5 tweets


## calculate total calculation time for the lapply() version
print(Sys.time() - time1)



