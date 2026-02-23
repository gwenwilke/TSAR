# ====================================
# Time Series Analysis with R
# gwendolin.wilke@fhnw.ch
# 2.1 Functions in R
# ==================================== 

# listing all functions of a package, e.f. from base
library(help="base")

# “...” says that paste takes any number of positional arguments. 
help(paste)

# x refers to non-optional unnamed arguments
help(round)

# ====   Infix and prefix Notation
x <- 2+3 #infix
x <- "+"(2,3)


# ====   Loading functions from a package
library(stringr)
str_count("Mississippi", "s")


# ====  Namespacing a function

stringr::str_count("Mississippi", "s")

# Examples are:
#     - dplyr:: filter  ,   stats::filter
#     - dplyr::lag      ,   stats::lag  
#     - dplyr::select   ,   MASS::select


# ====  Warning upon package load

# install.packages("dplyr")
detach("package:dplyr", unload = TRUE) # unload the package if already loaded
library(dplyr) # load package again, warning about masking functions


# ==== Parts of a function

# a function always returns the last line
roll2 <- function(bones = 6) {    # function definition, with a default value for bones
  dice <- sample(1:bones, size = 2, replace = TRUE)
  sum(dice)                       # this line is returned
}

# You can call the function with or without the argument, 
# and you can also specify the argument by name.
roll2()
roll2(20)
roll2(bones = 10)

# You can use the function return() to return a value from a function
# This can be useful 
#     - if you want to return intermediate values of a function   
#     - if you want to return a value that is not the last line. 
roll3 <- function(bones = 6) {   
  dice <- sample(1:bones, size = 2, replace = TRUE)
  return(sum(dice))               # the function returns this value
}

# Note: In the above function roll3(), the return() statement is used to exit the 
#       function immediately and return the specified value, regardless of whether 
#       it is the last line of the function or not.
roll3()


# ==== Debugging

# Set sample values for the "lbs" and "inches" variables.
# These values will be used as input for the BMI calculation function.
lbs <- 180
inches <- 70

# Calculate BMI (body mass index) given the input in pounds and inches
calculate_bmi <- function(lbs, inches) {
  hight_in_meters <- inches * 0.0254
  weight_in_kg <- lbs * 0.453592
  bmi <- weight_in_kg / (hight_in_meters^2)
  bmi
}

calculate_bmi(lbs, inches) # uses the values of lbs and inches defined above



# ==== Conditional statements

# if / else if / else 
test_food_temp <- function(temp) {
  if (temp > 120) {
    return("too hot")
  } else if (temp < 70) {
    return("too cold")
  } else {
    return("just right!")
  }
}
test_food_temp(130)


# if / else 
add_title <- function(full_name, title) {
  if (startsWith(full_name, title)) {
    return(full_name) # if the name already starts with title, return it as is
  } else {
    return(paste(title, full_name)) # otherwise, add the title and return the modified name
  }
}
add_title("Smith", "Dr.")
add_title("Dr. Smith", "Dr.")
# Notice: In the above function add_title(), the first return statement is used 
#         to exit the function early in case the if condition IS met.


# if 
#   Omitting the else clause.
#   When no else clause is given, the function just “keeps going” whenever the if-condition is NOT met. 
add_title2 <- function(full_name, title) {
  if (startsWith(full_name, title)) {
    return(full_name) # if the name already starts with title, return it as is
  } 
  paste(title, full_name) # when the if condition is not met, the function continues and executes this line, returning the modified name
}
add_title("Smith", "Dr.")
add_title("Dr. Smith", "Dr.")
