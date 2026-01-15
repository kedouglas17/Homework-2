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

