##############################################
# Time Series Analysis with R (TSAR)
# Self Study 4.1: dplyr
# gwendolin.wilke@fhnw.ch
##############################################



############  Task 1: Comparing base R and dplyr

# Install and load dplyr if needed.
# install.packages("dplyr")
library(dplyr)

# Install the devtools package (as usual)
install.packages("devtools")

# The devtool package allows us to make installations from GitHub 
# Install the "fueleconomy" dataset from GitHub
devtools::install_github("hadley/fueleconomy")

# Load the "fueleconomy" package as usual.
library(fueleconomy)

# You now have access to the `vehicles` data frame. Use `View()` to inspect it.
View(vehicles)

# Select from this data frame the column makes, which holds the different car manufacturers. Save it in the variable makes.
makes <- vehicles$make


# Use the function unique() to list and count the different car manufacturers. 
# Alternatively, use the dplyr function distinct()to do the same. 
# What is the difference? 

unique(makes) # returns a vector
length(unique(makes))

distinct(vehicles, make) # returns a tibble
nrow(distinct(vehicles, make))


# Filter the data set for vehicles manufactured in 1997. 
# Do it first with base R, then with dplyr alone, then with dplyr and piping.

# With base R:
cars_1997 <- vehicles[vehicles$year == 1997, ] 

# With dplyr:
cars_1997 <- filter(vehicles, year == 1997) 

# With dplyr and piping:
cars_1997 <- vehicles %>%  
  filter(year == 1997)  


# Arrange (sort, order) the 1997 cars by highway (hwy) gas milage (in increasing order). 
# Do it first with base R, then with dplyr alone, then with dplyr and piping.
#     Hint: In base R, use the `order()` function to get a vector of indices in order by value

# With base R:
cars_1997_byhwy <- cars_1997[order(cars_1997$hwy), ]  

# With dplyr:
cars_1997_byhwy <- arrange(cars_1997, hwy)  

# With dplyr and piping:
cars_1997_byhwy <- cars_1997 %>%  
  arrange(hwy)


# Mutate the ordered 1997 cars data frame to add a column average that holds the average gas milage 
# (between city and highway mpg) for each car. 
# Do it first with base R, then with dplyr alone, then with dplyr and piping.

# With base R:
cars_1997_byhwy_av <- cars_1997_byhwy 
cars_1997_byhwy_av$average <- (cars_1997_byhwy_av$hwy + cars_1997_byhwy_av$cty) / 2  

# With dplyr:
cars_1997_byhwy_av <- mutate(cars_1997_byhwy, average = (hwy + cty) / 2) 

# With dplyr and piping:
cars_1997_byhwy_av <- cars_1997_byhwy %>% 
  mutate(average = (hwy + cty) / 2)


# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city. Save this new data frame in a variable.
# Do it first with base R, then with dplyr alone, then with dplyr and piping.

# With base R:
two_wheel_20_mpg <- vehicles[vehicles$drive == "2-Wheel Drive" & vehicles$cty > 20, ]

# With dplyr:
two_wheel_20_mpg <- filter(vehicles,
                           drive == "2-Wheel Drive",
                           cty > 20
)

# With dplyr and piping:
two_wheel_20_mpg <- vehicles %>% 
  filter(drive == "2-Wheel Drive") %>% 
  filter(cty > 20)


# Of the above vehicles, what is the vehicle ID of the vehicle with the worst (i.e. smallest) hwy mpg?
# Do it first with base R, then with dplyr alone, then with dplyr and piping.
#   Hint: filter for the worst vehicle, then select its ID.

# With base R:
worst_hwy <- two_wheel_20_mpg$id[two_wheel_20_mpg$hwy == min(two_wheel_20_mpg$hwy)] # Notice that there are two cars with the min hwy mpg!

# With dplyr:
filtered <- filter(two_wheel_20_mpg, hwy == min(hwy))
worst_hwy <- select(filtered, id)

# With dplyr and piping:
worst_hwy <- two_wheel_20_mpg %>% 
  filter(hwy == min(hwy)) %>% 
  select(id)


# Write a function that takes `year_choice` and a `make_choice` as parameters.
# It returns the vehicle model that gets the most hwy miles/gallon of vehicles of that make in that year.
# You'll need to filter more (and do some selecting)!
# Do it first with base R, then with dplyr alone, then with dplyr and piping.

# With base R:
make_year_filter <- function(make_choice, year_choice) {
  filtered <- vehicles[vehicles$make == make_choice & vehicles$year == year_choice, ]
  filtered[filtered$hwy == max(filtered$hwy), "model"]
}

