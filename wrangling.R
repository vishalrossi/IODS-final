# Course: Final project for Open Data Science, spring 2017
# Author: Vishal Sinha
# Date: 05 March 2017
# Exercise: Data wrangling
# File: Student alcohol consumption

### Load all the libraries required for the analysis
library(ggplot2)
library("GGally")
library(corrplot)
library(dplyr)

### Read the data
data = read.csv("/Users/vsinha/IODS-final/2015.csv", header = T)

### Explore the data
dim(data)
str(data)
summary(data)

### Reanme columns
colnames(data)
colnames(data) = c("Country","Region","Rank","Score","Error","GDP","Family","Age","Freedom","Trust","Generous","Dystopia")

### Create data for correlation 
keep_columns <- c("Country","Rank","Score","Error","GDP","Family","Age","Freedom","Trust","Generous","Dystopia")
corr_data <- select(data, one_of(keep_columns))
corr_final_data <- corr_data[,-1]
rownames(corr_final_data) <- corr_data[,1]
write.table(corr_final_data, file="/Users/vsinha/IODS-final/corr_final_data", sep = "\t")

### Create data for PCA
keep_columns <- c("Score","Error","GDP","Family","Age","Freedom","Trust","Generous","Dystopia")
pca_data <- select(corr_final_data, one_of(keep_columns))
write.table(pca_data, file="/Users/vsinha/IODS-final/pca_data", sep = "\t")