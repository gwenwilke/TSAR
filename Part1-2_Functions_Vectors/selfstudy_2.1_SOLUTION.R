##############################################
# Time Series Analysis with R (TSAR)
# Self Study 2.1: Functions
# gwendolin.wilke@fhnw.ch
##############################################



############ Task 1: Using Built-In String Functions

# Create a variable `lyric` that contains the text "I like to eat apples and
# bananas"
lyric <- "I like to eat apples and bananas"

# Use the `substr()` function to extract the 1st through 13th letters from the
# `lyric`, and store the result in a variable called `intro`
# Use `?substr` to see more about this function
intro <- substr(lyric, 1, 13)

# Use the `substr()` function to extract the 15th through the last letter of the
# `lyric`, and store the result in a variable called `fruits`
# Hint: use `nchar()` to determine how many total letters there are!
fruits <- substr(lyric, 15, nchar(lyric))

# Use the `gsub()` function to substitute all the "a"s in `fruits` with "ee".
# Store the result in a variable called `fruits_e`
# Hint: see http://www.endmemo.com/program/R/sub.php for a simpmle example (or
# use `?gsub`)
fruits_e <- gsub("a", "ee", fruits)

# Use the `gsub()` function to substitute all the "a"s in `fruits` with "o".
# Store the result in a variable called `fruits_o`
fruits_o <- gsub("a", "o", fruits)

# Create a new variable `lyric_e` that is the `intro` combined with the new
# `fruits_e` ending. Print out this variable
lyric_e <- paste(intro, fruits_e)
print(lyric_e)

# Without making a new variable, print out the `intro` combined with the new
# `fruits_o` ending
print(paste(intro, fruits_o))




############ Task 2: Functions and Conditionals

# Define a function `is_twice_as_long` that takes in two character strings, and
# returns whether or not (e.g., a boolean) the length of one argument is greater
# than or equal to twice the length of the other.
# Hint: compare the length difference to the length of the smaller string
is_twice_as_long <- function(str1, str2) {
  diff <- abs(nchar(str1) - nchar(str2))
  min_length <- min(nchar(str1), nchar(str2))
  diff >= min_length # if difference is more than short
}

# Call your `is_twice_as_long` function by passing it different length strings
# to confirm that it works. Make sure to check when _either_ argument is twice
# as long, as well as when neither are!
is_twice_as_long("dog", "elephant")
is_twice_as_long("elephant", "dog")
is_twice_as_long("dog", "cat")


# Define a function `describe_difference` that takes in two strings. The
# function should return one of the following sentences as appropriate
#   "Your first string is longer by N characters"
#   "Your second string is longer by N characters"
#   "Your strings are the same length!"
describe_difference <- function(first, second) {
  diff <- nchar(first) - nchar(second)
  if (diff > 0) {
    sentence <- paste("Your first string is longer by", diff, "characters")
  } else if (diff < 0) {
    sentence <- paste("Your second string is longer by", -diff, "characters")
  } else {
    sentence <- "Your strings are the same length!"
  }
  sentence # return the sentence
}

# Call your `describe_difference` function by passing it different length strings
# to confirm that it works. Make sure to check all 3 conditions1
describe_difference("dog", "elephant")
describe_difference("elephant", "dog")
describe_difference("dog", "cat")

