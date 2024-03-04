##############################################
# Time Series Analysis with R (TSAR)
# Exercise 3.1: Lists
# gwendolin.wilke@fhnw.ch
##############################################



############  Task 1: Creating and accessing lists

# Create a vector `my_breakfast` of everything you ate for breakfast
my_breakfast <- c("Kafi", "Gipfeli", "Joghurt")

# Create a vector `my_lunch` of everything you ate (or will eat) for lunch
my_lunch <- c("Basler Mehlsuppe", "Züri Gschnätzlets ")

# Create a list `meals` that has contains your breakfast and lunch
meals_list <- list(breakfast = my_breakfast, lunch = my_lunch)

# Add a "dinner" element to your `meals` list that has what you plan to eat
# for dinner
meals_list$dinner <- c("Fondue", "White Wine", "Espresso", "Vanille Glace")

# Use dollar notation to extract your `dinner` element from your list
# and save it in a vector called 'dinner'
my_dinner <- meals_list$dinner

# Use double-bracket notation to extract your `lunch` element from your list
# and save it in your list as the element at index 5 (no reason beyond practice)
meals_list[[5]] <- meals_list[["lunch"]]

# Use single-bracket notation to extract your breakfast and lunch from your list
# and save them to a list called `early_meals`
early_meals_list <- meals_list[1:2]



############ Task 2: Using lapply() 

# Round the number pi to the nearest 0.1 (one decimal place) using the function round().
round(pi, 1)

# Create a *list* of 10 random numbers.
# Hint: Use the runif() function to create a vector of random numbers. Then use as.list() to convert that to a list
rnums <- as.list(runif(10, 1, 100))

# Use lapply() to apply the round() function to each number, rounding it to
# the nearest 0.1 (one decimal place)
lapply(rnums, round, 1)



############ Task 3: Using lapply() and sapply()

# Create the list my_list <- list(observationA = 16:8, observationB = exp(c(20:19, 6:12))). 
my_list <- list(observationA = 16:8, observationB = exp(c(20:19, 6:12)))

# Calculate the respective means of observationA and observationB. 
# First use lapply, then use sapply(). 
# What is the difference? Use class() to check the object classes.
lapply(my_list, mean) # result is a list
sapply(my_list, mean) # result is a vector. Note that the verctor elements are named. (Remember that you can retrieve the names attribute using names(): names(sapply(my_list, mean)) )
  
class(lapply(my_list, mean)) # list 
class(sapply(my_list, mean)) # numeric (thus, it's a vector: the most basic object in R)

# Calculate the respective quartiles of observationA and observationB . First use lapply, then use sapply(). 
# What class are the respective output objects?
#   Hint: you can get the quartiles using the function quantile(). 
#   Remark: While mean returns a single value, quantile() returns a vector.
lapply(my_list, quantile)
sapply(my_list, quantile)

class(lapply(my_list, quantile)) #a list of two 4-element vectors (because the function quantile() produces a vector of 4 for each of the two elements of my_list.)
class(sapply(my_list, quantile)) # a 4x2 matrix

# Apply the exponential function exp() of to each element of observationB. 
log(my_list[[2]])

# Create the function my_transformation <- function(x) { log10(x) - 1 }. 
# Apply my_transformation() to each element of observationB.Try it first with vectorization, then with sapply().
my_transformation <- function(x) { log(x) + 1 }
my_transformation(my_list[[2]]) # vectorized version
sapply(my_list[[2]], my_transformation) # sapply version





