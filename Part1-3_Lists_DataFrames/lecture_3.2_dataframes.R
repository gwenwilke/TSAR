# ====================================
# Time Series Analysis with R
# gwendolin.wilke@fhnw.ch
# This script contains code used in 
# Part 1, Lecture 3.2 Data Frames
# ==================================== 


# ====== Create a data frame by passing vectors to the `data.frame()` function

# A vector of names
name <- c("Ada", "Bob", "Chris", "Diya", "Emma") # A vector of heights
height <- c(64, 74, 69, 69, 71) # A vector of weights
weight <- c(135, 156, 139, 144, 152)

# Combine the vectors into a data frame
# Note the names of the variables become the names of the columns! 
people <- data.frame(name, height, weight, stringsAsFactors = FALSE)


# ====== Create the data frame directly, specifying column names to use
people <- data.frame(
  name = c("Ada", "Bob", "Chris", "Diya", "Emma"), 
  height = c(64, 74, 69, 69, 71),
  weight = c(135, 156, 139, 144, 152)
)


# ====== Use functions to describe the shape and structure of a data frame

# Describe the structure of the data frame 
nrow(people) # [1] 5
ncol(people) # [1] 3
dim(people) # [1] 5 3
colnames(people) # [1] "name" "height" "weight" 
rownames(people) # [1] "1" "2" "3" "4" "5"

# Assign a set of row names for the vector 
# (using the values in the `name` column) 
rownames(people) <- people$name
print(people)

# Create a vector of new column names
new_col_names <- c("first_name", "how_tall", "how_heavy")

# Assign that vector to be the vector of column names
colnames(people) <- new_col_names
print(people)


# ====== Selecting and Filtering for Columns Using List-Syntax

# Recreate the original data frame
people <- data.frame(name, height, weight, stringsAsFactors = FALSE) 
# Name the rows
rownames(people) <- c("Patient1", "Patient2", "Patient3", "Patient4", "Patient5")
print(people)

# We *select* a list element (the `weight` column) using the $-notation:
(people_weights <- people$weight) # [1] 135 156 139 144 152
is.vector(people_weights) # TRUE. The result is a vector, since the `weight` column is a vector.

# We *select* a list element (the `hight` column) using the double bracket notation:
(people_heights <- people[["height"]]) # [1] 64 74 69 69 71
is.vector(people_heights) # TRUE

# We *filter* for the `weight` and `hight` columns using the single bracket notation:
(hights_weights_df <- people[c(2,3)])
is.vector(hights_weights_df) # FALSE
is.data.frame(hights_weights_df) # TRUE. Since we are extracting a 2-dimensional object, we are *filtering*, and the result is a data frameg.


# ====== Selecting and Filtering for Cells Using DataFrame-Syntax 

# We access a single cell, e.g., the cell in the 2nd row and 3rd column.
# The result is a vector.
people[2, 3] 
is.vector(people[2, 3]) # TRUE
is.data.frame(people[2, 3]) # FALSE

# We access a column of cells, e.g., the 3rd column.
# The result is a vector.
people[, 3] # Note: the empty space before the comma indicates that we access all rows!
is.vector(people[, 3]) # TRUE
is.data.frame(people[, 3]) # FALSE

# We access a row of cells, e.g., the 2nd row.
# The result is a data frame (!)
people[2, ] # Note the comma: it indicates that we select all columns.
is.vector(people[2, ]) # FALSE
is.data.frame(people[2, ]) # TRUE

### We can use subsetting by index to access a subset of cells.
# The result is a data frame (!)
people[1:2, 2:3] # 1st and 2nd row, 2nd and 3rd column
people[c(1,3), ] # 1st and 3rd row (and all columns)
people[, c(1,3)] # 1st and 3rd column (and all rows)
people[c(1,3),c(1,3)] # 1st and 3rd row, 1st and 3rd column 
is.data.frame(people[1:2, 2:3]) # TRUE
is.data.frame(people[c(1,3), ]) # TRUE
is.data.frame(people[, c(1,3)]) # TRUE

# We also use row and column names instead of numbers:
people["Patient2", "weight"] 
people["Patient2", ] 
people[,"weight"]
people[c("Patient1","Patient2"), c("name","weight")] 

