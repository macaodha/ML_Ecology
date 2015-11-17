# load Random Forest library - used for classification 
library(randomForest)

# load image and convert to a matrix
# here the image is stored in blacka and white in a csv file 
# 0 represents black and 255 represents white
im <-read.csv('uk_ire_gray.csv', header=FALSE)
im_matrix <- as.matrix(im)

# plot image
image(im_matrix, col=gray.colors(255))
 
# create training data as DataFrame
pixel_values <- c(41, 60, 80, 0, 20, 40, 81, 100, 200)
class_names <- c( 'land', 'land', 'land', 'other', 'other', 'other', 'other', 'other', 'other') 
train_data <- data.frame(pixel_values, class_names)

# train classifer
rf <- randomForest(class_names ~ ., data = train_data)

# create test data
pixel_values <- as.vector(im_matrix)
test_data <- data.frame(pixel_values)

# perform classification
im_prediction <- predict(rf, newdata = test_data, type = 'prob') 
print(head(im_prediction))

# convert back to matrix
im_prediction_matrix <- matrix(im_prediction[,1], nrow = nrow(im_matrix), ncol = ncol(im_matrix))

# display result
#image(im_prediction_matrix, col=gray.colors(255))
image(im_prediction_matrix > 0.5, col=gray.colors(255))


