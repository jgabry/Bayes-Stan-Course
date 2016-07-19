data {
  int<lower = 0> N;
  int<lower = 0> y[N];
}
parameters {
  real<lower = 0> lambda;
}
model {
  y ~ poisson(lambda);
}
generated quantities {
  int y_rep[N];
  for (n in 1:N)
    y_rep[n] = poisson_rng(lambda);
}
