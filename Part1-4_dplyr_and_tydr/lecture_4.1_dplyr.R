# ====================================
# Time Series Analysis with R
# gwendolin.wilke@fhnw.ch
# This script contains code used in 
# Part 1, Lecture 4.1 dyplyr
# ==================================== 

# install.packages("pscl")
# install.packages("dplyr")

library(pscl)
library(dplyr)

View(presidentialElections)

# ====== Selecting Columns with select()

# selecting two columns with select() from dplyr
votes <- select(presidentialElections, year, demVote)

# achieve the same with base R 
votes <- presidentialElections[c("year", "demVote")]    # using single brackets
votes <- presidentialElections[,c("year", "demVote")]   # using single brackets with comma

# plot it for fun
plot_votes <- ggplot(votes) + 
  geom_point(mapping = aes(x = year, y = demVote), alpha = .5, color = "dodgerblue4") +
  labs(x = "Year", y= "Percentage of Democratic Party votes", title = "Votes won by Democrats in each state") 
ggplotly(plot_votes)  

### You can specify vectors of columns the usual way

# Using the colon operator with select() 
select(presidentialElections, 1:3)   # using select() from dplyr
presidentialElections[,1:3]   # using bracket notation

# You can even use the colon operator with the column names
#   (Notice that this does not work with the bracket notation!)
select(presidentialElections, state:year) # works
presidentialElections[,"state":"year"]   # error

# Using the minus operator with select()  
select(presidentialElections, -4)  # all columns except `south` 
select(presidentialElections, -south)  # all columns except `south` 
presidentialElections[,-4] # equivalent bracket notation
presidentialElections[,-"south"] # error

### Standard and Non-standard evaluation both work!
select(presidentialElections, "state":"year") # standard evaluation
select(presidentialElections, state:year) # non-standard evaluation (allows you to drop the quotation marks for the column names)

# You can even use the c() function inside select() if you want.
select(presidentialElections, c("state":"year"))
select(presidentialElections, c(state:year))

# Yet, the point of using dplyr is to make writing code simpler! So, it's better to get used to dropping c() :-)

### Recall how the bracket notation works for data frames

# Use the *double* bracket notation to extract one column *as a vector*:
my_selection <- presidentialElections[["year"]]
print(my_selection)
is.vector(my_selection) # TRUE

# Use the *single* bracket notation to extract one column *as a data frame*:
my_selection <- presidentialElections["year"]
print(my_selection)
is.vector(my_selection) # FALSE
is.data.frame(my_selection) # TRUE

# Use the *single* bracket notation with *a comma* to extract a cell *as a data frame*:
my_selection <- presidentialElections[1,"year"]
print(my_selection)
is.data.frame(my_selection) # TRUE

# Use the *single* bracket notation with *a comma* to extract several rows and columns *as a data frame*:
my_selection <- presidentialElections[1:3,c("year", "demVote")]
print(my_selection)
is.data.frame(my_selection) # TRUE

### Now compare this to the select() function from dplyr:

# select() extracts columns *always as a data frame*, even when you select only one column:
my_selection <- select(presidentialElections, year)
print(my_selection)
is.data.frame(my_selection) # TRUE

# If you want to extract one column *as a vector*, you need to use pull() instead:
my_selection <- pull(presidentialElections, year)
print(my_selection)
is.vector(my_selection) # TRUE



# ====== Filtering for Rows using filter()

# Select all rows from the 2008 election
votes_2008 <- filter(presidentialElections, year == 2008)

# Achieve the same with bracket notation
votes_2008 <- presidentialElections[presidentialElections$year == 2008, ]
>
# Unlike select(), you must specify column names *without quotation marks* when using filter().
filter(presidentialElections, "year" == 2008) # an empty data frame is returned


### Multiple Conditions

# Multiple conditions are connected using a comma. The comma is treated as an AND operator.
votes_colorado_2008 <- filter(presidentialElections, 
  year == 2008,
  state == "Colorado"
)
print(votes_colorado_2008)

# You can also use other logical operators to connect multiple conditions
# Using an OR operator
votes_colorado_2008 <- filter(presidentialElections, 
                              year == 2008 | state == "Colorado"
)
View(votes_colorado_2008)
print(votes_colorado_2008, n=40)



# ====== Creating new Rows using mutate()

