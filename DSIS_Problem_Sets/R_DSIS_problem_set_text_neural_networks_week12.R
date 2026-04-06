## R_DSIS_problem_set_text_neural_networks_week12.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## CODE CREATED BY: TYLER RONGXUAN CHEN (tylercr@umich.edu)
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2026
##
## Week 12
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Instructions:
##
## This is an optional problem set that covers material in Matloff Ch.11
## (String Manipulation) and the Week 12 lessons on text as data,
## document-by-term matrices, and neural networks.
## Please feel free to try any or all of the questions.
## I am happy to go over each question with you individually during office hours.
##
##
##########################################################################
## Problem 1: String Manipulation with Regular Expressions
##########################################################################
## (1a) create a character vector called my_text with the following 5 elements:
##      "The government restricted freedom of speech."
##      "Elections were held freely and fairly."
##      "Torture was reported by multiple sources."
##      "The country improved its human rights record."
##      "Authorities detained political opposition leaders."

## (1b) use grepl() to create a logical vector that is TRUE for any element that contains the pattern "freedom"
## (1c) use grep() to return the coordinate position(s) of the element(s) that contain "freedom"
## (1d) use grep() to return the coordinate position(s) of the element(s) that contain "the" (note the lowercase)
##      now try with ignore.case=TRUE -- what changes?

## (1e) use gsub() to remove all punctuation from my_text
##      hint: gsub("[[:punct:]]", "", my_text)
## (1f) use tolower() to convert my_text to all lowercase
## (1g) use strsplit() to split the first element of my_text into individual words by splitting on " "
##      how many words are in the first element? use length() on the result


##########################################################################
## Problem 2: Building a Document-by-Term Matrix by Hand
##########################################################################
## use the my_text vector from Problem 1

## (2a) clean the text: remove punctuation with gsub() and convert to lowercase with tolower()
##      store the result as clean_text

## (2b) split each element of clean_text into words using strsplit(clean_text, " ")
##      store the result as word_list (this will be a list object)

## (2c) use unlist() to create one long vector of all the words
##      then use unique() to find all the unique terms
##      how many unique terms are there?

## (2d) use table() on the unlisted vector of all words to see the frequency of each word across all documents

## (2e) now build the DTM:
##      create an empty matrix with nrow = length(my_text) and ncol = length(unique_terms)
##      set the column names to the unique_terms vector
##      write a for loop over documents (i in 1:length(word_list)):
##        use table(word_list[[i]]) to get the word counts for document i
##        for each word in the table, fill in the corresponding cell of the matrix
##      print the DTM -- each row is a document and each column is a term

## (2f) use colSums() to find the total frequency of each term across all documents
##      which term appears most frequently?


##########################################################################
## Problem 3: Removing Stopwords
##########################################################################
## (3a) create a vector of stopwords:
##      stopwords <- c("the", "a", "an", "and", "of", "in", "to", "for",
##                     "by", "on", "with", "its", "were", "was", "is", "are")

## (3b) use the %in% operator and the ! (not) operator to remove stopwords from each element of word_list
##      hint: for each element i, keep only words NOT in the stopwords vector:
##      word_list[[i]][! word_list[[i]] %in% stopwords]
##      use a for loop or lapply() to do this for every document

## (3c) rebuild the unique terms vector and the DTM after removing stopwords
##      how did the number of unique terms change?

## (3d) print the new DTM -- is it easier to see which terms are meaningful now?


##########################################################################
## Problem 4: Document-by-Term Matrix with the tm Package
##########################################################################
## (4a) load the tm library: library(tm)
## (4b) create a corpus object from my_text using:
##      corpus <- Corpus(VectorSource(my_text))
## (4c) apply the following transformations using tm_map():
##      corpus <- tm_map(corpus, removePunctuation)
##      corpus <- tm_map(corpus, tolower)
##      corpus <- tm_map(corpus, removeWords, stopwords("english"))
##      corpus <- tm_map(corpus, stripWhitespace)
## (4d) create the DTM using: DTM <- DocumentTermMatrix(corpus)
## (4e) inspect the DTM using: inspect(DTM)
## (4f) convert the DTM to a regular matrix using as.matrix(DTM) and compare it to the DTM you built by hand in Problem 3


