# ====================================
# Time Series Analysis with R
# gwendolin.wilke@fhnw.ch
# 2.2 Vectors and Vectorization in R
# ==================================== 


# ===== All elements in a vector must have the same type.

# A vector of characters
people <- c("Alice", "Bob", "Charlie")

# A vector of numbers
numbers <- c(1, 2, 3, 4, 5)

# Notice: If we create a mixed vector of characters and numbers,
#             the numbers are coerced into characters (see coercion rules in lecture 1)
mixed <- c("Alice", "Bob", "Charlie", 5)


# ===== vector length

length(people) # Get the length of the vector)



# ===== Creating a sequence of integers

1:10 # Create a sequence of numbers from 1 to 10 using the colon operator
seq(1, 10) # Create a sequence of numbers from 1 to 10 with the seq() function
seq(1, 10, by = 2) # Create a sequence of numbers from 1 to 10 with a step of 2

# NOTE: 
#     seq() is inclusive! It includes the end point if it is reached by the sequence.
#     This is different from Python!

# ===== Vectorized operations

a <- c(1, 2, 3)
b <- c(4, 5, 6)
a + b # Add two vectors element-wise
a - b # Subtract two vectors element-wise
a * b # Multiply two vectors element-wise
a / b # Divide two vectors element-wise

a+a # Add a vector to itself
a*2 # Multiply a vector by a scalar

# NOTE: Vectorized operations are much faster than using loops
#       if you want to perform the same operations on each element of the vector.


# =====  Recycling

# If you perform an operation on two vectors of different lengths,
# R will recycle the shorter vector until it matches the length of the longer vector.
a <- c(1, 2, 3)
b <- c(4, 5)
a + b # This will recycle the shorter vector b to match the length of a

# Adding a scalar to a vector will also recycle the scalar to match the length of the vector
a + 3 # This will add 3 to each element of the vector a
# REMEMBER: the scalar 3 is internally stored as a vector of length 1


# =====  Vectorized functions

# Many functions in R are vectorized.
# This means they operate on an entire vectors element-wise without the need for explicit loops!

# Create a vector of numbers from 1 to 10
numbers <- 1:10
# Calculate the square root of each number in the vector
sqrt(numbers)

# Create a character vector
names <- c("Alice", "Bob", "Charlie")
# Calculate the number of characters in each name
nchar(names)

# NOTE!
#   If a function takes more than one argument, ALL arguments can be vectors!

# Create a vector of colors
colors <- c("Green", "Blue")
# Create a vector of two locations
locations <- c("sky", "grass")
# Use the vectorized paste() function to combine the colors and locations
paste(colors, locations)


# Create a vector of numbers from 1 to 10
numbers <- 1:10
# Create a vector of exponents from 1 to 10
exponents <- 1:10
# Calculate the power of each number to the corresponding exponent
numbers^exponents


# =====  Indexing vectors

# Create a vector of vowels
vowels <- c("a", "e", "i", "o", "u")

# Get the first element of the vector
vowels[1]

# If the index is out-of-bounds R returns the special value NA ("Not Available")
vowels[10]

# To get the last element of the vector, dynamically retrieve the last index using the length() function:
vowels[length(vowels)]

# To get a range of consecutive indexes, use the colon operator: 
vowels[1:3]

# To get the elements at different positions use the c() function to construct a vector of indexes:
vowels[c(1, 3, 5)]

# Get all elements EXCEPT the first one
vowels[-1]

# Get all elements EXCEPT the first and third one
vowels[-c(1, 3)]


# =====  Filtering (Logical Subsetting)

# Instead of putting a vector of indices in the square brackets to specify which elements you want to return, 
# you can put a vector of logical values (TRUE or FALSE) inside the square brackets. 
#     - The value TRUE in a certain position means that R returns the corresponding element. 
#     - The value FALSE means that R does not return that element.

# Create a vector of shoe sizes
shoe_sizes <- c(38, 39, 40, 41, 42)
# Create a vector of booleans to filter the vector
filter <- c(TRUE, FALSE, TRUE, FALSE, TRUE)
# Use the filter to subset the shoe sizes
shoe_sizes[filter]

# NOTE: You can use logical conditions for subsetting!

# Create a logical vector to filter the shoe sizes greater than 39
filter <- shoe_sizes > 39
# Use the filter to subset the shoe sizes
shoe_sizes[filter]

# NOTICE!
#     The scalar 39 is a vector of length 1.
#     The logical operator < is a vectorized function.
#     The scalar 39 is recycled to match the length of the shoe_sizes vector.

# To be shorter, we can directly put the logical condition inside the square brackets:
shoe_sizes[shoe_sizes > 39]


# =====  Modifying vector elements

# Create a vector of prices
prices <- c(25, 28, 30)
# Change the first price to 20
prices[1] <- 20

# ATTENTION!
#    If you assign a value to an index that is out-of-bounds, 
#    R will automatically extend the vector and fill the new elements with NA!

# Change the sixth price to 35 (index 6 is out-of-bounds)
prices[6] <- 60

# You can modify more than one element at a time.
#     E.g., change the 4th and 5th price (which is currently NA) to 27 and 29
prices[c(4, 5)] <- c(27, 29)


# You can add elements to a vector:
print(prices)
length(prices) # Get the current length of the vector
prices[length(prices) + 1] <- 32 # Add a new price at the end of the vector

# NOTE!
#   Keeping track of indices can be difficult. 
#   It also may easily change with your data, making the code fragile. 
#   A better approach for adding information at the end of a vector is to combine it with new elements: 
print(people)
people <- c(people, "David") # Add a new name to the end of the vector
print(people)


# You can combine vector modification and vector filtering:
# Create a vector of ages
v1 <- c(1,5,55,1,3,11,4,27)
# Replace all values greater than 10 with 10 ("cap at 10")
v1[v1 > 10] <- 10
print(v1)

# NOTE! 
#   We use recycling here to assign a single value (10) to each element that has been filtered from the vector.
#   This works, because the assignment operator is also vectorized.
#   This technique is particularly powerful when wrangling and cleaning data. 
#   It allows you to identify and manipulate invalid values or outliers. 



# =====  Vectorization means Speed!

# Initialize 2 vectors of length 1 million
v1 <- 1:1000000
v2 <- 1:1000000

# Initialize an empty vector to store the results
result <- numeric(length(v1)) 

# We use the function system.time() to measure how long an operation takes.
# Output of system.time() is a vector of three values:
#   - User Time	is the amount of CPU time spent in user mode  
#     (the time taken by the code you wrote). 
#     It indicates how much time the CPU spent executing your R code.
#   - System Time is the amount of CPU time spent in kernel mode 
#     (the time taken for functions that the operating system kernel executes on behalf of your R code). 
#     This includes tasks like memory management and file input/output operations.
#   - Elapsed Time ("wall-clock time") measures the total time elapsed from the 
#     start to the end of the operation, including both user and system times as well as 
#     any time spent waiting (e.g., for I/O operations). 
#     This is the total time you would perceive as waiting for the operation to complete.

# Add the vectors, using a for-loop (not vectorized)
system.time(
  for (i in 1:length(v1)) {
  result[i] <- v1[i] + v2[i]
}
)

# Add the vectors, using vectorized addition
system.time(
  result <- v1 + v2
  ) 

