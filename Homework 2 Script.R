#####################################
# ID 529 Homework 2
#####################################

# This uses directions and README from https://github.com/ID529/ID529data 


# Linking to Github -------------------------------------------------------

#Accidentally made project first, so will then link to Github

#In terminal will use:
#git remote add origin https://github.com/kedouglas17/Homework-2.git
#git branch -M main
#git push -u origin main

# Loading Dependencies ----------------------------------------------------
install.packages("devtools")

library(devtools)
devtools::install_github("ID529/ID529data")
#Updated all dependencies as part of this
library(ggplot2)
library(ID529data)

# Loading Data ------------------------------------------------------------

data("nhanes_id529", package = 'ID529data')
#2339 obs of 22 variables

# Data Cleaning -----------------------------------------------------------
# checking labels
labelled::generate_dictionary(nhanes_id529, details = 'full')



# Univariate figure -------------------------------------------------------
#Looking at the distribution of income (as percent of FPL) among the study population

ggplot(data=nhanes_id529, aes(x = `poverty_ratio`)) +
  geom_histogram(bins = 40) +
  theme_bw() +
  labs(
    title = "Histogram of distribution of FPL among NHANES participants",
    x = "% Federal Poverty Level",
    y = "Frequency"
  )
ggsave("Univariate analysis.png")


# Bivariate figure --------------------------------------------------------

ggplot(data=nhanes_id529, aes(x = `poverty_ratio`)) +
  geom_histogram(bins = 40) +
  theme_bw() +
  labs(
    title = "Histogram of distribution of FPL among NHANES participants",
    x = "% Federal Poverty Level",
    y = "Frequency"
  )
ggsave("Univariate analysis.png")






# Bivariate figure with facets --------------------------------------------


