## 5 Pixel classification
#
# In this example we will classify the pixels in an image as being either 'land'
# or 'other'. We will use the pixel values as features to our classifier.
# 
# Have a look at the image data/uk_ire_gray.png to see the input image.
#

# define a function we will use later to flip the images when displaying them
flip_image <- function(m) t(m)[,nrow(m):1]

# load random forest package for classification 
library(randomForest)

# load the grayscale image we wish to classify from its csv file
# 0 represents black and 255 represents white
im <-read.csv('data/uk_ire_gray.csv', header=FALSE)
height <- nrow(im)
width <- ncol(im)
print(paste("Height in pixels: ", height))
print(paste("Width in pixels: ", width))
 
# create training data as DataFrame
# pick some pixel locations in screen space that we know to be land and not land
train_x <- c(0.75, 0.30, 0.20, 0.95, 0.75)
train_y <- c(0.20, 0.50, 0.70, 0.40, 0.95)
class_names <- c('land', 'land', 'other', 'other', 'other') 

# plot the input image
# note, we need to transpose and flip the images to dislay them
par(mfrow=c(1,2))
image(flip_image(im), col=gray.colors(255))
title('input aerial image')

# plot the training datapoints as coloured circles
points(train_x[class_names=='land'], train_y[class_names=='land'], pch=16, col='green')
points(train_x[class_names=='other'], train_y[class_names=='other'], pch=16, col='blue')

# here we extract the pixel values at our training locations
# we need to scale the training points so they are in the correct units
# we also take the negative of the y values because of flipping when the image is displayed
train_pixels <- im[cbind(height-round(train_y*height), round(train_x*width))]
train_data <- data.frame(pixel_values=train_pixels, class_names)

# train classifer
rf <- randomForest(class_names ~ ., train_data, ntree=20)

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

# plot the prediction as a new image on the right
image(flip_image(prob_land_matrix>0.5), col=gray.colors(255))
title('land prediction')

# compute the percentage of pixels that are predicted as land
percent_land_cover <- sum(prob_land_matrix>0.5) / (width*height)
print(paste("Predicted percentage of land pixels: ", 100*percent_land_cover))
