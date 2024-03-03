##############################################
# Time Series Analysis with R (TSAR)
# Self Study 3.1: Lists
# gwendolin.wilke@fhnw.ch
##############################################


############ Task 1: Using lapply() 

# Create a list of meals that you ate yesterday (breakfast, lunch, dinner). 
# Remark: You can reuse your list from task 1, exercise 3.1.
yesterdays_meals_list <- list(breakfast = c("Kafi", "Gipfeli", "Joghurt"),
                         lunch = c("Basler Mehlsuppe", "Züri Gschnätzlets "),
                         dinner = c("Fondue", "White Wine", "Espresso", "Vanille Glace"))

# Create a list that has the number of items you ate for each meal
# Hint: use the `lappy()` function to apply the `length()` function to each item
items <- lapply(yesterdays_meals_list, length)

# Write a function `add_pizza` that adds pizza to a given meal vector, and
# returns the pizza-fied vector
add_schoggi <- function(meal) {
  meal <- c(meal, "Schoggi")
  meal # return the new vector
}

# Create a vector better_dinner that contains all the meals of yesterday’s dinner, but with schoggi added!
better_dinner <- add_schoggi(yesterdays_meals_list$dinner)

# Create a vector `better_meals` that is all your meals, but with pizza!
better_meals_list <- lapply(yesterdays_meals_list, add_schoggi)



############ Task 2: Using filtering and sapply() 

# Create a variable 'sentence' that contains a sentence of text (something
# longish). Make the sentence lowercase; you can use a function to help.
sentence <- tolower("Time flies like an arrow. Fruit flies like bananas.")

# Use the `strsplit()` function to split the sentence into a vector of letters. 
#   Hint: Split on `""` to split every character. (You don't need to exclude punctuation marks.)
#   This will return a list with 1 element (which is the vector of letters). 
letters_list <- strsplit(sentence, "")

# Extract the vector of letters from the resulting list and store it in a variable called letters_vector.
letters_vector <- letters_list[[1]]

# Use the `unique()` function to get a vector of unique letters. Store it in the variable letters_unique.
letters_unique <- unique(letters_vector)

# Count how many different letters occur in your sentence by counting the number of elements in letters_unique. 
#   Hint: Use the function length()
#   (Notice that this includes punctuation marks!)
length(letters_unique)

# How often does the letter 'a' occur in your sentence? (Don't use loops, but work with vectorization!)
#   Remark: To find out, filter letters_vector for the letter 'a'. 
#           Then use the function length() on the filtered vector.
#   Remark: Remember the lecture on vectors: You can filter a vector by using a vector of logicals ("logical subsetting").
#           To get the vector of logicals that you need for this task, just specify the logical test that compares a given letter with the letter 'a'. 
#           Apply this test to your letters_vector. (Recycling vectorizes your test automatically!).
length(letters_vector[letters_vector == "a"])

# Now define a function `count_occurrences` that takes in two parameters: an arbitrary letter
# and a sentence. The function should return how many times that letter
# occurs in the provided sentence.
#   Remark: Test your functino with your sentence and the letter "a".
count_occurrences <- function(letter, sentence) {
  sentence <- tolower(sentence)
  letters_list <- strsplit(sentence, "")
  letters_vector <- letters_list[[1]]
  length(letters_vector[letters_vector == letter])
}

count_occurrences("a", sentence)

# How many times the letter 'i' occur in your sentence?
count_occurrences("i", sentence)

# For each letter in your sentence, how many times does it occur? (Don't use loops, but work with vectorization!)
#   Hint: What you want to do is to take each letter of letters_unique, and put it into your `count_occurrences()` function.
#         Instead of looping through it, you can use `sapply()`. 
sapply(letters_unique, count_occurrences, sentence)

# Convert the resulting vector into a list, using `as.list()` and store it in a variable 'frequencies'.
# Print the resulting list of frequencies.
frequencies <- as.list(sapply(letters_unique, count_occurrences, sentence))
print(frequencies)


