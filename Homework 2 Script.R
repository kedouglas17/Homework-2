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




# Part 2 - Creating regression model --------------------------------------





#Refer to lecture slides for example https://id529.github.io/day4.html
#Interested in how systolic blood pressure changes based on age and sex
lmmodel1 <- lm(mean_BP ~ age + sex_gender, data=nhanes_id529)

#to understand what the intercept and coefficients are
print(lmmodel1)
summary(lmmodel1)

#Make a tibble out of this regression model
broom::tidy(lmmodel1, conf.int=TRUE)






you could extract the model coefficients with broom::tidy() and write those to a CSV file
you could extract the model coefficients with broom::tidy() and plot them with ggplot (we would use geom_pointrange to create a forest plots)
you could extract the output from running summary() on your model and save that to a .txt file
you can use capture.output() to grab the output of summary() and use writeLines() to write that to a .txt file
you could save some or all of the diagnostic plots to image files
you could use the gtsummary or stargazer packages to report on the model coefficients and the model performance
you could write a markdown file that presents a summary of your findings
if you include a markdown file in your submission, that's a great place to discuss both your rationale for what you chose to include in your model as well as some discussion about the model findings (do they agree/disagree with your intuition? do they surprise you?). it's also great to practice putting into words what the model coefficients represent (e.g., something like "for every one unit increase in [predictor variable], the model predicted an increase in [outcome variable] of XX").