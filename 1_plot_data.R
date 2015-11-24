## 1 Plotting
#
# Here we will load in some data and plot it
# 

# load data from csv file
flower_data <- read.csv('data/flower_dataset.csv')

# column names
print(names(flower_data))

# number of rows
print(paste("Number of datapoints: ", nrow(flower_data)))

# first few examples
print(head(flower_data))

# plot the first two dimensions (ie columns)
plot(flower_data$Petal_Length, flower_data$Petal_Width)

# plot the Species type in color
# pch is the format of the plotted points - here filled circles
# asp is used to make sure that the axis are in the same units
# col sets the colours based on the Species type
plot(flower_data$Petal_Length, flower_data$Petal_Width, col=flower_data$Species, pch=16, asp=1)

# add legend 
legend(x='topleft', legend=levels(flower_data$Species), col=c(1, 2, 3), pch=16)
