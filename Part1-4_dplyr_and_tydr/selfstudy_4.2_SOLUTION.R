##############################################
# Time Series Analysis with R (TSAR)
# Self Study 4.2: tydr
# gwendolin.wilke@fhnw.ch
##############################################


# Load necessary packages (`tidyr`, `dplyr`, and `ggplot2`)
library("tidyr")
library("dplyr")
library("ggplot2")

# Set your working directory using the RStudio menu:
# Session > Set Working Directory > To Source File Location

# Load the `avocado.csv` file into a variable `avocados`.
# Get a first impression of thw data using View() and str(). 
avocados <- read.csv("avocado.csv")
str(avocados)
View(avocados) 

# From str(), you can see that the Date column is of type char. 
# To tell R to treat the `Date` column as a date (not as a string),
# redefine that column as a date using the `as.Date()` function
#     Hint: use the `mutate` function
avocados <- avocados %>% 
  mutate(Date = as.Date(Date))
str(avocados)

# The file has some uninformative column names, so rename these columns:
# `X4046` to `small_haas`
# `X4225` to `large_haas`
# `X4770` to `xlarge_haas`
# These are the sales volumes of haas avocados.
avocados <- avocados %>% 
  rename(small_haas = X4046, 
         large_haas = X4225, 
         xlarge_haas = X4770)
str(avocados)

# The data only has sales for haas avocados. 
# Double-check this by summing up haas avocados sales and comparing the sum with the total sales value.
sum(avocados$Total.Volume - avocados$small_haas + avocados$large_haas + avocados$xlarge_haas > 0) # 18249 - This is the number of records in  of the data set. It means that on all days the Total Sales Volume is bigger than the Sales Volume of haas avocados.

# Create a new column `other_avos`
# that is the Total.Volume minus all haas avocados (small, large, xlarge)
avocados <- avocados %>% 
  mutate(other_avos = Total.Volume - small_haas - large_haas - xlarge_haas)

# To perform analysis by avocado size, create a dataframe `by_size` that has
# only `Date`, `other_avos`, `small_haas`, `large_haas`, `xlarge_haas`.
#   Note: 'other_avos' is not strictly a size, but we ignore this. We may view it as the bin that holds the sales volumes of avocados of size “unknown”.
by_size <- avocados %>% 
  select(Date, 
         other_avos, 
         small_haas, 
         large_haas, 
         xlarge_haas)

# Use head() to view the first few lines of your dataframe by_size. 
head(by_size) 

#   Is it tidy or messy? - messy
#   What is the observed event? - At a certain date, a number of avocados of a certain size are sold.
#   What are the recorded aspects? - (1) date, (2) size, (3) number sold.
#   How would a tidy version of the data look? 
#       (1) keep 'date' column.
#       (2) create a 'size' column that holds the column names 'other_avos', `small_haas`, `large_haas`, `xlarge_haas` as values.
#       (3) create a 'volume' column that holds the sales volumes.

# In order to visualize the data frame 'by_size', tidy it up using pivot_longer(). 
# Store the result in a new data frame 'by_size_tidy'. 
#   Hints:
#   - The four column names 'other_avos', 'small_haas', 'large_haas', 'xlarge_haas' go into a new column called 'size'. 
#   - The volumes of sales (currently stored in each of the above columns) go to a new column called  `volume`. 
by_size_tidy <- by_size %>% pivot_longer(
  cols = -Date,
  names_to = "size",
  values_to = "volume"
)
head(by_size_tidy) 

# This shape is not only tidier, it also facilitates the visualization of sales over time by size:
ggplot(by_size_tidy) +
  geom_smooth(mapping = aes(x = Date,
                           y = volume,
                           col = size),
             se = F) # Don't display the confidence intervals around the smoothed conditional means

# If we would use the original format (the data frame 'by_size') to plot sales by size, the code would be much longer:
by_size %>% ggplot() +
  geom_smooth(mapping = aes(x = Date,
                            y = small_haas, color = "Small Haas"), se = F) +    # specify you own label for 'color' inside aes(), e.g., color = "Small Haas". You can use whatever label you wish to appear in the legend (see below)
  geom_smooth(mapping = aes(x = Date,
                            y = large_haas, color = "Large Haas"), se = F) +
  geom_smooth(mapping = aes(x = Date,
                            y = xlarge_haas, color = "Xlarge Haas"), se = F) +
  geom_smooth(mapping = aes(x = Date,
                            y = other_avos, color = "Other"), se = F) +
  labs(x = "Date", y = "volume") + # Specify the title for the axes
  scale_color_manual(name = "", values = c("Small Haas" = "red", "Large Haas" = "blue", "Xlarge Haas" = "green", "Other" = "yellow")) # the labels must match what you specified above

# Using `by_size_tidy`, compute the average sales volume of each size.
#     Hint: first `group_by` size, then compute using `summarize`.
average_sales <- by_size_tidy %>% 
  group_by(size) %>% 
  summarize(avg_volume = mean(volume))
print(average_sales)

# We can also investigate sales by avocado type (conventional, organic).
#   - To do this, consider again the original 'avocados' data frame.
#   - Group it by 'Date' and 'type', and 
#   - calculate the sum of the column 'Total.Volume' for each group.
#   - Store the result in a new data frame called 'by_type'.
by_type <- avocados %>% 
  group_by(Date, type) %>% 
  summarise(volume = sum(Total.Volume))

# This data set is already tidy. Visualize the avocado sales over time by type using 'geom_smooth()'. 
#   Note: This is completely analogous to the plot you did before!
ggplot(by_type) +
  geom_smooth(mapping = aes(x = Date,
                            y = volume,
                            col = type),
              se = F)

# From the above plot we see that the sales volumes of both avocado types seem to increase over the years. Now let’s see if we can (visually) confirm this correlation in a scatterplot: if our assumption is correct, we should see a linear correlation between conventional and organic sales. Create this scatterplot using ggplot2.
# Hints:
#   - In order to check for a linear correlation between the types, we must map conventional sales to the x-axes and organic sales to the y-axes.   
#   - Yet, in the data frame by_type the sales numbers for both avocado types are mingled in one column, namely volume. 
#   - To facilitate the plotting, it would be good to have one column per type, each holding the respective sales numbers. Then we could simply map each column to an axes.
#   - To achieve this, reformat the data frame by_type using  pivot_wider(). Store the result in a new data frame called by_type_wide.
#   - Now use ggplot2 with geom_point() to generate the scatterplot. Does it confirm our assumption?
by_type_wide <- by_type %>% 
  pivot_wider(names_from = type, 
              values_from = volume)

ggplot(by_type_wide) +
  geom_point(mapping = aes(x = conventional, 
                           y = organic)) 

# As expected, the scatter plot shows some linear correlation between the sales numbers, but it is not too strong.
# This was expected as well: We could already see in the temporal plot that conventional sales vary much stringer than 
# organic sales, which is reflected in the relatively wide spread of points.




