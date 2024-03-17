# ====================================
# Time Series Analysis with R
# gwendolin.wilke@fhnw.ch
# This script contains code used in 
# Part 1, Lecture 4.2 tydr
# ==================================== 

library(tidyr)
library(data.table)
concerts <- fread("concert_tickets.csv")
band_data_wide <- concerts

# pivot_longer()

band_data_long <- band_data_wide %>% # data frame to gather from 
  pivot_longer(
    cols = -city, # specify the columns where you get the data from that you want to reshape
    names_to = "band", # from these columns, the column names go to a new column 'band'
    values_to = "price" # from these columns, the column values go to a new column 'price'
  )


# pivot_wider() - reconstruct original wide format

band_data_wide1 <- band_data_long %>% 
  pivot_wider(
    names_from = band,
    values_from = price
  )


# pivot_wider() - make a flipped (transposed) version of the original wide format

band_data_wide2 <- band_data_long %>% 
  pivot_wider(
    names_from = city,
    values_from = price
  )
