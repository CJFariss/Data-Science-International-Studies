## R_DSIS_week16_keras_MNIST_example.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2026, Winter 2025, Fall 2023, Winter 2023, Winter 2022, Winter 2021, Winter 2020
##
## Week 12
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## Fit and evaluate a neural network model to the MNIST hand written digit dataset.
##
## https://keras.rstudio.com/index.html
## https://keras.rstudio.com/articles/faq.html
## https://keras.io/losses/
## https://cran.r-project.org/web/packages/keras/keras.pdf
## https://cran.rstudio.com/web/packages/keras/vignettes/sequential_model.html
##
##########################################################################


## load package
install.packages("keras")
library(keras)

## load the dataset from the keras package
mnist <- dataset_mnist()

## examine the list object
names(mnist)
names(mnist$train)
names(mnist$test)

## make dataframes from the list
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y

## The x data is a 3D array (images,width,height) of grayscale values.
##
## To prepare the data for training, convert the 3D arrays into matrices by reshaping width and height into a single dimension (28x28 images are flattened into length 784 vectors).
##
## Then, convert the grayscale values from integers ranging between 0 to 255 into floating point values ranging between 0 and 1

## reshape
dim(x_train)
dim(x_test)

dim(x_train) <- c(nrow(x_train), 784)
dim(x_test) <- c(nrow(x_test), 784)

dim(x_train)
dim(x_test)

## rescale
x_train <- x_train / 255
x_test <- x_test / 255

## use a keras function to change the dependent variable (target variable) to categorical
y_train <- to_categorical(y_train, 10)
y_test <- to_categorical(y_test, 10)


head(y_train)
head(y_test)

## The core data structure of Keras is a model, which denotes the organization of layers and nodes. 
## There are many types of layers.
##
## The simplest type of model is feed forward neural network, which is a sequential model with linear relationship between the elements.
##
## Each layer is defined using layer_dense() function, which takes as input the number of neurons or units (which are linear transformations from the previous layer) that we want to use.
##
## layer_dense() also takes the input shape which is what the data structure in the training and test set is.
##
## Since we are using a dataframe, we just need to tell the function how long the row is (i.e., the number of columns), which is 784.
##
## We then specify how we will transform the nodes in the layer. We can just use a linear transformation, which is 1 to 1. We can also use other transformations if we want (e.g., rectified linear unit (ReLU)).
##
## Each layer is "stacked" together
##
## softmax is the transformation for linear information into un-ordered categories
##
## The sequential model can have many layers and activation functions added to it  using the pipe (%>%) operator:

var <- c()

## model definition
model <- keras_model_sequential()
model %>%
  layer_dense(units = 1, input_shape = c(784)) %>%
  layer_activation("linear") %>%
  layer_dense(units = 10) %>%
  layer_activation("softmax")

## compile the model
model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_rmsprop(),
  metrics = c("accuracy")
)

## graph the model (fit the parameters of the model)
history <- model %>% fit(
  x_train, y_train,
  epochs = 30, batch_size = 128,
  validation_split = 0.2
)

## evaluate the model
model %>% evaluate(x_test, y_test,verbose = 0)



## model definition
model <- keras_model_sequential()
model %>%
  layer_dense(units = 4, input_shape = c(784)) %>%
  layer_activation("linear") %>%
  layer_dense(units = 10) %>%
  layer_activation("softmax")

## compile the model
model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_rmsprop(),
  metrics = c("accuracy")
)

## graph the model (fit the parameters of the model)
history <- model %>% fit(
  x_train, y_train,
  epochs = 30, batch_size = 128,
  validation_split = 0.2
)

## evaluate the model
model %>% evaluate(x_test, y_test,verbose = 0)

## predict 


## alternative versions of the model definition
model <- keras_model_sequential()
model %>%
  layer_dense(units = 256, activation = "relu", input_shape = c(784)) %>%
  layer_dropout(rate = 0.4) %>%
  layer_dense(units = 128, activation = "relu") %>%
  layer_dropout(rate = 0.3) %>%
  layer_dense(units = 10, activation = "softmax")

## compile the model
model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_rmsprop(),
  metrics = c("accuracy")
)

## graph the model
history <- model %>% fit(
  x_train, y_train,
  epochs = 30, batch_size = 128,
  validation_split = 0.2
)

## evaluate the model
model %>% evaluate(x_test, y_test,verbose = 0)

## 
model <- keras_model_sequential()
model %>%
  layer_dense(units = 32, input_shape = c(784)) %>%
  layer_activation('relu') %>%
  layer_dense(units = 10) %>%
  layer_activation('softmax')

## compile the model
model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_rmsprop(),
  metrics = c("accuracy")
)

## graph the model
history <- model %>% fit(
  x_train, y_train,
  epochs = 30, batch_size = 128,
  validation_split = 0.2
)

## evaluate the model
model %>% evaluate(x_test, y_test,verbose = 0)

## generate predictions after model fitting and cross-validation
## https://keras.rstudio.com/reference/predict.keras.engine.training.Model.html
output <- predict(model, x=x_test)

attributes(output)

output[1:5,1:10]
summary(apply(output,1,sum))


##  which max apply

