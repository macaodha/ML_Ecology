## 5 Pixel classification
#
# In this example we will classify the pixels in an image as being either 'land'
# or 'other'. We will use the pixel values as features to our classifier.
# 
# Have a look at the image data/uk_ire_gray.png to see what we are working with.
#

# define a function we will use later to flip the images when displaying them
flip_image <- function(m) t(m)[,nrow(m):1]

# load random forest package for classification 
library(randomForest)

# load the grayscale image we wish to classify from the csv file
# 0 represents black and 255 represents white
im <-read.csv('data/uk_ire_gray.csv', header=FALSE)
height <- nrow(im)
width <- ncol(im)
print(paste("Height in pixels: ", height))
print(paste("Width in pixels: ", width))
 
# create training data as DataFrame
# here we have picked some pixel locations that we know to be land and not land
train_x <- c(63, 158, 35, 32, 35, 187, 153)
train_y <- c(134, 196, 75 ,237, 75, 149, 8)
class_names <- c('land', 'land', 'other', 'other', 'other', 'other', 'other') 

# now we extract the pixel values at these locations
train_pixels <- im[cbind(train_y, train_x)]
train_data <- data.frame(pixel_values=train_pixels, class_names)

# train classifer
rf <- randomForest(class_names ~ ., train_data)

# create test data - convert image dataframe into pixels
test_pixels <- unname(unlist(im))
test_data <- data.frame(pixel_values=test_pixels)

# perform classification on the whole image
# here we will get the random forest to return a probability 
im_prediction <- predict(rf, test_data, type='prob') 
print(head(im_prediction))

# extract the prediction for land - the porbability of the first class
prob_land <- im_prediction[,1]

# convert the prediction from a vector to a matrix
prob_land_matrix <- matrix(prob_land, nrow=nrow(im), ncol=ncol(im))

# plot the input image and result side by side
# Note, we need to transpose and flip the images to dislay them
par(mfrow=c(1,2))
image(flip_image(im), col=gray.colors(255))

# plot the training points as green dots
points(train_x/width, 1-train_y/height, pch=16, col=3)
title('input aerial image')

# plot the prediction
image(flip_image(prob_land_matrix>0.5), col=gray.colors(255))
title('land prediction')

# compute the percentage of pixels that are predicted as land
percent_land_cover <- sum(prob_land_matrix>0.5) / length(prob_land_matrix)
print(paste("Predicted percentage of land pixels: ", 100*percent_land_cover))
