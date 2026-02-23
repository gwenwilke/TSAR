# ====================================
# Time Series Analysis with R
# gwendolin.wilke@fhnw.ch
# 1.2 Plotting with ggplot and plotly
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

# At a geometry layer using the "+" that specifies HOW we want to represent the data:
# We use geom_point() to represent each observation by a point.
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm)) + 
geom_point()

# In the aesthetic mapping, we add another channel to the plot 
# We map species to the colour channel.
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point()

# Add labels (labs): 
# Add a title  
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point() +
  labs(title = "Bill depth and length")

# Add labels (labs): 
# Add a subtitle 
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins")

# Add labels (labs):
# Make labels for x and y axes nicer
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill depth (mm)", y = "Bill length (mm)")


# Add labels (labs):
# Make the legend title for the color channel nicer
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

# Add labels (labs):
# Add a caption for the data source
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

# "Scale" the colour channel with a colour-blind friendly paletteh
# Change the colour scale for viewers with colour blindness
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


# ====== Some "Geoms"


# == 1D numerical

# bill length frequency distribution (histogram)
ggplot(data = penguins) +
  geom_histogram(mapping = aes(x = bill_length_mm)) 

# bill length density plot 
ggplot(data = penguins)  +
  geom_density(mapping = aes(x = bill_length_mm)) # note the different scale on y-axes compared to histogram

# bill length boxplot
ggplot(data = penguins) +
  geom_boxplot(mapping = aes(y = bill_length_mm)) 

# bill length violin plot
ggplot(data = penguins) +
  geom_violin(mapping = aes(x = "",
                            y = bill_length_mm)) 

# you can add the quantile markers to the violin plot, 
# and not trim the tails of the violins
ggplot(data = penguins, 
       mapping = aes(x = "",
                     y = bill_length_mm)) +
  geom_violin(trim = FALSE, 
              draw_quantiles = c(0.25, 0.5, 0.75)) 


# == 1D categorical variables

# island count
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = island)) 

# species count
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species)) +
  coord_flip()


# == 2D numerical 

# scatterplot: bill length vs. body mass
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm)) +
  geom_point() 

# scatterplot & polynomial trendline (plottet on top of each other)
# bill length vs. body mass 
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm)) +
  geom_point() +
  geom_smooth()


# == 2D categorical 

# species by island and species (heatmap of 2d bin counts)
ggplot(data = penguins,
       mapping = aes(x = species,
                     y = island)) +
  geom_bin2d() 


# == 2D (categorical x, numerical y)


# column plot: (sum of) bill length per sex
# Note: a column plot uses actual values per category, 
#       while a bar plot counts the number of observations per category.
ggplot(data = penguins) +
  geom_col(mapping = aes(x = sex,
                         y = bill_length_mm)) 

# column plot: (sum of) bill length per island
ggplot(data = penguins) +
  geom_col(mapping = aes(x = island,
                         y = bill_length_mm))

# column plot: (sum of) bill length per species
ggplot(data = penguins) +
  geom_col(mapping = aes(x = species,
                         y = bill_length_mm))


# boxplot per category: bill length per sex
ggplot(data = penguins) +
  geom_boxplot(mapping = aes(x = sex,
                         y = bill_length_mm)) 

# violin plot  per category: bill length per sex
ggplot(data = penguins) +
  geom_violin(mapping = aes(x = sex,
                             y = bill_length_mm))

# violin plot per category: bill length per sex (with quantiles and untrimmed tails)
ggplot(data = penguins, 
       mapping = aes(x = sex,
                     y = bill_length_mm)) +
  geom_violin(trim = FALSE,
              draw_quantiles = c(0.25, 0.5, 0.), fill="grey") + 
  geom_boxplot(width=0.1)


# histogram, stacked by category: binned bill length stacked by per sex 
# (with sex on the color channel)
ggplot(data = penguins) +
  geom_histogram(mapping = aes(x = bill_length_mm, 
                               colour=sex)) 



# == 3D (numerical x, numerical y, color categorical)

# scatterplot: bill length vs. body mass, color by species
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm,
                     color = species)) +
  geom_point() 

# scatterplot & polynomial trendline (plottet on top of each other)
#   - scatterplot: bill length vs. body mass, color by species
#   - polynomoial trendline: bill length vs. body mass, color by per species 
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm,
                     color = species)) +
  geom_point() +
  geom_smooth()

# scatterplot & polynomial trendline (plottet on top of each other)
#   - scatterplot: bill length vs. body mass, color by species
#   - polynomoial trendline: bill length vs. body mass, no color channel
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm)) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth()





# ====== Statistical transformations

# island count in absolute values
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = island, 
                         y = stat(count)))

# island count in % of largest population
# Note the change in the y-axes scaling: Percentages instead of counts
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


# ====== 4D with Facets

ggplot(data = penguins) +
  geom_point(mapping = aes(x = body_mass_g,
                           y = bill_length_mm,
                           color = species)) +
  facet_wrap(~island) 


# ====== 5D with Facets

ggplot(data = penguins) +
  geom_point(mapping = aes(x = body_mass_g,
                           y = bill_length_mm,
                           color = species)) +
  facet_grid(island ~ sex) 



# ====== pairs() and ggpairs()

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

library(GGally)
ggplotly(my_penguins_plot)


