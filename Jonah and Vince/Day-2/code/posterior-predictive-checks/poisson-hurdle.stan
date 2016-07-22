// Poisson "hurdle" model with upper truncation

data {
  int<lower=1> N;
  int<lower=0> y[N];
}
transformed data {
  int U;
  U = max(y);
}
parameters {
  real<lower=0,upper=1> theta; // Pr(y = 0)
  real<lower=0> lambda; // Poisson parameter if y > 0
}
model {
  for (n in 1:N) {
    if (y[n] == 0)
      target += log(theta);  // log(Pr(y = 0))
    else {
      target += log1m(theta);  // log(Pr(y > 0))
      y[n] ~ poisson(lambda) T[1,U]; // truncated poisson
    }
  }
}
generated quantities {
  int y_rep[N];
  for (n in 1:N) {
    if (bernoulli_rng(theta))
      y_rep[n] = 0;
    else {
      int w; // temporary variable
      w = poisson_rng(lambda);
      while (w == 0 || w > U)
        w = poisson_rng(lambda);
        
      y_rep[n] = w;
    }
  }
}
