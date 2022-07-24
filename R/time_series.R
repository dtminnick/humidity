
library("forecast")

mape <- function(actual, prediction){
    
    mape <- mean(abs((actual - prediction)/actual)) * 100
    
    return(mape)
}

cases <- rnorm(42, mean = 1000, sd = 25)

cases.ts <- ts(cases, 
               start = c(2018, 1),
               end = c(2021, 6),
               freq = 12)

time <- time(cases.ts)

n.valid <- 6

n.train <- length(cases.ts) - n.valid

train.ts <- window(cases.ts, 
                   start = time[1],
                   end = time[n.train])

valid.ts <- window(cases.ts, 
                   start = time[n.train + 1],
                   end = time[n.train + n.valid])

naive_mod <- naive(train.ts, h = 6)

summary(naive_mod)

se_model <- ses(train.ts, h = 6)

summary(se_model)
