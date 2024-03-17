##############################################
# Time Series Analysis with R (TSAR)
# Exercise 4.2: tydr
# gwendolin.wilke@fhnw.ch
##############################################

library(tidyverse)

############  Task 1: Plotting time series of weights


# Consider the following toy data set of weight time series per person:
name <- c('ann', 'bob', 'charlie')
jan <- c(102, 155, 211)
feb <- c(112, 150, 211)
mar <- c(123, 147, 213)
apr <- c(130, 140, 210)
wts <- tibble(name=name, jan=jan, feb=feb, mar=mar, apr=apr)

# What is the observed event? - A person has a weight in a specific month. Example: Ann weighs 102 pounds in January. (Note: Probably it's always measured on the same day of each month!)
# What are the recorded aspects of the event? - (1) Name, (2) Month, (3) Weight
# Is this data set tidy or messy? - messy
# If messy, how would a tidy version of the data look? 
#     (1) Keep name as a column
#     (2) Create a column month. Its values are the current column names of columns 2-5.
#     (3) Create a column weight. Its values are the current values of these current columns.

# Tidy up the data frame using pivot_longer(). Store the result in a new data frame called 'wts_tidy'.
wts_tidy <- wts %>% pivot_longer(cols = jan:apr,
                                 names_to = "month",
                                 values_to = "weight"
                                 )

# Use geom_line() to plot the time series of weights per person.
# Hints:
#   - Map month to the x-axes
#   - Map weight to the y-axes
#   - Map name to the color scale
#   - Additionally, use the argument 'group = name' within the aesthetic of geom_line() to group observations by person.
#     Otherwise, geom_line() tries to connect all obersvations with a single line, which does not work.
wts_tidy %>% 
  ggplot() +
  geom_line(mapping = aes(x = month, 
                          y = weight, 
                          col = name, 
                          group = name))

# Notice that the months in your x-axes are ordered alphabetically. That's not the order we want!
# To change that, use mutate() to change the column 'month' from integer to "ordered factor".
# An "ordered factor" is a normal factor, but with an order that we can define manually.
# To achieve that, use the arguments 'ordered' and 'level' as follows:
# factor(month, ordered = TRUE, levels = c('jan', 'feb', 'mar', 'apr'))
wts_tidy <- wts_tidy %>% 
  mutate(month = factor(month,
                        ordered = TRUE,
                        levels = c('jan', 'feb', 'mar', 'apr')))

# Now redo the plot. The months will now appear in the order you specified above.
wts_tidy %>% 
  ggplot() +
  geom_line(mapping = aes(x = month, 
                          y = weight, 
                          col = name, 
                          group = name))

# Calculate the minimal, maximal and average weight per person.  
# Hint: Use group_by() and summarize()
wts_tidy_agg <- wts_tidy %>% 
  group_by(name) %>% 
  summarize(min = min(weight),
            max = max(weight),
            avg = mean(weight)
            )


############  Task 2: German Car Manufacturers

# The following (made-up) data set lists different German car manufacturers.
# It reports how many models with a specified number of cylinders have been built per manufacturer.
set.seed(3)
cars <- tibble(
  manufacturer = c("Audi", "BMW", "Mercedes", "Opel", "VW"),
  `3 cyl` = sample(20, 5, replace = TRUE),
  `4 cyl` = sample(50:100, 5, replace = TRUE),
  `5 cyl` = sample(10, 5, replace = TRUE),
  `6 cyl` = sample(30:50, 5, replace = TRUE),
  `8 cyl` = sample(20:40, 5, replace = TRUE),
  `10 cyl` = sample(10, 5, replace = TRUE),
  `12 cyl` = sample(20, 5, replace = TRUE),
  `16 cyl` = rep(0, 5)
)

# What is the observed event? - A manufacturer produces a certain number of cars with a certains number of cylinders. (Example: Audi builds 5 cars with 3 cylinders.)
# What are the recorded aspects of the event? - (1) manufacturer, (2) number of cylinders, (3) number of cars. 
# Is this data set tidy or messy? - messy
# If messy, how does a tidy version of the data look? 
#     (1) Keep 'manufacturer' as a column.
#     (2) Create a column 'cyl'. Its values are the current column names of columns 2-5.
#     (2) Create a column 'freq'. Its values are the current values of columns 2-5.

# Tidy up the data set. Store the result in a new data frame 'cars_tidy'.
cars_tidy <- cars %>% pivot_longer(cols = -manufacturer,
                                   names_to = "cyl",
                                   values_to = "freq")

# Use geom_col() to create a bar plot that shows the frequency per cylinder. 
# Use facet_wrap() to create one such plot per manufacturer.
# Use ggplotly() to make it interactive.
p_tidy_cars <- cars_tidy %>% ggplot() +
  geom_col(mapping = aes(x = cyl,
                         y = freq)) +
  facet_wrap(~ manufacturer)

library(plotly)
ggplotly(p_tidy_cars)

# Notice that the number of cylinders is not in a natural order.
# To change that, use mutate() to change the data type of the variable 'cyl'.
# Hint: You have 2 options:
#   - You can either convert the variable 'cyl' in an ordered factor, 
#   - or you can use gsub("\\D", "", cyl) and as.numeric() to extract the numbers from the strings.
# Try out both options. 

# Option 1: converting it 'cyl' in an ordered factor:
cars_tidy1 <- cars_tidy %>% 
  mutate(cyl = factor(cyl,
                      ordered = TRUE,
                      levels = c("3 cyl", "4 cyl", "5 cyl", "6 cyl", "8 cyl", "10 cyl", "12 cyl", "16 cyl")
                     )
         )

# Option 2: using gsub() to extract the numbers from the strings
cars_tidy2 <- cars_tidy %>% 
  mutate(cyl = as.numeric(gsub("\\D", "", cyl))) # All non-numbers (\\D) are replaced by the empty string ("").


# Redo the plot for both options. 
p_tidy_cars1 <- cars_tidy1 %>% ggplot() +
  geom_col(mapping = aes(x = cyl,
                         y = freq)) +
  facet_wrap(~ manufacturer)
ggplotly(p_tidy_cars1)

p_tidy_cars2 <- cars_tidy2 %>% ggplot() +
  geom_col(mapping = aes(x = cyl,
                         y = freq)) +
  facet_wrap(~ manufacturer)
ggplotly(p_tidy_cars2)

# Do you notice a difference? 
#   - When using gsub(), cyl is converted to numbers, and thus, ggplot puts a number scale on the x-axes.
#     Thus, there is a slot reserved for, e.g., 7 cylinders, even though cars with 7 cylinders do not exist!
#     On gthe other hand, cars with 16 cylinders exist, but zero are produced.
#     When using this option we cannot distinguish between 'non-existing' and 'zero'!
#   - This does not happen when we use ordered factors. 
# Which option is better for visualization?
#   - Thus, ordered factors are the better option for visualization!




