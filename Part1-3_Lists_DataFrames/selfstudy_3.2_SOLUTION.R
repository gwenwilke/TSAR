##############################################
# Time Series Analysis with R (TSAR)
# Self Study 3.2: Data Frames
# gwendolin.wilke@fhnw.ch
##############################################


############ Task 1: Built-In Data Sets: US Personal Expenditures

# Load R's "USPersonalExpenditure" dataset using the `data()` function
# This will produce a data frame called `USPersonalExpenditure`
data("USPersonalExpenditure")

# The variable `USPersonalExpenditure` is now accessible to you. Unfortunately,
# it's not a data frame (it's actually what is called a matrix)
# Test this using the `is.data.frame()` function
is.data.frame(USPersonalExpenditure)

# Luckily, you can pass the USPersonalExpenditure variable as an argument to the
# `data.frame()` function to convert it a data farm. Do this, storing the
# result in a new variable
us_exp <- data.frame(USPersonalExpenditure)

# What are the column names of your dataframe?
colnames(us_exp)

## Consider: why are they so strange? Think about whether you could use a number
## like 1940 with dollar notation!

# What are the row names of your dataframe?
rownames(us_exp)

# Add a column "category" to your data frame that contains the rownames
us_exp$category <- rownames(us_exp)

# How much money was spent on personal care in 1940?
care_1940 <- us_exp["Personal Care", "X1940"]

# How much money was spent on Food and Tobacco in 1960?
food_1960 <- us_exp["Food and Tobacco", "X1960"]

# What was the highest expenditure category in 1960?
highest_1960 <- us_exp$category[us_exp$X1960 == max(us_exp$X1960)]

# Define a function `lowest_category` that takes in a year as a parameter, and
# returns the lowest spending category of that year
lowest_category <- function(year) {
  col <- paste0("X", year)
  us_exp$category[us_exp[, col] == min(us_exp[, col])]
}

# Using your function, determine the lowest spending category of each year
# Hint: use the `sapply()` function to apply your function to a vector of years
lowest <- sapply(seq(1940, 1960, 5), lowest_category)





############ Task 2: External Data Sets: Gates Foundation Educational Grants

# Use the `read.csv()` functoin to read the data from the `data/gates_money.csv`
# file into a variable called `grants` using the `read.csv()`
# Be sure to set your working directory in RStudio.
grants <- read.csv("data/gates_money.csv", stringsAsFactors = FALSE)

# Use the View function to look at the loaded data
View(grants)

# Create a variable `organization` that contains the `organization` column of
# the dataset
organization <- grants$organization

# Confirm that the "organization" column is a vector using the `is.vector()`
# function.
# This is a useful debugging tip if you hit errors later!
is.vector(organization)

## Now you can ask some interesting questions about the dataset

# What was the mean grant value?
mean_spending <- mean(grants$total_amount)

# What was the dollar amount of the largest grant?
highest_amount <- max(grants$total_amount)

# What was the dollar amount of the smallest grant?
lowest_amount <- min(grants$total_amount)

# Which organization received the largest grant?
largest_recipient <- organization[grants$total_amount == highest_amount]

# Which organization received the smallest grant?
smallest_recipient <- organization[grants$total_amount == lowest_amount]

# How many grants were awarded in 2010?
length(grants$total_amount[grants$start_year == 2010])



############ Task 3: Large Data Sets: Female Baby Names

# Read in the female baby names data file found in the `data` folder into a
# variable called `names`. Remember to NOT treat the strings as factors!
names <- read.csv("data/female_names.csv", stringsAsFactors = FALSE)

# Create a data frame `names_2013` that contains only the rows for the year 2013
names_2013 <- names[names$year == 2013, ]

# What was the most popular female name in 2013?
most_popular_name_2013 <- names_2013[names_2013$prop == max(names_2013$prop), "name"]

# Write a function `most_popular_in_year` that takes in a year as a value and
# returns the most popular name in that year
most_popular_in_year <- function(year) {
  names_year <- names[names$year == year, ]
  most_popular <- names_year[names_year$prop == max(names_year$prop), "name"]
  most_popular # return most popular
}

# What was the most popular female name in 1994?
most_popular_1994 <- most_popular_in_year(1994)

# Write a function `number_in_million` that takes in a name and a year, and
# returns statistically how many babies out of 1 million born that year have
# that name.
# Hint: get the popularity percentage, and take that percentage out of 1 million.
number_in_million <- function(name, year) {
  name_popularity <- names[names$year == year & names$name == name, "prop"]
  round(name_popularity * 1000000, 1)
}

# How many babies out of 1 million had the name 'Laura' in 1995?
number_in_million("Laura", 1995)

# How many babies out of 1 million had your name in the year you were born?


## Consider: what does this tell you about how easy it is to identify you with
## just your name and birth year?

