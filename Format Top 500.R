# Format Top 500.R
# Script that formats the Top 500 ptivate companies from the AFR
# Created by Aja Manu on 06/09/2018

# Load Libraries
library(tidyverse) # workign with data

#### Load Data------------------------------------------------------------------
raw_data <- read.csv("./Data/Top 500 2018.csv", header = FALSE)

#### Reshape Data---------------------------------------------------------------
# Get columns from the data
company <- as.data.frame(raw_data[seq(1, nrow(raw_data), 5), ]) # get every 5th row
names(company) <- "company"

industry <- as.data.frame(raw_data[seq(2, nrow(raw_data), 5), ]) # get every 5th row
names(industry) <- "industry"

revenue <- as.data.frame(raw_data[seq(4, nrow(raw_data), 5), ]) # get every 5th row
names(revenue) <- "revenue"

growth <- as.data.frame(raw_data[seq(5, nrow(raw_data), 5), ]) # get every 5th row
names(growth) <- "growth"

#### Combine Data---------------------------------------------------------------
# Cbind data
data <- cbind(company, industry, revenue, growth)

### Clean-up Data---------------------------------------------------------------
# remove Revenue YoY change (%) from 
data$growth <- gsub("[[:alpha:]]", "", as.character(data$growth)) # remove letters
data$growth <- gsub("\\(|\\)|%", "", as.character(data$growth)) # remove punctuation

# Add rank
data$rank <- seq(1, nrow(data), 1)

### Write out data--------------------------------------------------------------
write.csv(data, "./Data/Top 500 2018_clean.csv", row.names = FALSE)
