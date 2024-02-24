##############################################
# Time Series Analysis with R (TSAR)
# Self Study 1.2: Data Viz with ggplot2 and plotly
# gwendolin.wilke@fhnw.ch
##############################################



################ Task 1: Business Understanding  ################


#install.packages("tidyverse")
#install.packages("ggplot2")  
#install.packages("plotly")  
# install.packages("skimr")

library(tidyverse)
library("ggplot2")
library("plotly")
library(skimr)
library(Ggally)

# The data set mpg is included in the ggplot2 package. 
# Read the help page of the dataset mpg using help(mpg). It contains a data dictionary. 
# Try to understand what the attribute names mean.
# View the data using View(mpg).

help(mpg)
View(mpg)

################ Task 2: Data Understanding based on Summary Statistics ################

# Check the data type, class, attributes and dimensions of the mpg dataset.
# Use the functions class(), typeof(), attributes() and dim().
# Notice that mpg is loaded as a tibble (tbl) - a special kind of data frame (see later).

class(mpg) 
typeof(mpg)
attributes(mpg)
dim(mpg)

# Get a first impression of the structure of the data by calling
# glimpse(mpg) and summary(mpg)

glimpse(mpg)
summary(mpg)

# Now try the skim() function from the skimr library
# to get a better overview over the dataset
# Read the help page of the function skim()

skim(mpg)

# Now answer the following questions:
#   Data of how many cars are stored in the data set?
#       Number of rows             234
#   How many car attributes have been recorded in the mpg data set?
#       Number of columns          11
#   How many of them are numerical, how many categorical? 
#       6 categorical (type character), 5 numerical
#   Has the attribute type of drive train (front wheel, rear wheel, four wheel) been recorded for all cars in this data set, or are there any missing values for this attribute?
#       drv has 0 missing values
#   How many missing values does the whole data set contain?
#       No missing values
#   How many car models does this data set contain?
#       38 (for the attribute model, n_unique is 38)
#   How many manufacturers?
#       15
#   What is the minimum number of cylinders that occur in a car of this data set?
#       4 (in skim the min appears under "p0" - the zero percentile)
#   What is the range of highway miles per gallon of the cars in this data set? (range = max-min)
#       44-12 = 32
#   What is the mean and standard deviation?
#       mean of hwy = 23.4, sd of hwy = 5.95
#   What do you think do the column names min, max and empty of the character variables sections stand for?
#     Hint: Execute unique(mpg$manufacturer). Does it give you an idea?
unique(mpg$manufacturer)
#       min = 4 is the minimum number of characters of any manufacturer (audi, ford, jeep)
#       max = 10 is the maximum number of characters of any manufacturer (volkswagen, land rover)
#       empty says that no character strings are empty
#   Is the variable cty normally distributed? Is it skewed? (Read this off the output of skim.)
#       Skewness is a measure of the asymmetry of the probability distribution about its mean.
#       The little picture displayed by skim() suggests that cty is right skewed, since it shows a long tail on the right. 
#       Yet, the mean is a bit left of the median (p50). So it is not clear from the data we see here.
#   Now plot the histogram of cty to double check the sample distribution. Do you think it makes sense to check for outliers?
my_hist_cty <- ggplot(data = mpg) +
  geom_histogram(mapping = aes(x=cty))
ggplotly(my_hist_cty)
#       We see also here no clear picture: The mass of the distribution may actually be equally distributed about the mean of 16.9.
#       The little picture may have given a wrong impression bc. of the 2 outliers on the right. 
#       As a next step, we could remove the outliers and then check the distribution again.
#       But first lets check if these are indeed outliers or not... (We will learn in a later lecture how to remove them, if necessary.)
#   Create a boxplot of the variable cty. Make your boxplot interactive using ggplotly(). How many outliers do you see (according to the interquartile range (IQR) criterion)?
#   Hint: In the boxplot, outliers according to the IQR criterion are all points outside of the whiskers.
my_boxplot_cty <- ggplot(data = mpg) +
  geom_boxplot(mapping = aes(y=cty))
ggplotly(my_boxplot_cty)
#       There are 4 outliers visible in the boxplot: The two we recognized in the histogram (33 and 35: double check wit the histogram), and 2 more (28 and 29).
#   You can check if you are right using the function boxplot.stats(): Executing boxplot.stats(mpg$cty)$out will give you all outliers. Does it fit?
#   (Remember that the $ sign lets you access the single attributes of a data frame.)
boxplot.stats(mpg$cty)$out
#       No, it doesnt fit full: We have actually 5 outliers, bc. 28 appears twice. We couldn't see that in teh boxplot, since they are drawn on top of each other.



#   Driving in the city is probably not as smooth and uniform as highway driving. Does the data support this assumption? What do you think about that?
#     Hint: If the assumption is correct, the city miles per gallon should exhibit a higher variability than the highway miles per gallon. Is that so?
 


################ Task 3:Data Understanding by Visual EDA  ################

##### Lets play with ggplot!

#   I assume that the number of highway miles a car can go per gallon may depend functionally on the engine 
#   displacement of the car (e.g.,linearly, quadratically,...). Do you think our sample data will support 
#   my hypothesis? Check by visual inspection.
#       It looks as if the hypothesis is correct. There is a clear pattern discernible:
ggplot(data = mpg, 
       mapping = aes(x = displ, 
                     y = hwy)) +
  geom_point()

