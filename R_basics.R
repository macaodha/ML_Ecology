To open the R enviornment from the command line:
R

To run R script (hello_world.R) from command line:
Rscript hello_world.R

To run from inside R:
source('hello_world.R')

To exit the R enviornment:
q()

To view objects in workspace:
objects()

Command lines docs for a function:
help('function_name')

Print text to screen:
print('hi there')

To print with a variable:
print(paste("The number that comes after 1: ", 2.0))

Assignment, use <- set variable (= only has local scope):
aa <- 2
bb <- 1
cc <- aa + bb

Use the hash symbol to comment out a line:
# This line will not do anything

Summarize variable:
summary(aa)

Use c() to combine elements into a list:
my_vec <- c(10.4, 5.6, 3.1, 6.4, 21.7)

Uses 1 based indexing - like MATLAB not Python:
my_vec[1]

Return the number of elements:
length(my_vec)

Functions:
my_function <- function(text_to_print) { 
    print(text_to_print)
    return(2)
}

To call:
ret_value <- my_function('print this')

Load csv into DataFrame:
my_data <- read.csv('data/butterflies.csv')

Get the column names:
names(my_data)

Get the number of rows and columns:
nrow(my_data)
ncol(my_data)

To access a single value, a whole row, or a subset:
my_data[1, 1]
my_data[1,]
my_data[1:2,1:3]

Access a column by name (if there is a space in the name it will be replace by a .):
my_data$Species

Simple plotting:
plot(c(4,5,6))
title('simple plot')

Or 2D:
plot(c(4,5,6), c(1, 1, 2))

To save an open plot to disc:
dev.print(pdf, 'filename.pdf')

Generate random uniform numbers. Here, generate 10 random numbers between 0 and 1:
runif(10, 0,1)

To clear open plots in RStudio
dev.off()