# Add an `other_parties_vote` column that is the percentage of votes for other parties
# Also add an `abs_vote_difference` column of the absolute difference between percentages.
#   Note you can use columns as you create them!
presidentialElections <- mutate(presidentialElections,
       other_parties_vote = 100 - demVote, # other parties is 100% - Democrat % 
       abs_vote_difference = abs(demVote - other_parties_vote)
)
print(presidentialElections)

# Renaming a column using rename(data, new_name = old_name)
rname(presidentialElections, DemocratesVote = demVote)




# ====== Sorting Rows using arrange()

# Sort the rows in decreasing order by year. Within each year, sort by demVote.
arrange(presidentialElections, -year, demVote)




# ====== Aggregating Column values using summary()

# summarize() generates a new data frame with new column names and only 1 row. 
average_votes <- summarize(presidentialElections,
                           mean_dem_vote = mean(demVote), 
                           mean_other_parties = mean(other_parties_vote)
)
print(average_votes)

# The output is always a data frame, even if it contains only one value:
average_votes <- summarize(presidentialElections,
                           mean_dem_vote = mean(demVote)
)
print(average_votes)


### You can use it with your own aggregation functions
#   The following code gives an example. it finds the least close election, 
#   i.e., the one in which the demVote was furthest from 50% in absolute value

#   Writing a function that returns the value in a vector furthest from 50
furthest_from_50 <- function(vec) { 
  adjusted_values <- vec - 50 # Subtract 50 from each value 
  vec[abs(adjusted_values) == max(abs(adjusted_values))]  # Return the element with the largest absolute difference from 50
  } 

# Generating a column `biggest_landslide` that stores the value furthest from 50%
ls <- summarize(presidentialElections,
          biggest_landslide = furthest_from_50(demVote) 
          )
# At the least close election, democrats won with 98.6% of the votes:
print(ls) 

# To access the value itself, we must use the function pull()
pull(ls) # returns a vector

# To find out where and when this happened, we can use filter()
filter(presidentialElections, 
       demVote == pull(ls)
       )



# ====== The Pipe Operator

library(dplyr) # load the pipe via dplyr
x <- 1:4 # define a vector

# function with 1 argument
log(x) # normal use of log()
x %>% log() # using the pipe instead

# daisychain log() and exp()
exp(log(x)) # normal
x %>% log %>% exp

# function with 2 parameters
log(x, base = 5) # normal
x %>% log(base = 5) # with pipe

# daisychain functions with 2 arguments
rep(log(x, base = 5), 3) # normal
x %>% log(base = 5) %>% rep(3) # with pipe

# using anaonymous functions
x^2
x %>% (function(x) x^2)


### The real power of the pipe arises when you start to combine multiple dplyr verbs.
#   This example finds the state with the highest 2008 `demVote` percentage
presidentialElections %>%   
  filter(year == 2008) %>%  
  filter(demVote == max(demVote)) %>% 
  select(state) 



# ====== Grouping Rows with group_by()

# Group observations by state
grouped <- group_by(presidentialElections, state)
print(grouped)

# Compute the average percentages across the years
state_voting_summary <- presidentialElections %>% 
  group_by(state) %>%
  summarize(
    mean_dem_vote = mean(demVote),
    mean_other_parties = mean(other_parties_vote) 
    )
print(state_voting_summary) # the result is a tibble

# You can extract values from the tibble using dollar sign or bracket notation.
state_voting_summary$state # returns a vector
state_voting_summary[1:10,c("state", "mean_dem_vote")] # returns a tibble

# You can convert a tibble back into a normal data frame using as.data.frame():
state_voting_summary_df <- as.data.frame(state_voting_summary)
print(state_voting_summary_df)
is.data.frame(state_voting_summary_df) # TRUE

# This example uses the data set flights from nycflights13
install.packages("nycflights13")
library(nycflights13)
print(flights)

flights %>% 
  filter(dest == "IAH") %>% 
  group_by(year, month, day) %>% 
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )



# ====== Joining Data Frames using *_join()

# Load the data sets (see github)
donors <- fread("donors.csv")
donations <- fread("donations.csv")

# Different joins
combined_data_left <- left_join(donations, donors, by = "donor_name")
print(combined_data_left)
combined_data_right <- right_join(donations, donors, by = "donor_name")
print(combined_data_right)
combined_data_inner <- inner_join(donations, donors, by = "donor_name")
print(combined_data_inner)
combined_data_full <- full_join(donations, donors, by = "donor_name")
print(combined_data_full)



