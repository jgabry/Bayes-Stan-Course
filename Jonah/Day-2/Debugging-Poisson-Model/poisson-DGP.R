# Data generating process for simulating data for the poisson example

set.seed(223)

lambda <- 5 # poisson parameter
theta <- 0.2 # Pr(0)
U <- 7 # truncation point
N <- 500 # sample size 

y <- rep(NA, N)

for (n in 1:N) {
  if (rbinom(1, 1, theta) == 1) {
    y[n] <- 0
  } else {
    x <- rpois(1, lambda)
    while (x == 0 | x >= U)
      x <- rpois(1, lambda)
    y[n] <- x
  }
}

print(y)
