## Here we will load in some data and plot it

# load data from csv file
flower_data <- read.csv('iris_subset.csv')

# column names
print(names(flower_data))

# number of rows
print(nrow(flower_data))

# first few examples
print(head(flower_data))

# plot the first two dimensions
plot(flower_data$Petal_Length, flower_data$Petal_Width)

# plot the Species type in color
# pch is the format of the plotted circles - here filled circles
plot(flower_data$Petal_Length, flower_data$Petal_Width, pch=21, bg=c("red","green","blue")[unclass(flower_data$Species)])
