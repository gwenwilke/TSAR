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
# violin plots are density plots that are mirrored and flipped to look like violins.
ggplot(data = penguins) +
  geom_violin(mapping = aes(x = "",
                            y = bill_length_mm)) 

# For better visualization, we can also not trim the tails of the violins (which is the default).
ggplot(data = penguins) +
  geom_violin(mapping = aes(x = "",
                            y = bill_length_mm),
              trim = FALSE) 

# One advantage of violin plots over density plots is that you can show more than one of them in a single picture.
# E.g., here, we split them up according to the value of the categorical variable species.
# Note that this is already a 2D plot now, because it shows 2 different dimensions: bill length (numerical) and species (categorical).
ggplot(data = penguins) +
  geom_violin(mapping = aes(x = species,
                            y = bill_length_mm),
              trim = FALSE)

# Another advantage is that you can add quantile markers.
# In this way, you can combine a density plot with a boxplot.
ggplot(data = penguins, 
       mapping = aes(x = species,
                     y = bill_length_mm)) +
  geom_violin(trim = FALSE, 
              draw_quantiles = c(0.25, 0.5, 0.75)) 


# == 1D categorical variables


# island count
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = island)) 

# island count with flipped coordinate system using coord_flip()
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = island)) +
  coord_flip()


# == 2D numerical 

# scatter plot: bill length vs. body mass
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
# Note: In contrast to bar plot, a column plot uses actual values of another variable per category. 
#       A bar plot counts the NUMBER of observations per category.
ggplot(data = penguins) +
  geom_col(mapping = aes(x = sex,
                         y = bill_length_mm)) 

# Note: Here, the y-axis shows the SUM of bill length per category, which is a bit useless.
#       If you want to show the MEAN bill length per sex instead, 
#       you can use a statistical layer, such as stat_summary() instead of geom_col()
#       You can specify the type of summary statistic you want to compute and display, 
#       such as the mean, median, or also custom functions.
#       Here, we use fun = "mean".
ggplot(data = penguins) +
  stat_summary(mapping = aes(x = sex, 
                             y = bill_length_mm), 
               fun = "mean", 
               geom = "col")

# With "geom = " you can specify the geometry you want to use to display the summary statistic.
# E.g., we can change it to geom = "point".
ggplot(data = penguins) +
  stat_summary(mapping = aes(x = sex, 
                             y = bill_length_mm), 
               fun = "mean", 
               geom = "point")

# boxplot per category: bill length per sex
ggplot(data = penguins) +
  geom_boxplot(mapping = aes(x = sex,
                             y = bill_length_mm)) 

# Combining 2 geom layers in one picture:
#   E.g., here, we combine boxplots (which show the median) and points (which show the mean).
ggplot(data = penguins) +
  geom_boxplot(mapping = aes(x = sex,
                         y = bill_length_mm)) +
  stat_summary(mapping = aes(x = sex, 
                             y = bill_length_mm), 
               fun = "mean", 
               geom = "point")

# Combining 2 geom layers in one picture: 
# E.g., here, we combine violin plots and box plots per sex
ggplot(data = penguins, 
       mapping = aes(x = sex,
                     y = bill_length_mm)) +
  geom_violin(trim = FALSE,
              draw_quantiles = c(0.25, 0.5, 0.), fill="grey") + 
  geom_boxplot(width=0.1)


# bill_length (numerical, binned in a histogram) stacked by per sex (categorical)
# Note:   Here, the second variable (sex) is not on the y-axes, but on the color channel.
#         The y-axes is already used up by the frequency count of the histogram plot
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

# Combining 2 geom layers in one picture:
# Here, a scatterplot and a polynomial trendline are combined (plottet on top of each other)
#   - scatterplot: bill length vs. body mass, colored by species
#   - polynomoial trendline: bill length vs. body mass, colored by per species 
ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm,
                     color = species)) +
  geom_point() +
  geom_smooth()

# If we add the color channel only to geom:point(), 
# the trendline will not be colored by species. 
# It will show the overall trend for all species together.
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

# Instead of using stat_summary() to compute a summary statistics we want to display, 
# we can alternatively use stat().
# Note: stat() provides a low-level interface to define any statistical transformation.
#       You must use WITHIN the aestetic mapping. It is not a standalone layer, 
#       but a function that you can use to specify the type of statistical transformation you want to apply to the data before plotting it.
# E.g., here we use it to calculate percentages.
# Note the change of scale in the y-axes!
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = island, 
                         y = stat(count/max(count)*100))) 



# ====== Mapping versus Setting

# MAPPING the value of species to the color channel
ggplot(data = penguins) +
  geom_point(mapping = aes(x = body_mass_g,
                           y = bill_length_mm,
                           color = species)) 

# SETTING the color to the fixed value "red" 
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


