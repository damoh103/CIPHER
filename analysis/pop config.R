# CIPHER Project - Population configuration

library(ehrql)

dataset <- dataset()


# Study dates

index_date <- "2016-01-01"        # check


# Population definition

dataset$population <-
  patients$registered_with_one_practice() &                  
  patients$age_on(index_date) >= 18 &                   
  patients$has_follow_up_on(index_date)          # depends on whether we want to define this


# Basic demographics

dataset$age <- patients$age_on(index_date)

dataset$sex <- patients$sex()

dataset$ethnicity <- patients$ethnicity_from_sus()

dataset$imd <- patients$imd_quintile()    #check with IMD data

dataset$region <- patients$region()

