// Hierarchical meta-analysis model
// Centered parameterization

data {
  int<lower=0> J;          // number of schools
  real y[J];               // estimated treatment effect (school j)
  real<lower=0> sigma[J];  // std err of effect estimate (school j)
}
parameters {
  // "local" parameters
  vector[J] theta;
  
  // "global" parameters
  real mu; // mean
  real<lower=0> tau; // sd
}
model {
  // Data model
  y ~ normal(theta, sigma);
  
  // Priors 
  theta ~ normal(mu, tau);
  tau ~ cauchy(0, 10);
  // can also put prior on mu
}
