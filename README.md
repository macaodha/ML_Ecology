# Machine Learning for Ecologists
R Code for Introduction to Machine Learning Class at UCL

## Slides
Associated slides for the course can be found [here](http://www0.cs.ucl.ac.uk/staff/O.MacAodha/ml_intro/).

## Code
#### 1 Plotting
Loading a data set from a .csv file and plotting it. 

#### 2 Nearest Neighbour Classification
Simple supervised classification. 

#### 3 Classification 
Splitting the data into training and validation sets, performing classification using a Random Forest, and reporting classification accuracy.  

#### 4 Regression
Comparison of linear and non linear regression on a non linear dataset. 

#### 5 Pixel Classification in Images
Loading an aerial image and predicting if each pixel represents 'land' or 'other'.
![alt text](https://github.com/macaodha/ML_Ecology/blob/master/5_pixel_classification_result.png "5 Pixel Classification Result")


## Required R Packages
We make use of the *randomForest* package in R. To install it, type the following command into the R console:
```
install.packages('randomForest', repos='http://cran.us.r-project.org')
