## R_DSIS_week12_text_as_data_DTM_tm_package.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2022, Winter 2021, Winter 2020
##
## Week 12
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## Use the tm package to reproduce the DTM 
##
## (3) Text as data is represented as a high-dimensional, sparse feature vector where the elements of the vector are the frequencies of specific words and phrases in the document.
##
## (4) For the DTM, we let i = 1, ..., N index documents and w = 1, ..., W index the unique terms in the collection of documents. 
## For each of the i documents, we determine the frequency of each of the unique $w$ words. 
## Each of the D_iw entries in a DTM represents  the number of times the w-th word appears in the i-th document.
##
##########################################################################

## load libraries
library(stm)
library(tm)
library(SnowballC)
library(dslabs)

## load data
data <- read.csv("DSIS_Data/SIMpoliticalTweets.txt", header=FALSE)
data
names(data) <- "text"
data

#trumptweets <- fromJSON("trump_json_files_20190707.txt")
#data <- trumptweets

##
##data <- data[1:1000,]

## create character vector for processing
newtext <- as.character(data$text)
length(newtext)


## use gsub to remove special characters that usually cause errors if left for later
newtext <- gsub("[^0-9A-Za-z///' ]", "", newtext)
newtext <-  gsub("[^[:alnum:]///' ]", "", newtext)
newtext <- gsub("[^\x20-\x7F\x0D\x0A]", "", newtext) # remove all non-ascii characters
newtext <- gsub("http.*", "", newtext) # replace all of the urls
newtext <- gsub("www.*", "", newtext) #

## data$newtext
data$newtext <- newtext

## convert to corpus object using additional functions from the tm package
## the tm_map function takes as its first argument the vector of text and a function as its second argument
corpus <-Corpus(VectorSource(newtext))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stemDocument)

## print to screen
inspect(corpus[1:10])


## make document by term matrix
DTM <- DocumentTermMatrix(corpus)
DTM


## print DTM to screen using the inspect() function
inspect(DTM)
inspect(DTM[1:10,1:25])

