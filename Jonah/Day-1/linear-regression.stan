data {
  int<lower=1> N; // Sample size
  int<lower=1> K; // Number of predictors
  vector[N] y;
  matrix[N, K] X;
}
parameters {
  real alpha;
  vector[K] beta;
  real<lower=0> sigma;
}
model {
  // (log) likelihood
  y ~ normal(X * beta + alpha, sigma);
  
  // (log) priors
  beta ~ normal(0, 10);
  alpha ~ normal(0, 10);
  sigma ~ cauchy(0, 10);
}
generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(X[n] * beta + alpha, sigma);
}
