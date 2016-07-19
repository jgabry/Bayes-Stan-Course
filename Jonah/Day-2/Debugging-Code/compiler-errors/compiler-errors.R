library("rstan")

setwd(file.path(rstudioapi::getActiveProject(),
                "JG_tuesday", "am", "code", "compiler-errors"))


stanc("compiler-error-1.stan")
stanc("compiler-error-2.stan")
stanc("compiler-error-3.stan")
