# ====================================
# Time Series Analysis with R
# gwendolin.wilke@fhnw.ch
# This script contains code used in 
# Part 1, Lecture 3.1 Lists
# ====================================

# ====== Creating lists

# Create a list with labels
person <- list(first_name = "Ada",
               job = "Programmer",
               salary = 78000,
               in_union = TRUE)

print(person)


# Create a list without labels
person_ul <- list("Ada",
               "Programmer",
               78000,
               TRUE)


print(person_ul)

# ====== Selecting list elements

# Select elements from a labelled list using dollar notation
person$first_name
person$salary

# Select elements from a labelled or unlabelled list using double bracket notation
person_ul[[1]]
person_ul[[3]]

# Combine dollar notation and double bracket notation
person <- list(first_name = "Ada",
               last_name = "Lovelace",
               job = "Programmer",
               salary = 78000,
               in_union = TRUE)

person[["first_name"]]
person[["last_name"]]

# Use the combination when storing labels in variables
name_to_use <- "last_name"
person[[name_to_use]] # "Lovelace"
name_to_use <- "first_name"
person[[name_to_use]] # "Ada"


# ====== Filtering versus Selecting

# Recreate the person lists
person <- list(first_name = "Ada",
               last_name = "Lovelace",
               job = "Programmer",
               salary = 78000,
               in_union = TRUE)

#   Single brackets filter a list, double brackets select elements from a list.
is.list(person) # TRUE
is.list(person[3]) # TRUE (This is *filtering*, i.e., the result is again a list.)
is.list(person[[3]]) # FALSE (This is a *selection* of the 3rd list element, which is a vector.)
is.character(person[[3]]) # TRUE (I.e., it is a character vector.)


# NOTE: Single brackets always filter a data structure (e.g., also vectors)

#   filtering vectors
shoe_sizes <- c(5.5, 11, 7 , 8, 4) # define a vector of shoe sizes
shoe_sizes[c(1,3)] # subsetting by index is filtering: the result is again a vector
shoe_sizes[1] # same
shoe_sizes[c(T,F,T,F,F)] # logical subsetting is filtering: the result is again a vector

#   filtering lists
person <- list(first_name = "Ada",
               last_name = "Lovelace",
               job = "Programmer",
               salary = 78000,
               in_union = TRUE)
person[c(1,3)] # subsetting by index is filtering: the result is again a list
person[3] # same
person[c(T,F,T,F,F)] # logical subsetting is filtering: the result is again a list



# ======  Nested lists
person <- list(first_name = "Ada",
               job = "Programmer",
               salary = 78000,
               in_union = TRUE,
               favourits = list(fav_music = "jazz",
                                fav_food = "schoggi"))
print(person)
person$favourits$fav_music # daisy-chaining the dollar notation



# ====== Adding, Modifying and Removing List Elements

# Recreate the original person lists
person <- list(first_name = "Ada",
               last_name = "Lovelace",
               job = "Programmer",
               salary = 78000,
               in_union = TRUE)

# Adding a new list element "age"
person$age # There is currently no "age" element (it's NULL)
person$age <- 40
print(person)

# Modifying the list element "job"
person$job <- "Senior Programmer"
print(person)

# Remove the list element "salary"
person$salary <- NULL
print(person)

# Selecting non-existing list elements
person$address # NULL
person[[6]] # error


# ====== NULL and NA are special values
my_list <- list(1,2,3,4,5)
print(my_list)
my_list[[3]] <- NULL # removes the 3rd element
print(my_list)
my_list[[4]] <- NA # replace the 4th element by "nothing" (missing value)
print(my_list)

# Note: vectors behave a bit differently with NA and NULL
my_vector <- 1:5
print(my_vector)
my_vector[4] <- NULL # error: you cant remove a vector element by assigning NULL. The reason is that, once defined, vectors have a fixed length.
my_vector[3] <- NA # But you can replace an element by "nothing" (insert a missing value)
print(my_vector)

# ====== Applying Functions to Lists with lapply()  

