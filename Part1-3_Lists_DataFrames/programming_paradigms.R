# ====================================
# Time Series Analysis with R
# gwendolin.wilke@fhnw.ch
#
# DIFFERENT PROGRAMMING PARADIGMS IN R 
#
# Example Code:
#     We square a list of numbers using three different programming paradigms:
#     1. Functional programming using lapply()
#     2. Procedural programming using a for loop
#     3. Object-oriented programming using S3 classes
#
# NOTE:
#   - This code and content is NOT EXAM-RELEVANT!
# ====================================



########## FUNCIONAL approach 

# We use lapply() to apply a function to each element in a list.

numbers <- list(1, 2, 3, 4, 5)
squared_numbers <- lapply(numbers, function(x) x^2)
print(squared_numbers)

# NOTE (Immutability):
#   - When lapply() is evoked, it does not change the original list. 
#   - Instead, it creates a new list with the results of applying the function to each element.
#   - This is a key feature of functional programming: IMMUTABILITY.
#   - It means that data structures cannot be modified after they are created. 

# NOTE (First-class functions):
#   - In functional programming, functions are FIRST-CLASS CITIZENS.
#   - This means that functions can be treated like any other data type.
#   - They can be passed as arguments to other functions, returned as values from other functions
#     and assigned to variables.
#   - In the above example, we passed an ANONYMOUS FUNCTION (function(x) x^2) as an argument to lapply().

# NOTE (Higher-order functions):
#   - In functional programming, higher-order functions are functions that can take other functions as arguments
#     or return functions as their result.
#   - In the above example, lapply() is a higher-order function because it takes
#     a function as an argument and applies it to each element of the list.



########## PROCEDURAL approach 

# We use a loop to iterate over the list elements and square each element.
numbers <- list(1, 2, 3, 4, 5)
squared_numbers <- list()  # Initialize an empty list

for (i in 1:length(numbers)) {
  squared_numbers[[i]] <- numbers[[i]]^2  # Square and assign
}

print(squared_numbers)

# NOTE (Mutability):
#   - In procedural programming, data structures are MUTABLE.
#   - This means that they can be modified after they are created.
#   - In the above example, we modified the squared_numbers list by assigning new values to
#     its elements within the loop.




########## OBJECT-ORIENTED approach using S3 classes

# Define the NumberList class
NumberList <- function(numbers) {
  structure(list(numbers = numbers), class = "NumberList")
}

# Define a method to square the numbers
square.NumberList <- function(obj) {
  lapply(obj$numbers, function(x) x^2)
}

# Create an instance of NumberList
num_list <- NumberList(list(1, 2, 3, 4, 5))
squared_numbers <- square.NumberList(num_list)
print(squared_numbers)


# NOTE (Encapsulation):
#   - In object-oriented programming, data and functions are encapsulated together in objects.
#   - In the above example, we defined a class NumberList that encapsulates a list
#     of numbers and a method square.NumberList that operates on that data.

# NOTE (Polymorphism):
#   - In object-oriented programming, polymorphism allows methods to be defined for different classes.  
#   - In the above example, we defined a method square.NumberList that is specific to the NumberList class.
#  - If we had another class, say Matrix
#     we could define a method square.Matrix that would operate on matrices, and the same function name 
#     "square" could be used for both classes without conflict.





########## APPENDIX 1: Vectorization in R is functional programming
#
#   - In R, many operations are VECTORISED.That means that r has built-in 
#     higher-order functions that can directly operate on entire vectors,
#     without the need for explicit loops.
#   - Thus, vectorization is a from of functional programming. 
#   - In the above example, we deliberately used lists to explicitely demonstrate 
#     what happens in higher-order functions. 
#  - However, we could have simply used vectors and applied the squaring operation directly to the vector:
numbers_vector <- 1:5
numbers_vector^2

# Here, ^2 is applied to each element of the vector.
# We don't see the higher-order function explicitly, but it is happening under the hood.
# Vectorized operations are implemented in optimized C code. 
# This makes them much faster than using explicit loops, especially for large datasets.



########## APPENDIX 2: Recursion in functional programming

#   - In functional programming, recursion is a common technique where a function calls itself in order
#     to solve a problem.
#   - In the above example, we did not use recursion.
#   - Here is an example of a recursive function to calculate factorial of a number.
#     Example: the factorial of the number 5 is calculated as 
#              5! = 5 * 4 * 3 * 2 * 1 = 120.

factorial <- function(n) {
  if (n == 0) {
    return(1)  # Base case: 0! is 1
  } else {
    return(n * factorial(n - 1))  # this is the recursive call: the function is used to define itself!
  }
}

# Example usage
factorial(5) # Outputs: 120