# Notice that the following notations are equivalent:
people[,"weight"]   # [1] 135 156 139 144 152
people$weight       # [1] 135 156 139 144 152
people[["weight"]]  # [1] 135 156 139 144 152

# Only the single brackts *without* a comma give a different result (a data frame instead of a vector):
people["weight"] 
is.data.frame(people["weight"]) # TRUE

### We can also use logical subsetting to access a subset of cells.
people[people$height>70,] # all patients higher than 70
people[people$name != "Bob",] # all patients except Bob

# ====== Appending Rows to a Data Frame

# Adding one new row-vector using rbind
new_person <- c("Beat", 66, 125) # define a new person
people <- rbind(people, new_person) # append it to the data frame
print(people)

# To update the rowname of row 6, we can use subsetting
rownames(people)[length(rownames(people))] <- "Patient6"
print(people)

# Creating a data frame of new people
new_people <- data.frame(
  name = c("Fränzi", "Gaudenz", "Charlotte", "Anouk"), 
  height = c(63, 75, 68, NA),
  weight = c(NA, NA, 144, 142)
)
# Specifying the rownames
row.names(new_people) <- c("Patient7", "Patient8", "Patient9", "Patient10")

# Adding the new data frame "new_people" to our "people" data frame using rbind
people <- rbind(people, new_people)
print(people)

# ====== Appending Columns to a Data Frame

# Adding a column by specifying a new column vector using dollar-notation
people$pulse <- c(NA, 55, 82, 71, NA, 92, 55, 64, 68, 74)
print(people)

# Specifying a new data frame that holds the new patient metrics
new_metrics <- data.frame(
  blood_pr_sys = c(122, 121, 130, 153, 142, NA, 128, 118, NA, NA), 
  blood_pr_dia = c(81, 79, NA, 110, 92, 76, 102, NA, 61, 88)
)

# Adding the new data frame "new_metrics" to our "people" data frame using cbind
people <- cbind(people, new_traits)
print(people)


# ====== Factor Variables

# Demonstrate the creation of a factor variable
# Start with a character vector of shirt sizes
shirt_sizes <- c("small", "medium", "small", "large", "medium", "large") 

# Create a factor representation of the vector
shirt_sizes_factor <- as.factor(shirt_sizes)

# View the factor and its levels
print(shirt_sizes_factor) 
# [1] small medium small large medium large 
# Levels: large medium small

# The length of the factor is still the length of the vector, 
# not the number of levels
length(shirt_sizes_factor) # 6



# ======  Factors are not vectors!

# Create a factor of numbers (factors need not be strings!)
num_factors <- as.factor(c(10, 10, 20, 20, 30, 30, 40, 40))

# Print the factor to see its levels
print(num_factors)
# [1] 10 10 20 20 30 30 40 40 
# Levels: 10 20 30 40

# Multiply the numbers by 2
num_factors * 2 
# Warning Message: '*' not meaningful for factors # Returns vector of NA instead

# Changing entry to a level is fine
num_factors[1] <- 40

# Change entry to a value that ISN'T a level fails
num_factors[1] <- 50 
# Warning Message: invalid factor level, NA generated

# num_factors[1] is now NA
print(num_factors)

#### For data frames, this can generate a problem when new data needs to be added:

# Create a vector of shirt sizes
shirt_size <- c("small", "medium", "small", "large", "medium", "large") 

# Create a vector of costs (in dollars)
cost <- c(15.5, 17, 17, 14, 12, 23)

# Create a data frame of inventory and set stringsAsFactors to TRUE
shirts_factor <- data.frame(shirt_size, cost, stringsAsFactors = TRUE)

# Confirm that the `shirt_size` column is a factor
is.factor(shirts_factor$shirt_size) # TRUE

# Therefore, you are unable to add a new size like "extra-large"
shirts_factor[1, 1] <- "extra-large"
# Warning: invalid factor level, NA generated


# ======  Factors are useful for grouping

# Produce a list of data frames, one for each factor level
#   first argument is the data frame to split
# second argument the data frame to is the factor to split by 
shirt_size_frames <- split(shirts_factor, shirts_factor$shirt_size)
print(shirt_size_frames)

# ======  Specialized functions exist for factors

# Apply a function (mean) to each factor level
#   first argument is the vector to apply the function to
#   second argument is the factor to split by
#   third argument is the name of the function 
tapply(shirts_factor$cost, shirts_factor$shirt_size, mean)