#   Add the variable year to your plot using color as a third dimension. What is going on with the legend here?
#       The legend shows a continuous scale, even though we actually only have 2 values of the year variable (1999 and 2008 - check with unique(mpg$year)).
#       The reason is that year has been imported as a numeric data type (check with skim(mpg) or str(mpg)), and this implies a continuous color scale
ggplot(data = mpg, 
       mapping = aes(x = displ, 
                     y = hwy,
                     color = year)) +
  geom_point()

#   Make the numerical variable year categorical by applying the function as.character to it. Then redo your plot.
my_mpg <- mpg
my_mpg$year <- as.character(my_mpg$year)

ggplot(data = my_mpg, 
       mapping = aes(x = displ, 
                     y = hwy,
                     color = year)) +
         geom_point() 

#   Overlay the scatterplot of my_mpg with a smoothed trendline using geom_smooth
#   Make sure that only *one* trendline is diplayed. 
ggplot(data = my_mpg, 
       mapping = aes(x = displ, 
                     y = hwy)) +
  geom_point(mapping = aes(color = year)) +
  geom_smooth()

#   Make your plot interactive using ggplotly().
my_plot_displ_hwy_year <- ggplot(data = my_mpg, 
       mapping = aes(x = displ, 
                     y = hwy)) +
  geom_point(mapping = aes(color = year)) +
  geom_smooth()

ggplotly(my_plot_displ_hwy_year)

#   Now create facets of this plot along the discrete variable year, but don't make it interactive for now.
#   Remark: Notice that year is used twice here. Though color-coding year is not necessary here, it still helps to stress this variable.
my_plot_displ_hwy_year +
  facet_wrap(~ year)

#   Now create facets of this plot along the discrete variable drv
my_plot_displ_hwy_year +
  facet_wrap(~ drv)

#   Now create facets of this plot along the discrete variable manufacturer.
#   What can you read out of these facet plots? Do some of them catch your eye?
#       - jeep, mercury and nissan look weird: the grey band around the trendline is very broad. 
#         It is the 95%-confidence interval around the trendline: a true observation will lie within this band around the trendline prediction with a probability of 95%.
#         It thus means that there is a lot of uncertainty involved in producing the trendline. (We don't know why yet, but we will come back to that later.)
#       - lincols, pontiac and subaru look weird as well: its not clear why no trendline is shown at all. (We will come back to this as well!)
#       - volkswagen is also bit weird. It makes an unmotivated dip at approximately x=2 that does not seem to correspond to any of the data points shown. (We will see the reason later.)

my_plot_displ_hwy_year +
  facet_wrap(~manufacturer)

#   Drop the manufacturer facets again. Instead create a grid of facets along the discrete variables drv and class
my_plot_displ_hwy_year +
  facet_grid(drv ~ class)

# Create a boxplot that visualizes the statistics of the variable highway miles per gallon.
ggplot(data = my_mpg, 
       mapping = aes(y = hwy)) +
  geom_boxplot() 

#   Now make one such boxplot per year. Make it interactive. What can you read out of it?
#       While the median didnt change much, the cars in 2008 show more variability in terms of highway miles per gallon:
my_boxplot_year_hwy <- ggplot(data = my_mpg, 
       mapping = aes(x = year, 
                     y = hwy)) +
  geom_boxplot(mapping = aes(color = year)) 

ggplotly(my_boxplot_year_hwy)

#   Now create facets of this plot along the variable drv. What new insight(s) does it give you?
#        Most cars with a front-wheel drive are more efficient than 4wds and rwds: they go farther per gallon of gas - independently of the year of manufacture.
#        Not surprisingly, most 4-wheel drive cars are more expensive in terms of gas needed per mile than front- or rear wheel drive cars.
#        Additionally, they show the biggest change from 1999 to 2008 in terms of variability (inter-quartiule range and whiskers).
my_boxplot_year_hwy_ia <- my_boxplot_year_hwy +
                                facet_wrap(~drv )

ggplotly(my_boxplot_year_hwy_ia)

#   Finally let’s take a look at ggpairs: Try to create a pairwise variable plot of mpg using ggpairs().
ggpairs(mpg)

# We get an error message here: the categorocal variable model has more than 15 levels (i.e. more than 15 different values.)
# Let's check if this is true: length(unique(mpg$model))
#     mpg$model addresses only the variable column of the data frame. 
#     Remember that every column of a data frame is a vector. 
#     We can apply the function unique() to see its unique values. 
#     The output is again a vector, namely the vector of unique values. (You can check with is.vector().)
#     Since unique(mpg$model) is again a vector, we can apply the function length() to count the number of unique values contained in it.
# Ok, the advice is to exclude the variable. Let's do that. You can do that by typing ggpairs(mpg[,-c(2)]).
#     Don't worry, we will learn how this world a bot later on in the lecture about data frames.
ggpairs(mpg[,-c(2)]) 

# You can contemplate the plot for a bit, trying to make sense of the different subplots, if you want. 
#     Don't get frustrated if you cannot figure everything out: there is a lot of information in this plot!

