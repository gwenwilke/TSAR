##############################################
# Time Series Analysis with R (TSAR)
# Self Study 2.2: Vectors
# gwendolin.wilke@fhnw.ch
##############################################



############ Task 1: Creating Vectors and Operating on Vectors

# Use the `seq()` function to produce a range of numbers from -5 to 10 in `0.1`
# increments. Store it in a variable `x_range`
x_range <- seq(-5, 10, 0.1)

# Create a vector `sin_wave` by calling the `sin()` function on each element 
# in `x_range`.
sin_wave <- sin(x_range)

# Plot your sine wave using ggplot. 
#   Hint: To pass the data to ggplot, combine it into a dataframe that contains x_range as the first column and sin_wave as the second column. 
df_sin_wave <- data.frame(x = x_range, y = sin_wave)
ggplot(df_sin_wave, aes(x = x, y = y)) +
  geom_point()

# Create a vector `cos_wave` by calling the `cos()` function on each element 
# in `x_range`.
cos_wave <- cos(x_range)

# Plot your sine wave using ggplot. 
df_cos_wave <- data.frame(x = x_range, y = cos_wave)
ggplot(df_cos_wave, aes(x = x, y = y)) +
  geom_point()

# Create a vector `wave` by multiplying `sin_wave` and `cos_wave` together, then
# adding `sin_wave` to the product
wave <- sin_wave * cos_wave + sin_wave

# Plot the result using ggplot2.
df_wave <- data.frame(x = x_range, y = wave)
ggplot(df_wave, aes(x = x, y = y)) +
  geom_point()



############ Task 2: Indexing and Filtering Vectors

# Create a vector `phone_numbers` that contains the numbers 8, 6, 7, 5, 3, 0, 9
phone_numbers <- c(8, 6, 7, 5, 3, 0, 9)

# Create a vector `prefix` that has the first three elements of `phone_numbers`
prefix <- phone_numbers[1:3]

# Create a vector `small` that has the values of `phone_numbers` that are 
# less than or equal to 5
small <- phone_numbers[phone_numbers <= 5]

# Create a vector `large` that has the values of `phone_numbers` that are 
# strictly greater than 5
large <- phone_numbers[phone_numbers > 5]

# Replace the values in `phone_numbers` that are larger than 5 with the number 5
phone_numbers[phone_numbers > 5] <- 5

# Replace every odd-numbered value in `phone_numbers` with the number 0
phone_numbers[phone_numbers %% 2 == 1] <- 0




############ Task 3: Vector Practice

# Exercise 3: vector practice

# Create a vector `words` of 6 (or more) words.
# You can Google for a "random word generator" if you wish!
words <- c("the", "quick", "brown", "fox", "jumped", "over", "lazy", "dog")

# Create a vector `words_of_the_day` that is your `words` vector with the string
# "is the word of the day!" pasted on to the end.
# BONUS: Surround the word in quotes (e.g., `'data' is the word of the day!`)
# Note that the results are more obviously correct with single quotes.
words_of_the_day <- paste0("'", words, "' is the word of the day!")
words_of_the_day

# Create a vector `a_f_words` which are the elements in `words` that start with 
# "a" through "f"
# Hint: use a comparison operator to see if the word comes before "f" alphabetically!
# Tip: make sure all the words are lower-case, and only consider the first letter
# of the word!
a_f_words <- words[substring(words, 1, 1) <= "f"]
a_f_words

# Create a vector `g_m_words` which are the elements in `words` that start with 
# "g" through "m"
g_m_words <- words[words >= "g" & substring(words, 1, 1) <= "m"]
g_m_words
#g_words <- words[words >= "g"]  # alternative approach
#g_m_words <- g.words[g_words <= "m"]

# Define a function `word_bin` that takes in three arguments: a vector of words, 
# and two letters. The function should return a vector of words that go between 
# those letters alphabetically.
word_bin <- function(words, start, end){
  words[words >= start & substring(words, 1, 1) <= end]
}

# Use your `word_bin` function to determine which of your words start with "e" 
# through "q"
word_bin(words, "e", "q")


