## 2 Nearest neighbour classifier
#
# Here we will find the nearest point in our dataset to a given test point.
#

# load data from csv file
butterflies <- read.csv('data/butterflies.csv')

# plot dataset
plot(butterflies$Height, butterflies$Height, col=butterflies$Species, pch=16, asp=1)

# create new test point
#test_point <- c(3.1, 1.23)
#test_point <- c(6.4, 2.2)
#test_point <- c(4.96, 1.5)
#test_point <- c(2.0, 0.5)
#test_point <- c(6.4, 2.2)
#test_point <- c(4.3, 1.8)

# random test point
test_point <- runif(2, 0,1)
test_point[1] <- min(butterflies[,1]) + test_point[1]*(max(butterflies[,1]) - min(butterflies[,1]))
test_point[2] <- min(butterflies[,2]) + test_point[2]*(max(butterflies[,2]) - min(butterflies[,2]))

# print test point values
print(paste("Test Width: ", test_point[1]))
print(paste("Test Height: ", test_point[2]))

# compute the distance from the test point to every example in the dataset
distance <- apply(butterflies[,1:2],1,function(x)sqrt(sum((x-test_point)^2)))

# find the point in the dataset that is closest to the test point and record its distance
closest_point <- which.min(distance)
distance_to_closest <- min(distance)
print(paste("Distance to closest point: ", distance_to_closest))

# assume the test point is the same class as the datapoint it is closest too
predicted_species <- butterflies[closest_point, ]$Species
print(paste("Predicted species: ", predicted_species))

# plot the test point as an X
points(test_point[1], test_point[2], pch=4, cex=2)

# plot a ring around the nearest datapoint
points(butterflies[closest_point, 1], butterflies[closest_point, 2], pch=1, cex=1.5)

# insert legend
legend_text <- c(levels(butterflies$Species), 'test point', 'nearest training point')
legend(x='topleft', legend=legend_text, col=c(1, 2, 3, 1, 1), pch=c(16, 16, 16, 4, 1))
