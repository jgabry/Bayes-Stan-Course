library("rstan")
setwd(file.path(rstudioapi::getActiveProject(),
                "JG_tuesday", "am", "code", "runtime-errors"))


# runtime-error-1 ---------------------------------------------------------

# Compile the model
mod <- stan_model("runtime-error-1.stan")

# Check the error you get when fitting the model using 'data1'
data1 <- list(N = 4, y = c(0, 1, 1, 2))
fit1 <- sampling(mod, data = data1)

# Check the error you get when fitting the model using 'data2'
data2 <- list(N = 4, y = c(0, 1))
fit2 <- sampling(mod, data = data2)

# Create 'data3' so that the model runs without error
data3 <- # create one that will work
fit3 <- sampling(mod, data = data3)

# runtime-error-2 ---------------------------------------------------------
stan("runtime-error-2.stan")

# runtime-error-3 ---------------------------------------------------------
stan("runtime-error-3.stan")
