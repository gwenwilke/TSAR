##############################################
# Time Series Analysis with R (TSAR)
# Exercise 2.1: Functions
# gwendolin.wilke@fhnw.ch
##############################################



############ Task 1: Calling Built-in Functions

# Create a variable `my_name` that contains your name
my_name <- "Gwendolin Wilke"

# Create a variable `name_length` that holds how many letters (including spaces)
# are in your name (use the `nchar()` function)
name_length <- nchar(my_name)

# Print the number of letters in your name
print(name_length)

# Create a variable `now_doing` that is your name followed by "is programming!"
# (use the `paste()` function)
now_doing <- paste(my_name, "is programming!")

# Make the `now_doing` variable upper case
toupper(now_doing)



############ Task 2: Calling Built-in Functions (continued)

# Pick two of your favorite numbers (between 1 and 100) and assign them to
# variables `fav_1` and `fav_2`
fav_1 <- 12
fav_2 <- 87

# Divide each number by the square root of 201 and save the new value in the
# original variable
fav_1 <- fav_1 / sqrt(201)
fav_2 <- fav_2 / sqrt(201)

# Create a variable `raw_sum` that is the sum of the two variables. Use the
# `sum()` function for practice.
raw_sum <- sum(fav_1, fav_2)

# Create a variable `round_sum` that is the `raw_sum` rounded to 1 decimal place.
# Use the `round()` function.
round_sum <- round(raw_sum, 1)

# Create two new variables `round_1` and `round_2` that are your `fav_1` and
# `fav_2` variables rounded to 1 decimal places
round_1 <- round(fav_1, 1)
round_2 <- round(fav_2, 1)

# Create a variable `sum_round` that is the sum of the rounded values
sum_round <- sum(round_1, round_2)

# Which is bigger, `round_sum` or `sum_round`? (You can use the `max()` function!)
max(sum_round, round_sum)



############ Task 3: Writing and Executing Functions

# Define a function `add_three` that takes a single argument and
# returns a value 3 greater than the input
add_three <- function(value) {
  value + 3 # return the result
}

# Create a variable `ten` that is the result of passing 7 to your `add_three`
# function
ten <- add_three(7)

# Define a function `imperial_to_metric` that takes in two arguments: a number
# of feet and a number of inches
# The function should return the equivalent length in meters
imperial_to_metric <- function(feet, inches) {
  total_inches <- feet * 12 + inches
  meters <- total_inches * 0.0254
  meters # return the value in meters
}

# Create a variable `height_in_meters` by passing your height in imperial to the
# `imperial_to_metric` function
height_in_meters <- imperial_to_metric(5, 11)


