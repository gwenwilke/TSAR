##############################################
# Time Series Analysis with R (TSAR)
# Self Study 1.1: The Basics
# gwendolin.wilke@fhnw.ch
##############################################



# Which one is larger: sin(10) or cos(10)? Write an expression to solve this.
sin(10) < cos(10)

# Create a variable `puppies` equal to the number of puppies you'd like to have
puppies <- 8

# Create a variable `puppy_price`, which is how much you think a puppy costs
puppy_price <- 250

# Create a variable `total_cost` that has the total cost of all of your puppies
total_cost <- puppies * puppy_price

# Create a boolean variable `too_expensive`, set to TRUE if the cost is greater 
# than $1,000
too_expensive <- total_cost > 1000  # Bummer!

# Create a variable `max_puppies`, which is the number of puppies you can 
# afford for $1,000
max_puppies <- 1000%/%puppy_price  # %/% is "divide and ignore remainder"

# What is the data type of each of the following objects:
# c(1, 2, 3)
typeof(c(1, 2, 3)) # double
# c('d', 'e', 'f') 
typeof(c('d', 'e', 'f')) # character
# c("d", "e", "f") 
typeof(c("d", "e", "f")) # character
# c(TRUE,1L,10)
typeof(c(TRUE,1L,10)) # double (everything is coerced to double)
# c("11",10,12)
typeof(c("11",10,12)) # character (numeric is coerced to character)
# c("Sun","night", FALSE)
typeof(c("Sun","night", FALSE)) # character (logical is coerced to character)

# Find out what the abs() function does using the inbuilt help. How much is abs(10)?
?abs # abs(x) computes the absolute value of x
abs(10) # 10

# What is the square root of 11? Is there a function for this in R?
sqrt(11) # 3.316625

# How do you round numbers to the nearest integer in R? Is there a function?  Round 3.5 to the nearest integer.
round(3.5, digits = 0) # 4

# Create a vector that ranges from 10 to 50 in steps of 3. 
seq(1, 50, by = 3) # Notice that R, in contrast to Python, starts and ends at the specified number.

# Install the package "RXKCD”. What can you do with this package?
install.packages("RXKCD")
library("RXKCD")
?RXKCD
??RXKCD
getXKCD(which = "current", display = TRUE, html = FALSE, saveImg = FALSE)
  

  