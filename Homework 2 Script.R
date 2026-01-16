#####################################
# ID 529 Homework 2
#####################################
# https://github.com/ID529-Coursework/homework-2-kedouglas17 instructions on doing homework.
# This uses directions and README from https://github.com/ID529/ID529data 


# Linking to Github -------------------------------------------------------

#In terminal of R studio, use:
#    git remote add origin https://github.com/kedouglas17/Homework-2.git
#    git branch -M main
#    git push -u origin main

# Loading Dependencies ----------------------------------------------------
install.packages("devtools")
install.packages("broom")

library(devtools)
devtools::install_github("ID529/ID529data")
#Updated all dependencies as part of this
library(ggplot2)
library(ID529data)
library(broom)

# Loading Data ------------------------------------------------------------

data("nhanes_id529", package = 'ID529data')
#2339 obs of 22 variables

# Data Cleaning -----------------------------------------------------------
# checking labels
labelled::generate_dictionary(nhanes_id529, details = 'full')



# Part 1 - Figures. Univariate figure -------------------------------------------------------
#Looking at the distribution of income (as percent of FPL) among the study 
#population - one thing I've been curious about with NHANES is who actually 
#completes the many tasks included and how representative those people are 
#of the US population

# useful to use the ggplot cheat sheet https://posit.co/resources/cheatsheets/

ggplot(data=nhanes_id529, aes(x = poverty_ratio)) +
  geom_histogram(bins = 40) +
  theme_bw() +
  labs(
    title = "Histogram of distribution of FPL among NHANES participants",
    x = "% Federal Poverty Level",
    y = "Frequency"
  )
ggsave("Univariate analysis.png")


# Bivariate figure --------------------------------------------------------

#Before doing any regression, want to know relationship between age and mean BP at baseline
ggplot(data=nhanes_id529) +
  geom_point(mapping=aes(x = age, y=mean_BP)) +
  geom_smooth(aes(x = age, y = mean_BP), method = "lm", se = TRUE) +
  theme_bw() +
  labs(
    title = "Scatterplot of age vs mean systolic blood pressure in NHANES participants",
    x = "Age (years)",
    y = "Mean systolic blood pressure (in mmHg)"
  )
ggsave("Bivariate analysis.png")




# Bivariate figure with facets --------------------------------------------

#Does that relationship between age and SBP change based on gender/sex? 
ggplot(data=nhanes_id529) +
  geom_point(mapping=aes(x = age, y=mean_BP)) +
  geom_smooth(aes(x = age, y = mean_BP), method = "lm", se = TRUE) +
  facet_wrap(~ sex_gender) +
  theme_bw() +
  labs(
    title = "Scatterplot of age vs mean systolic blood pressure in NHANES participants, divided by gender",
    x = "Age (years)",
    y = "Mean systolic blood pressure (in mmHg)"
  )
ggsave("Bivariate analysis with facets.png")




# Part 2 - Creating and visualizing regression model --------------------------------------





#Refer to lecture slides for example https://id529.github.io/day4.html
#Interested in how systolic blood pressure changes based on age and sex
lmmodel1 <- lm(mean_BP ~ age + sex_gender, data=nhanes_id529)

#to understand what the intercept and coefficients are
print(lmmodel1)
summary(lmmodel1)

#Make a tibble out of this regression model and export as CSV
lmmodel1_table<-broom::tidy(lmmodel1, conf.int=TRUE)
write.csv(lmmodel1_table, file="Linear regression model output")

#Create ggplot of model coefficients
ggplot(data=lmmodel1_table [lmmodel1_table$term != "(Intercept)", ]) +
  geom_pointrange(mapping=aes(y = term, x=estimate, xmin=conf.low, xmax=conf.high)) +
  theme_bw() +
  labs(
    title = "Forest plot of regression estimates",
    x = "Estimated effect (95% CI)",
    y = "Model term"
  )
ggsave("Forest plot of regression estimates.png")



#Create a summary table of the coefficients and confidence intervals for covariates in this model
install.packages("gtsummary")
library(gtsummary)
tbl_regression(lmmodel1)
regression_stats<-tbl_regression(lmmodel1)
print(regression_stats)



# Final thoughts ----------------------------------------------------------

#Thanks for looking through my code! Let me know how I can make it better :) 