# With dplyr:
make_year_filter1 <- function(make_choice, year_choice) {
  filtered <- filter(vehicles, 
                     make == make_choice,
                     year == year_choice)
  filtered <- filter(filtered, hwy == max(hwy))
  select(filtered, model)
}

# With dplyr and piping:
make_year_filter2 <- function(make_choice, year_choice) {
  vehicles %>% 
    filter(make == make_choice,
           year == year_choice) %>% 
    filter(hwy == max(hwy)) %>% 
    select(model)
}


# What was the most efficient Honda model of 1995?
make_year_filter("Honda", 1995)
make_year_filter1("Honda", 1995)
make_year_filter2("Honda", 1995)


############ Task 2: Using the dplyr for Grouping 

# Install the `"nycflights13"` package if necessary. Load the package.
# You'll also need to load `dplyr`.
# install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`.
#   Hint: you'll have to perform a grouping operation then summarizing your data
dep_delay_by_month <- flights %>%
                        group_by(month) %>% # creates a tibble that groups by month
                        summarize(delay = mean(dep_delay, na.rm = TRUE)) # calculates the mean departure delay per month
print(dep_delay_by_month)

# Which month had the greatest average departure delay?
filter(dep_delay_by_month, delay == max(delay)) %>% 
  select(month)


# If your data frame dep_delay_by_month contains only two columns (e.g., "month", and "delay" in that order), 
# you can create a scatterplot simply by passing that data frame to the base R function `plot()` without specifying the axes.
# Alternatively, you can use ggplot2 to create a scatterplot. 

# With base R:
plot(dep_delay_by_month) # notice that we only need to pass eth data frame as is!

# With ggplot2:
# In this case, ggplot is more effort!! (BUT it's easier to pimp your plot so that it looks nicer :-D )
library(ggplot2)
ggplot(dep_delay_by_month) + 
  geom_point(mapping = aes(x = month, y = delay))


# To which destinations were the average arrival delays the highest?
#     Hint: you'll have to perform a grouping operation then summarize your data.
#           You can use the `head()` function to view just the first few rows for checking.
arr_delay_by_month <- flights %>%
                        group_by(dest) %>%
                        summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
                        arrange(-delay)
head(arr_delay_by_month)


# The package nycflights13 also includes a data frame called "airports". 
# You can look up the above destinations in the `airports` data frame!
filter(airports, faa == arr_delay_by_month$dest[1]) # for example we can look up teh first destination, which is CAE.


# Which city was flown to with the highest average speed?
city_fasted_speed <- flights %>%
                        mutate(speed = distance / air_time * 60) %>%
                        group_by(dest) %>%
                        summarise(avg_speed = mean(speed, na.rm = TRUE)) %>%
                        filter(avg_speed == max(avg_speed, na.rm = TRUE))
city_fasted_speed




############ Task 3: Using the dplyr Join Operations

# Install the `"nycflights13"` package if needed. Load the package.
# You'll also need to load `dplyr`.

# install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe that holds the average arrival delays for each destination from the flights data frame. 
# Then use left_join() to join the result on the airports  dataframe. 
#     Remark: The airports  dataframe is also part of the nycflights13 package and holds information about the  airports.

avg_delay <- flights %>%
                group_by(dest) %>%    # creates it a tibble that groups rows by destination
                summarise(avg_delay = mean(arr_delay, na.rm = TRUE))  # calculates the mean arrival delay per group

avg_delay_dest <- avg_delay %>% 
                            mutate(faa = dest) %>% # create a new column faa, so we can use it as join condition
                            left_join(airports, by = "faa") 

# Which airport had the largest average arrival delay?
largest_arrival_delay <- avg_delay_dest %>% 
                            filter(avg_delay == max(avg_delay, na.rm = TRUE)) 
print(largest_arrival_delay) # CAE

# Notice that we could have done all the above in one single statement using pipes!
largest_arrival_delay <- flights %>%
  group_by(dest) %>%
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) %>%
  mutate(faa = dest) %>%
  left_join(airports, by = "faa") %>%
  filter(avg_delay == max(avg_delay, na.rm = TRUE))
print(largest_arrival_delay)

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe (which is also part of the nycflights13 package).
# Which airline had the smallest average arrival delay?
smallest_airline_delay <- flights %>%
  group_by(carrier) %>%
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) %>%
  left_join(airlines, by = "carrier") %>%
  filter(avg_delay == max(avg_delay, na.rm = TRUE))
smallest_airline_delay



  


