library(rstan)

## show minimal example of input, output
data <- list(N = 1000, y = rbinom(1000, 1, 0.7))
utils::download.file("http://www.stat.columbia.edu/~vincent/bernoulli.stan", "bernoulli.stan")

bernoulli.0 <- stan("bernoulli.stan", data = data)

unlink("bernoulli.stan")

bernoulli.0

traceplot(bernoulli.0, "theta")

theta <- extract(bernoulli.0, "theta")$theta

theta[1:5]

hist(theta, freq = FALSE)
curve(dbeta(x, sum(data$y) + 1, data$N - sum(data$y) + 1),
            0, 1, add = TRUE)


## manually code up the model
N <- 10
y <- c(0,1,0,0,0,0,0,0,0,1)

data <- list(N = N, y = y)

bernoulli_code.1 <- "
data {
 int N;
 int y[N];
}
parameters {
  real theta;
}
model {
  // p(y) = theta^y * (1 - theta)^(1 - y)
  for (n in 1:N)
    target += y[n] * log(theta) + (1 - y[n]) * log(1 - theta);
}"


bernoulli.1 <- stan(model_code = bernoulli_code.1, data = data)

bernoulli.1

bernoulli_code.2 <- "
data {
  int N;
  int y[N];
}
parameters {
  real<lower = 0, upper = 1> theta;
}
model {
  for (n in 1:N)
    target += bernoulli_lpmf(y[n] | theta);
}"
bernoulli.2 <- stan(model_code = bernoulli_code.2, data = data)

bernoulli.2

bernoulli_code.3 <- "
data {
  int N;
  int y[N];
}
parameters {
  real<lower = 0, upper = 1> theta;
}
model {
  target += bernoulli_lpmf(y | theta);
}"
bernoulli.3 <- stan(model_code = bernoulli_code.3, data = data)

bernoulli.3


## now look at analyzing results, generating quantities

theta <- extract(bernoulli.3, "theta")$theta

mean(theta)
quantile(theta, c(0.025, 0.975))

mean(theta > 0.5)

y_rep.1 <- rbinom(data$N, 1, theta[1])

## exercise, compute posterior probability that new data has exactly 5 ones
y_rep <- sapply(theta,
  function(x) rbinom(data$N, 1, x))
total_rep <- apply(y_rep, 2, sum)
mean(total_rep == 5)
mean(total_rep >= 5)

bernoulli_code.4 <- "
data {
  int<lower = 0 > N;
  int<lower = 0, upper = 1> y[N];
}
parameters {
  real<lower = 0, upper = 1> theta;
}
model {
  y ~ bernoulli(theta);
}
generated quantities {
  int total_rep;
  {
    // scoping like this prevents y_rep from being saved
    int y_rep[N];
    for (n in 1:N)
      y_rep[n] = bernoulli_rng(theta);
    total_rep = sum(y_rep);
  }
}"
bernoulli.4 <- stan(model_code = bernoulli_code.4, data = data)

bernoulli.4

total_rep <- extract(bernoulli.4, "total_rep")$total_rep


## consider priors on theta
empty <- list(N = 0, y = integer(0))
bernoulli.empty <- stan(model_code = bernoulli_code.3, data = empty)

hist(extract(bernoulli.empty, "theta")$theta)

bernoulli_code.5 <- "
data {
  int<lower = 0 > N;
  int<lower = 0, upper = 1> y[N];
}
parameters {
  real<lower = 0, upper = 1> theta;
}
model {
  y ~ bernoulli(theta);
  theta ~ normal(0.5, 0.2);
}"

bernoulli.5 <- stan(model_code = bernoulli_code.5, data = data)

hist(extract(bernoulli.5, "theta")$theta)

bernoulli_code.6 <- "
data {
  int<lower = 0 > N;
  int<lower = 0, upper = 1> y[N];
}
parameters {
  real<lower = 0, upper = 1> theta;
}
model {
  y ~ bernoulli(theta);
  theta ~ beta(5, 5);
}"
bernoulli.6 <- stan(model_code = bernoulli_code.6, data = data)

par(mfrow = c(1, 2))
hist(extract(bernoulli.3, "theta")$theta, main = "Flat", xlab = expression(theta))
hist(extract(bernoulli.6, "theta")$theta, main = "Beta(5, 5)", xlab = expression(theta))


cat(get_cppcode(bernoulli.6@stanmodel))


## do a linear model example
N <- 50
x <- runif(N, -100, 100)
y <- 10 + 5 * x + rnorm(N, 0, 20)
plot(x, y)

data <- list(N = N, x = x, y = y)

linear_model_code <- "
data {
  int<lower = 0> N;
  vector[N] y;
  vector[N] x;
}
parameters {
  real alpha;
  real beta;
  real<lower = 0> sigma;
}
model {
  y ~ normal(alpha + beta * x, sigma);
}"

linear_model.1 <- stan(model_code = linear_model_code, data = data)

## use some "real" data

voting <- read.csv("http://www.stat.columbia.edu/~vincent/voting.csv")
data$N <- nrow(voting)
data$x <- voting$height
data$y <- log(voting$income)

voting.1 <- stan(model_code = linear_model_code, data = data)

