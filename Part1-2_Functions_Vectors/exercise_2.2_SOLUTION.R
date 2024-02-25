##############################################
# Time Series Analysis with R (TSAR)
# Exercise 2.2: Vectors
# gwendolin.wilke@fhnw.ch
##############################################



############ Task 1: Creating Vectors and Operating on Vectors

# Create a vector `names` that contains your name and the names of 2 people 
# next to you. Print the vector.
names <- c("Joel", "Mike", "Dave")
print(names)

# Use the colon operator : to create a vector `n` of numbers from 10:49
n <- 10:49

# Use the `length()` function to get the number of elements in `n`
length(n)

# Add 1 to each element in `n` and print the result
print(n + 1)

# Create a vector `m` that contains the numbers 10 to 1 (in that order). 
# Hint: use the `seq()` function
m <- seq(10, 1)

# Subtract `m` FROM `n`. Note the recycling!
n_less_m <- n - m
print(n_less_m)



############ Task 2: Indexing and Filtering Vectors

# Create a vector `first_ten` that has the values 10 through 20 in it (using 
# the : operator)
first_ten <- 10:20

# Create a vector `next_ten` that has the values 21 through 30 in it (using the 
# seq() function)
next_ten <- seq(21, 30)

# Create a vector `all_numbers` by combining the previous two vectors
all_numbers <- c(first_ten, next_ten)

# Create a variable `eleventh` that contains the 11th element in `all_numbers`
eleventh <- all_numbers[11]

# Create a vector `some_numbers` that contains the 2nd through the 5th elements 
# of `all_numbers`
some_numbers <- all_numbers[2:5]

# Create a vector `even` that holds the even numbers from 1 to 100
even <- seq(2, 100, 2)  # start at first even number!

# Using the `all()` function and `%%` (modulo) operator, confirm that all of the
# numbers in your `even` vector are even
test <- all(even %% 2 == 0)





