// Poisson "hurdle" model (similar to zero inflation) with 
// upper truncation

data {
  int<lower=0> N;
  int<lower=0> y[N];
}
transformed data {
  int U; // truncation point
  U = max(y);
}
parameters {
  real<lower=0,upper=1> theta;
  real<lower=0> lambda;
}
model {
  for (n in 1:N) {
    if (y[n] == 0)
      target += log(theta); 
    else {
      target += log1m(theta);
      y[n] ~ poisson(lambda) T[1, U];
    }
  }
}
generated quantities {
  int y_rep[N];
  
  for (n in 1:N) {
    if (bernoulli_rng(theta))
      y_rep[n] = 0;
    else {
      int x;
      x = poisson_rng(lambda);
      while(x == 0 || x > U)
        x = poisson_rng(lambda);
      y_rep[n] = x;
    }
  }
}
