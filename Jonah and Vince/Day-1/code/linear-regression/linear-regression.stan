/* Linear Regression
 * with weakly informative priors
 */
data {
  int<lower=1> N;   // Sample size
  int<lower=1> K;   // Number of predictors
  vector[N] y;      // Outcome
  matrix[N, K] X;   // Predictors
}
parameters {
  real alpha;           // Intercept
  vector[K] beta;       // Slopes (regression coefficients)
  real<lower=0> sigma;  // Error SD
}
model {
  // Vectorized (log) likelihood
  // This is the same as a loop but more efficient
  y ~ normal(X * beta + alpha, sigma);
  
  // (log) priors
  alpha ~ normal(0, 10);
  beta ~ normal(0, 10);  // vectorized (each beta[k] is normal(0, 10))
  sigma ~ cauchy(0, 10); // half-Cauchy (<lower=0> constraint in parameters block)
}
generated quantities {
  // Draw from the posterior predictive distribution
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(X[n] * beta + alpha, sigma); // X[n] = entire nth row of X
}
