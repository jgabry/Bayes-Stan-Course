// Hierarchical meta-analysis model
// Non-centered parameterization

data {
  int<lower=0> J;          // number of schools
  real y[J];               // estimated treatment effect (school j)
  real<lower=0> sigma[J];  // std err of effect estimate (school j)
}
parameters {
  vector[J] theta_raw;
  real mu;
  real<lower=0> tau;
}
transformed parameters {
  vector[J] theta; 
  theta = mu + tau * theta_raw;
}
model {
  // Data model
  y ~ normal(theta, sigma);
  
  // Priors
  theta_raw ~ normal(0, 1);  // implies theta ~ normal(mu, tau)
  tau ~ cauchy(0, 10);
  // can also put prior on mu
}
