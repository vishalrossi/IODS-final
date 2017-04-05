# Course: Final project for Open Data Science, spring 2017
# Author: Vishal Sinha
# Date: 05 March 2017
# Exercise: Data wrangling
# File: World happiness report

### Load all the libraries required for the analysis
library(ggplot2)
library(GGally)
library(corrplot)
library(dplyr)

### Read the data
data = read.csv("/Users/vsinha/IODS-final/2016.csv", header = T)

### Explore the data
dim(data)
str(data)
summary(data)

### Reanme columns
colnames(data)
colnames(data) = c("Country","Region","Rank","Score","LowerCI", "UpperCI", "GDP","Family","Age","Freedom","Trust","Generous","Dystopia")

### Calculate  std. error and add to the existinng data
Error = (data$UpperCI-data$LowerCI)/3.92
round_error=round(Error, digits=3)
Error=round_error
new_data=cbind(data, Error)


### Create data for correlation 
keep_columns <- c("Country","Rank","Score","GDP","Family","Age","Freedom","Trust","Generous","Dystopia", "Error")
corr_data <- select(new_data, one_of(keep_columns))
corr_final_data <- corr_data[,-1]
rownames(corr_final_data) <- corr_data[,1]
write.table(corr_final_data, file="/Users/vsinha/IODS-final/corr_final_data", sep = "\t")

### Create data for PCA
keep_columns <- c("Score","GDP","Family","Age","Freedom","Trust","Generous","Dystopia", "Error")
pca_data <- select(corr_final_data, one_of(keep_columns))
write.table(pca_data, file="/Users/vsinha/IODS-final/pca_data", sep = "\t")
