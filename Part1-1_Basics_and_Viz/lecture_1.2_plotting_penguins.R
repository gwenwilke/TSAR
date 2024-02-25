# ====================================
# Time Series Analysis with R
# gwendolin.wilke@fhnw.ch
# This script contains code used in 
# Part 1, Lecture 1.2 Plotting with ggplot and plotly
# ==================================== 

# ====== Install and load necessary packages

# We can install an load ggplot2 as a package:
install.packages("ggplot2")  
library(ggplot2) 

# Or we can install and load it as part of the tidyverse:
install.packages("tidyverse")
library(tidyverse)

# Install and load the package plotly for interactive plots:
install.packages("plotly") 
library(plotly)

# Install a package that contains penguin data from the Palmer Archipelago in the Antarctica:
install.packages("palmerpenguins")
library(palmerpenguins)

# =====  Get a first idea of the penguins data set

View(penguins)
help("penguins")
glimpse(penguins) # glimpse() shows you all the attributes, their data types and some example values. glimpse() is part of the dyplyr package, which in turn is part of the tidyverse collection of packages.
summary(penguins) # summary() is a generic function. Applied to a data set, it gives you summary statistics of all attributes.


# ===== Coding out loud: Build a plot step by step along a narrative

# Start with the penguins data frame
ggplot(data = penguins)

# map bill depth to the x-axis
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm))

# map bill bill length to the y-axis
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm))

# Represent each observation with a point
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm)) + 
geom_point()

# map species to the colour 
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point()

# Title the plot "Bill depth and length"
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point() +
  labs(title = "Bill depth and length")

# Add the subtitle "Dimensions for Adelie, Chinstrap, and Gentoo Penguins"
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins")

# label the x and y axes as "Bill depth (mm)" and "Bill length (mm)"
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill depth (mm)", y = "Bill length (mm)")

# label the legend "Species"
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill depth (mm)", 
       y = "Bill length (mm)",
       colour = "Species") 

# add a caption for the data source
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill depth (mm)", y = "Bill length (mm)",
       colour = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package") 


# Finally, use a discrete colour scale that is designed to be perceived by viewers with common forms of colour blindness
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill depth (mm)", y = "Bill length (mm)",
       colour = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package") +
  scale_colour_viridis_d()


# ======== Remark

# You can omit the names of the arguments "data" and "mapping":

ggplot(data = penguins,               # named argument "data"
mapping = aes(x = bill_depth_mm,      # named argument "mapping"
              y = bill_length_mm,
              colour = species)) +
  geom_point() +
  scale_colour_viridis_d()

ggplot(penguins,                      # unnamed argument "data"
       aes(x = bill_depth_mm,         # named argument "mapping"
           y = bill_length_mm,
           colour = species)) +
  geom_point() +
  scale_colour_viridis_d()


# ====== Some Geoms


# == 1D

# bill length frequency distribution (histogram)
ggplot(data = penguins) +
  geom_histogram(mapping = aes(x = bill_length_mm)) 

# bill length frequency distribution (histogram)
ggplot(data = penguins) +
  geom_density(mapping = aes(x = bill_length_mm)) # note the different scale on y-axes compared to histogram

# bill length frequency distribution (boxplot)
ggplot(data = penguins) +
  geom_boxplot(mapping = aes(y = bill_length_mm)) 

# bill length frequency distribution (violin)
ggplot(data = penguins) +
  geom_violin(mapping = aes(x = "",
                            y = bill_length_mm)) 


# == 2D (categorical, bar chart)

# bill length and year 
ggplot(data = penguins) +
  geom_col(mapping = aes(x = year,
                         y = bill_length_mm)) 

# bill length and sex
ggplot(data = penguins) +
  geom_col(mapping = aes(x = sex,
                         y = bill_length_mm)) 

# bill length and island
ggplot(data = penguins) +
  geom_col(mapping = aes(x = island,
                         y = bill_length_mm))

# bill length and species
ggplot(data = penguins) +
  geom_col(mapping = aes(x = species,
                         y = bill_length_mm))


# == 2D (categorical, different plots)

# bill length and year 
ggplot(data = penguins) +
  geom_boxplot(mapping = aes(x = year,
                         y = bill_length_mm)) # doesnt work bc year is actually not categorical

# bill length and sex
ggplot(data = penguins) +
  geom_boxplot(mapping = aes(x = sex,
                         y = bill_length_mm)) 

# bill length and island
ggplot(data = penguins) +
  geom_violin(mapping = aes(x = sex,
                             y = bill_length_mm))

# bill length frequency distribution (histogram)
ggplot(data = penguins) +
  geom_histogram(mapping = aes(x = bill_length_mm, 
                               color=sex)) 


# == 2D (numerical, scatterplot)

# bill length and body mass
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm)) +
  geom_point() 

# bill length and body mass with trend 
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm)) +
  geom_point() +
  geom_smooth()

# bill length and body mass colored by species
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm,
                     color = species)) +
  geom_point() 

# bill length and body mass colored by species with trendlines per species
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm,
                     color = species)) +
  geom_point() +
  geom_smooth()

# bill length and body mass colored by species with global trendline
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm)) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth()


# == Exploring categorical variables

# island count
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = island)) 

# species count
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species)) +
  coord_flip()

# species by island
ggplot(data = penguins,
       mapping = aes(x = species,
                     y = island)) +
  geom_bin2d() # heatmap of 2d bin counts


# ====== Statistical transformations

# island count in absolute values
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = island, 
                         y = stat(count)))

# island count in % of largest population
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = island, 
                         y = stat(count/max(count)*100))) 


# ====== Mapping versus Setting

# mapping the value of species to the color channel
ggplot(data = penguins) +
  geom_point(mapping = aes(x = body_mass_g,
                           y = bill_length_mm,
                           color = species)) 

# setting the color to the fixed value "red" 
ggplot(data = penguins) +
  geom_point(mapping = aes(x = body_mass_g,
                           y = bill_length_mm),
             color = "red") 


# ====== Facets

ggplot(data = penguins) +
  geom_point(mapping = aes(x = body_mass_g,
                           y = bill_length_mm,
                           color = species)) +
  facet_wrap(~island) 


ggplot(data = penguins) +
  geom_point(mapping = aes(x = body_mass_g,
                           y = bill_length_mm,
                           color = species)) +
  facet_grid(island ~ sex) 

# ====== pairs and ggpairs()

install.packages("graphics")
library(graphics)
pairs(penguins)

install.packages("GGally")
library(GGally)
ggpairs(penguins)


# ====== Wrapping ggplot in plotly

my_penguins_plot <- ggplot(data = penguins) +
  geom_point(mapping = aes(x = body_mass_g,
                           y = bill_length_mm,
                           color = species))
library(Ggally)
ggplotly(my_penguins_plot)