# Recreate the person list
person <- list(first_name = "Ada",
               last_name = "Lovelace",
               job = "Programmer",
               salary = 78000,
               in_union = TRUE)

# Find out the class of each list element 
lapply(person, class)

# Create a list of character strings
people <- list("Sarah", "Amit", "Zhang") 

# Make all names upper case
lapply(people, toupper) 

# Count the number of characters 
lapply(people, nchar) 

# Create a list of vectors of different lengths
div_vectors_list <- list(v1 = 1:10,
                         v2 = 1:20)
lapply(div_vectors_list, mean)


#### Apply to self defined functions

# Create a function that prepends "Hello" to any item
greet <- function(item) {
  paste("Hello", item) # this last expression will be returned
}

# Greet each person by applying the `greet()` function # to each element in the `people` list
greetings <- lapply(people, greet)
print(greetings)

my_fun <- function(s){
  sqrt(nchar(s)+1)
}
lapply(people, my_fun)

#### Apply to anonymous functions
lapply(people, function(x){sqrt(nchar(x)+1)}) 

#### Supply additional arguments for the applied functions
useless_list_of_digits <- lapply(people, function(x){sqrt(nchar(x)+1)}) 
print(useless_list_of_digits)
lapply(useless_list_of_digits, round) # without an additional argument round() rounds to full integers
lapply(useless_list_of_digits, round, digits = 1) # when specifying digits = 1 it round to 1 decimal place

# Provide the character string "dances" as a second argument to paste()
lapply(people, paste, "dances!")  


# ====== unlist() to convert a list into a vector

lapply(person, class) # output is a list of character strings
unlist(lapply(person, class)) # coerce the list into a vector

lapply(people, toupper) # output is a list of character strings
unlist(lapply(people, toupper)) # coerce the list into a vector

lapply(div_vectors_list, mean) # output is a list of numerics
unlist(lapply(div_vectors_list, mean)) # coerce the list into a vector


# ====== The *apply() family of functions

# sapply() as a shortcut for unlist(lapply())
unlist(lapply(person, class))
sapply(person, class)

# sapply() falling back to a list output

strsplit("gwen", split = "") # demonstrating strsplit: with an empty split pattern, the string is split into single characters and returned as a list
single_chars_vector <- function(s){   # Creating a function 
  unlist(strsplit(s, split = ""))     # applying unlist() to get a vector of single characters
}
sapply(people, single_chars_vector) # The output element are vectors, i.e. complex data structures. 


# sapply returning a matrix
people <- list("Sarah", "Amit", "Zhang") # recreating the peoples list
names(people) <- c("person1", "person2", "person3") # assigning labels to its elements
print(people)

unlist(strsplit("gwen", split = ""))[1] # demonstrating how to extract the first letter from a string
first_two_letters <- function(s){            # Writing a function that extracts the first 2 letters
  letters <- unlist(strsplit(s, split = ""))
  first <- letters[1]
  second <- letters[2]
  c(first = first,second = second)
}
first_two_letters("gwen") # the output is a vector of length 2
sapply(people, first_two_letters) # thus sapply returns a 2x3 matrix


# lapply() and sapply() can be applied to both, lists and vectors.
# To try out, we create a list and a vector of people:
people_vector <- c("Sarah", "Amit", "Zhang")
people_list <- list("Sarah", "Amit", "Zhang")

# lapply() always returns a list:
lapply(people_vector, toupper)
lapply(people_list, toupper)

# sapply() always returns a vector:
sapply(people_vector, toupper)
sapply(people_list, toupper)

# ====== mapply() for multiple arguments

# The function + takes in 2 values as arguments
1+1 # 2

# we can also write it in prefix notation
'+'(1,1)

# As all base R functions, it is vectorized
v1 <- 1:3
v2 <- 1:3
'+'(v1,v2) # 2 4 6
mapply('+', v1, v2) # 2 4 6

# It also works for lists
l1 <- list(1,2,3)
l2 <- list(1,2,3)
'+'(l1,l2) # error
mapply('+', l1, l2) # 2 4 6






