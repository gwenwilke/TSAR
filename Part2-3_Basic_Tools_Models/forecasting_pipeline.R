# Forecasting Pipeline

library(fpp3)



###########  1. Define training set 

train <- aus_production %>%  
  filter_index("1992 Q1" ~ "2006 Q4") 



########### 2. Define test set

test <- aus_production %>%  
  filter_index("2007 Q1" ~ "2010 Q2")   # 14 quarters in the test set



###########  3. Train model on the training set 

trained_model <- train %>% model(mean = MEAN(Beer))     
# trained_model <- train %>% model(drift = RW(Beer ~ drift()))     
#trained_model <- train %>% model(naive = NAIVE(Beer))    
#trained_model <- train %>% model(snaive = SNAIVE(Beer))    


# Inspect the model:
trained_model %>% tidy()                                # shows the model parameters 
trained_model %>% augment()                             # shows the fitted values and the residuals

# Plot the model: 
#   - Fitted values (blue dashed line)
#   - Ground truth (training data)
trained_model %>% augment() %>% 
                  autoplot(.fitted, colour="blue", linetype="dashed") + autolayer(train, Beer)   



###########  4. Forecast model on the test set

trained_model %>% forecast(h=14) # fable (forecast table): shows the forecasted values and the forecast distribution


# Plot the forecast:
#   - Original data (training set)
#   - Forecasted values 
trained_model %>% forecast(h=14) %>% autoplot(train) 

# Add the ground truth:
#   - Original data (training set)
#   - Forecasted values 
#   - Ground truth (test data)
trained_model %>% forecast(h=14) %>% autoplot(train) + autolayer(test, Beer) 

# Add the fitted values:
#   - Original data (training set)
#   - Fitted values 
#   - Forecasted values 
#   - Ground truth (test data)
aug <- trained_model %>% augment()
trained_model %>% forecast(h=14) %>% autoplot(train) + autolayer(test, Beer) + autolayer(aug, .fitted, colour="blue", linetype="dashed")


# Inspect the prediction intervals:
trained_model %>% forecast(h=14) %>% hilo()
