## MCMC visualization
p <- function(theta) dlogis(theta)
r <- function() runif(1, -2, 2)
theta <- rep(NA, 10)

theta[1] <- 0

i <- 2
theta.st <- theta[i - 1] + r()

plot(1:(i - 1), theta[1:(i - 1)], type = "l", xlim = c(1, 10), ylim = c(-5, 5),
     ylab = expression(theta), xlab = "iteration")
points(1, theta[1], pch = 20)
points(i, theta.st, pch = 20, col = "red")

accept <- runif(1) < p(theta.st) / p(theta[i - 1])
accept
theta[i] <- if (accept) theta.st else theta[i - 1]

plot(1:i, theta[1:i], type = "l", xlim = c(1, 10), ylim = c(-5, 5),
     ylab = expression(theta), xlab = "iteration")
i <- i + 1

theta.st <- theta[i - 1] + r()
points(i, theta.st, pch = 20, col = "red")

accept <- runif(1) < p(theta.st) / p(theta[i - 1])
accept
theta[i] <- if (accept) theta.st else theta[i - 1]

plot(1:i, theta[1:i], type = "l", xlim = c(1, 10), ylim = c(-5, 5),
     ylab = expression(theta), xlab = "iteration")
i <- i + 1


m <- i
for (i in seq.int(m, 10)) {
  theta.st <- theta[i - 1] + r()
  points(i, theta.st, pch = 20, col = "red")
  
  browser()

  accept <- runif(1) < p(theta.st) / p(theta[i - 1])
  cat("accept: ", accept, "\n", sep = "")
  theta[i] <- if (accept) theta.st else theta[i - 1]
  
  plot(1:i, theta[1:i], type = "l", xlim = c(1, 10), ylim = c(-5, 5),
       ylab = expression(theta), xlab = "iteration")
}
