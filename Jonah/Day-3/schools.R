# Centered (cp) vs non-centered (ncp) parameterizations of hierarchical
# meta-analysis model

library("rstan")
library("shinystan")
library("ggplot2")
library("bayesplot")

# (P)RNG seed to pass to Stan 
SEED <- 1010


# Data --------------------------------------------------------------------
# Estimated treatment effects (and standard errors) of a test coaching program 
# conducted in eight schools
y <- c(28,  8, -3,  7, -1,  1, 18, 12)
sigma <- c(15, 10, 16, 11,  9, 11, 10, 18)


# Plot the data ---------------------------------------------------------
ggplot(data.frame(x = factor(1:length(y)), y, sigma), aes(x,y)) +
  geom_hline(yintercept = 0, col = "maroon", linetype = 2) +
  geom_pointrange(aes(ymin = y - sigma, ymax = y + sigma)) + 
  labs(y = expression(y %+-% sigma), x = NULL) +
  scale_x_discrete(labels = paste0("y[", 1:length(y), "]")) +
  theme_minimal(base_size = 14) + 
  coord_flip()


# Translate Stan program to C++ and compile -------------------------------
cp_mod <- stan_model("schools_cp.stan")
ncp_mod <- stan_model("schools_ncp.stan")

# Sample from posteriors --------------------------------------------------
standata <- list(y = y, sigma = sigma, J = length(y))
cp_fit1 <- sampling(cp_mod, data = standata, seed = SEED)
ncp_fit1 <- sampling(ncp_mod, data = standata, seed = SEED)

# cp has problems with divergences, low effective sample sizes (high
# autocorrelations)
launch_shinystan(cp_fit1) 

# ncp largely resolves these problems
launch_shinystan(ncp_fit1)

# Can also see the different geometry in pairs plot
mcmc_pairs(as.matrix(cp_fit1), pars = c("lp__", "tau"))
mcmc_pairs(as.matrix(ncp_fit1), pars = c("lp__", "tau"))


# Suppose y is scaled up by factor of 10 (without changing sigma)
standata2 <- standata
standata2$y <- 10 * standata2$y
cp_fit2 <- sampling(cp_mod, data = standata2, seed = SEED)
ncp_fit2 <- sampling(ncp_mod, data = standata2, seed = SEED)

# With 10*y as the outcome cp works better than ncp
launch_shinystan(cp_fit2) 
launch_shinystan(ncp_fit2)

mcmc_pairs(as.matrix(cp_fit2), pars = c("lp__", "tau"))
mcmc_pairs(as.matrix(ncp_fit2), pars = c("lp__", "tau"))


# Now also scale sigma (so both y and sigma are scaled up by factor of 10)
standata3 <- standata2
standata3$sigma <- 10 * standata3$sigma
cp_fit3 <- sampling(cp_mod, data = standata3, seed = SEED)
ncp_fit3 <- sampling(ncp_mod, data = standata3, seed = SEED)

# If sigma is also scaled up with y then ncp is better again
launch_shinystan(cp_fit3) 
launch_shinystan(ncp_fit3)

mcmc_pairs(as.matrix(cp_fit3), pars = c("lp__", "tau"))
mcmc_pairs(as.matrix(ncp_fit3), pars = c("lp__", "tau"))