##########################################################################
## Problem 5: Working with the SIMpoliticalTweets Data
##########################################################################
## (5a) read in the simulated tweet data using:
##      tweets <- readLines("Datasets/SIMpoliticalTweets.txt", n=-1)
##      print the tweets to screen

## (5b) use grepl() and as.numeric() to create binary variables for whether each tweet contains:
##      "obama", "love", "hate"
##      store each as a separate vector

## (5c) use cbind() to combine the three binary vectors into a matrix
##      this is a simple document-by-term matrix with just three terms

## (5d) use table() to cross-tabulate the "obama" variable with the "love" variable
##      and then cross-tabulate "obama" with "hate"
##      what do you observe?

## (5e) now build a full DTM from the tweets following the approach from the lesson:
##      clean the text with gsub() and tolower()
##      split into words with strsplit()
##      remove stopwords (load stopwords from "Datasets/stopwords_twitter.txt" using read.delim())
##      use table() inside a for loop or lapply() to build the data.list
##      use do.call("rbind", data.list) and xtabs() to create the DTM
##      print the dimensions of the DTM


##########################################################################
## Problem 6: Introduction to Neural Networks (advanced)
##########################################################################
## We will build a tiny single-layer neural network from scratch in base R
## to classify our 5 documents from Problem 1 as "negative" (0) or "positive" (1).

## (6a) create a label vector for the 5 documents:
##      y <- c(0, 1, 0, 1, 0)
##      where 0 = negative and 1 = positive

## (6b) use the DTM from Problem 3 (after stopword removal) as the feature matrix X
##      make sure it is a numeric matrix with as.matrix()

## (6c) define the sigmoid activation function:
##      sigmoid <- function(z) { 1 / (1 + exp(-z)) }
##      test it: sigmoid(0) should return 0.5
##      test it: what does sigmoid(100) return? what about sigmoid(-100)?

## (6d) initialize the weights and bias:
##      set.seed(123)
##      W <- matrix(rnorm(ncol(X), sd=0.01), nrow=ncol(X), ncol=1)
##      b <- 0
##      learning_rate <- 0.5

## (6e) write a for loop over 1000 epochs that does the following:
##      Forward pass:
##        z <- X %*% W + b
##        y_hat <- sigmoid(z)
##      Compute loss (binary cross-entropy):
##        loss <- -mean(y * log(y_hat + 1e-8) + (1 - y) * log(1 - y_hat + 1e-8))
##      Backward pass (compute gradients):
##        error <- y_hat - y
##        dW <- (1/nrow(X)) * t(X) %*% error
##        db <- mean(error)
##      Update weights:
##        W <- W - learning_rate * dW
##        b <- b - learning_rate * db
##      Every 200 epochs, print the epoch number and the loss using cat()

## (6f) after training, compute predicted classes by thresholding y_hat at 0.5:
##      predicted <- ifelse(y_hat >= 0.5, 1, 0)
##      use table(predicted, y) to create a confusion matrix
##      how many documents did the network correctly classify?

## (6g) THINK ABOUT IT: this single-layer neural network with a sigmoid activation
##      is equivalent to what classical statistical model?
##      what would adding a hidden layer allow the network to learn that this model cannot?


##########################################################################
## Problem 7: Neural Networks with the nnet Package (optional)
##########################################################################
## (7a) install and load the nnet package: library(nnet)
## (7b) use the nnet() function to fit a neural network with 1 hidden layer of 5 units:
##      nn_fit <- nnet(X, y, size=5, linout=FALSE, maxit=1000)
## (7c) use predict() to get the predicted probabilities and classify at 0.5
## (7d) compare the predictions from nnet to the predictions from your hand-coded network in Problem 6

