##############################################
# Time Series Analysis with R (TSAR)
# Exercise 1.1: The Basics
# gwendolin.wilke@fhnw.ch
##############################################

############ Task 1: Magic with numbers

((5+2)*3-6)/3

############ Task 2: Magic with numbers

library(ggplot2)
mpg_plot <- ggplot(mpg, aes(x=displ, y=hwy)) + 
  geom_point(aes(color=class))
mpg_plot

############ Task 3: Load a csv file with base R

# Install and load the libraries readr and data.table.
install.packages("readr")
install.packages("data.table")
library(readr)
library(data.table)

# Download the dataset female_names.csv from Moodle. 
# Load the data set into R usmpging read.csv() from base R. Store it in a variable fnames. To do that, use the assignment operator  <- .
fnames <- read.csv("female_names.csv") # Remark: Don't forget to set your working directory first!

# To get a first impression of the data set, type View(fnames). Alternatively, you can click on the variable name in the Environments pane.
View(fnames)

# Now load it again, 
#   - using read.csv() from package readr, and store it in the variable fnames1.
fnames1 <- read_csv("female_names.csv") 

#   - using fread(), from from package data.table, and store it in the variable fnames2.
fnames2 <- fread("female_names.csv") 

# Do you experience a difference in performance? 
#       fread is indeed fastest

############ Task 4: Work with Data Types

# What is the data type of each of the following objects? If you don’t know, check the type using typeof().
typeof(1) # double
typeof(5L) # integer
typeof(sqrt(-1+0i)) # complex. 
# Note: Compare the results of typing sqrt(-1) and sqrt(-1+0i)! 
#       - sqrt(-1) gives NaN (not a Number). The reason is that -1 is numeric, and R is looking for a numeric result. Since sqrt(-1) is a complex number, it does not find any in the realm of numerical (ie., real) values.
#       - Sqrt(-1+0i) gives 0+1i. By specifying -1 as -1+0i, R knows now that is should find the solution in the complex data type.
typeof("25") # character

# Which of these coercions work? What do they produce?
as.numeric(FALSE) # 0
as.logical("Hello!") # NA (does not work)
as.integer(4.4) # 4
as.character(TRUE) # "TRUE"
as.numeric("scooby snacks") # NA (does not work)

# What is the output of each of these lines of code? Why?
sqrt(-1) # NaN (explanation see above)
"1" + "5" # Error. In R, the + operator does not work for string concatenation, only for numerics. We have seen above that character strings cannot be coerced to numeric.
# Remark: string concatenation in base R can be done with paste(). E.g., paste("Hello", "World")
1 + 7 # 8
TRUE + FALSE # 1, bc logic can be coerced to numeric.



############ Task 5: Work with Data Structures

# Create a vector of integers of length 20 and store it in the variable v.
v <- 1:20

# Use your vector v to create a matrix of integers with dimensions 4x5 and store it in the variable m.
m <- matrix(v, nrow=4)

# Coerce your matrix m into a data frame and store the result in the variable df.
df <- as.data.frame(m)

# Create a list called my_list with the following 4 elements:
#     "I love summer"
#     TRUE
#     "fun temperatures"
#     c(24,25,26)
my_list <- list("I love summer", TRUE, "fun temperatures", c(24,25,26))

# Create a data frame with the following columns (vectors) and save it in the variable my_df:
#     Your name and the name of your 2 best friends. 
#     Your age and your 2 best friends’ ages.
#     Whether you and each of your 2 friends own a car or not (as Boolean values).
my_df <- data.frame(names = c("Gwen", "Steffi", "Katja"),
                    ages = c(47, 39, 49),
                    cat_owner = c(TRUE, FALSE, TRUE))

# Save your data frame my_df to your disk
#     - as a csv file,
#     - as a RDS file. 
fwrite(my_df, file = "bffs.csv")
saveRDS(my_df, file = "bffs.RDS")
bffs1 <- fread("bffs.csv")
bffs2 <- readRDS("bffs.RDS")
# Remark: you can load the object alternatively by clicking in the filename in the "Files" tab of the "Output Pane" of RStudio.
# When you do this, RStudio asks you under which name you want to load the object in your environment.

# Save my_list and my_df as an Rdata file. Then remove both variables from your environment and load the saved RData file again.
save(my_list, my_df, file = "my_stuff.Rdata") # check 
rm(my_list) # rm() removes objects from the environment. Check ?rm.
rm(my_df) 
load("my_stuff.Rdata") 
# Notice: Since more than one object is stored in my_stuff.Rdata, I did not assign the output to a variable (like I did with readRDS above).
# Instead, the objects are automatically loaded under the original variable names. (Check the environment pane: my_list and my_df are there again.)
# This can accidentally overwrite an object name that is already in your envirinment - especially, when you don't know or don't remember what is inside the Rdata file.
# Thus, it is always safer to use saveRDS(), saving all objects separately.
# You can check what happens if you assign the output of load() to a varible:
my_stuff <- load("my_stuff.Rdata") 
my_stuff
typeof(my_stuff) # the names of the included objects are stored in a character vector, but the objects themselves are not loaded.

