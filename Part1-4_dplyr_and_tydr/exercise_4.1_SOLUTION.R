##############################################
# Time Series Analysis with R (TSAR)
# Exercise 4.1: dplyr
# gwendolin.wilke@fhnw.ch
##############################################



############ Practicing with dplyr Verbs and Pipes

# Install the `"nycflights13"` package. Load the package.
# You'll also need to load `dplyr`.
install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the columns represent)
nrow(flights)
ncol(flights)
colnames(flights)
??flights
?flights

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
#   Note: If your new column doesn't show up with print(), look at the bottom written in grey: Maybe there was not enough space to print it in your window!
#   In this case use print(flights, width = Inf)
flights <- mutate(flights, gain_in_air = arr_delay - dep_delay)
print(flights, width = Inf)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Save it as a variable (or in the same one!)
flights <- arrange(flights, desc(gain_in_air))
View(head(flights))

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights <- flights %>% 
  mutate(gain_in_air = arr_delay - dep_delay) %>% 
  arrange(desc(gain_in_air))


# Make a histogram of the amount of time gained using the `hist()` function from base R

# histogram with base R:
hist(flights$gain_in_air) 

# histogram with ggplot2:
library(ggplot2)
ggplot(flights) +
  geom_histogram(mapping = aes(x = gain_in_air))

# Compare the two visualizations: what is different and why are they different?
#     In the first plot, they mode (the most frequent gain) has a count of over 150'000.
#     In contrast, in the second plot, it has a count of over a bit over 100'000.
#     The difference results from different binning: The bins ("intervals") used for counting the frequencies have different widths.
#     The larger the intervals, the more occurances per interval!

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(flights$gain_in_air, na.rm = TRUE) # Gained 5 minutes!

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you created
to_sea <- flights %>% 
  select(origin, dest, gain_in_air) %>% 
  filter(dest == "SEA")

# On average, did flights to SeaTac gain or lose time?
mean(to_sea$gain_in_air, na.rm = TRUE) # Gained 11 minutes!

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: Try to use pipes so that you can answer this question in one statement!
flights %>% 
  filter(origin == "JFK",
         dest == "SEA") %>% 
  summarize(avg_air_time = mean(air_time, na.rm = TRUE),
            min_air_time = min(air_time, na.rm = TRUE),
            max_air_time = max(air_time, na.rm = TRUE))




