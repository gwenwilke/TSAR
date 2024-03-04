##############################################
# Time Series Analysis with R (TSAR)
# Exercise 1.2: Data Viz with ggplot2 and plotly
# gwendolin.wilke@fhnw.ch
##############################################

##### Task 1: Create a basic Scatterplot

# Install and load the libraries "tidyverse", "ggplot2", "plotly” and “palmerpenguins”.

#install.packages("ggplot2")  
#install.packages("tidyverse")
#install.packages("palmerpenguins")
#install.packages("plotly") 
#install.packages("GGally") 

library(ggplot2) 
library(tidyverse)
library(palmerpenguins)
library(plotly)
library(GGally)

# Get a first impression of the data

View(penguins)
help("penguins")
glimpse(penguins) # glimpse() shows you all the attributes, their data types and some example values. glimpse() is part of the dyplyr package, which in turn is part of the tidyverse collection of packages.
summary(penguins) # summary() is a generic function. Applied to a data set, it gives you summary statistics of all attributes.
ggpairs(penguins) 


# Create the scatterplot

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point() 



##### Task 2: Pimp Up your Scatterplot

# Add the variable island to your plot by mapping it to the color channel.

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = island)) +
  geom_point() 

# Add the title "Flipper Length vs. Bill Length (in mm) by Island" 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = island)) +
  geom_point() +
  labs(title = "Flipper Length vs. Bill Length (in mm) by Island")  

# Add the subtitle "Source: Palmer Station LTER / palmerpenguins package" 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = island)) +
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Source: Palmer Station LTER / palmerpenguins package") 

# Change the x and y labels to "Flipper Length (mm)" and "Bill Length (mm)", respectively.

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = island)) +
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Source: Palmer Station LTER / palmerpenguins package",
       x = "Flipper Length (mm)", y = "Bill Length (mm)") 

# Change the legend title to "Island".

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = island)) +
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Source: Palmer Station LTER / palmerpenguins package",
       x = "Flipper Length (mm)", y = "Bill Length (mm)",
       color = "Island") # Notice that we set the legend for color, because it is the color aesthetic we want to label here. 


##### Task 3: Add a Smoothed Trendline

# Now add a layer geom_smooth to visualize a smoothed trendline. 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = island)) +
  geom_point() +
  geom_smooth() +
  labs(title = "Bill depth and length",
       subtitle = "Source: Palmer Station LTER / palmerpenguins package",
       x = "Flipper Length (mm)", y = "Bill Length (mm)",
       color = "Island") # Notice that we set the legend for the color channel here.

# What happens here?
#   Since the varoable island is mapped to the color channel up in the ggplot call, 
#   this mapping applies to all layers - including geom_smooth.
#   Therefore, 3 trendlines are displayed.

# Change your plot so that only one trendline is displayed.
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(mapping = aes(color = island)) +
  geom_smooth() +
  labs(title = "Bill depth and length",
       subtitle = "Source: Palmer Station LTER / palmerpenguins package",
       x = "Flipper Length (mm)", y = "Bill Length (mm)",
       color = "Island") # Notice that we set the legend for the color channel here.

# Make your plot interactive using ggplotly(). 

my_plot <- ggplot(data = penguins,
                  mapping = aes(x = flipper_length_mm,
                                y = bill_length_mm)) +
  geom_point(mapping = aes(color = island)) +
  geom_smooth() +
  labs(title = "Bill depth and length",
       subtitle = "Source: Palmer Station LTER / palmerpenguins package",
       x = "Flipper Length (mm)", y = "Bill Length (mm)",
       color = "Island")

ggplotly(my_plot)



##### Task 4: Create a Stacked Bar Plot

# Create a bar plot of the variable species.
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species)) 

# Use facet_wrap() to create a sequence of facets along the variable island.
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species)) +
  facet_wrap(~island)

# In facet_wrap(), add the argument ncol=1. (See help(facet_wrap) for more arguments!) 
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species)) +
  facet_wrap(~island,
             ncol=1)

# In aes(), add the position argument fill = sex. This gives you stacked bar plots according tp sex.
#   A position adjustment for a geometry (like geom_bar here) specifies a “rule” as to how different 
#   components should be positioned relative to each other to make sure they don’t overlap. 
#   This position adjustment is inherent in geom_bar, and we can make it visible by mapping a different 
#   variable to the color encoding (using the fill aesthetic here).
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species, fill = sex)) +
  facet_wrap(~island,
             ncol=1)
  
