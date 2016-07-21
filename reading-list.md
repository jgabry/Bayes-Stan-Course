---
title: "Reading list & more"
output:
  html_document:
    toc: yes
---

# Reproducible research using Stan

There was actually a recent blog post about this:

* [Reproducible Research with Stan, R, knitr, Docker, and Git (with free GitLab hosting)](http://andrewgelman.com/2016/07/07/reproducible-research-with-stan-and-docker-with-free-gitlab-hosting/)

# Stan tutorials

There are various tutorials available on the [Stan website](http://mc-stan.org/documentation)
and include tutorials on modern Bayesian tools for time series analysis,
an intro to Stan for economists. Some of these are written documents and
there are also some videos.

# Stan case studies

These are all available at the [Stan website](http://mc-stan.org/documentation/case-studies.html). Here's a sample
of the available case studies (there are a lot more than this):

* [_A Primer on Bayesian Multilevel Modeling using PyStan_](http://mc-stan.org/documentation/case-studies/radon.html)
* [_Reparameterization: MLE vs. Bayes_](http://mc-stan.org/documentation/case-studies/mle-params.html)
* [_Pooling with Hierarchical Models for Repeated Binary Trials_](http://mc-stan.org/documentation/case-studies/pool-binary-trials.html)
* [_Multiple Species-Site Occupancy Model_](http://mc-stan.org/documentation/case-studies/dorazio-royle-occupancy.html)
* [_Soil Carbon Modeling_](http://mc-stan.org/documentation/case-studies/soil-knit.html)


# Introductory-level books

#### McElreath

Richard's book Statistical Rethinking essentially covers a lot of the ideas
developed in Andrew's books and papers but presents them for an audience with
less prior statistical and mathematical background (e.g. barely any calculus or
linear algebra). I highly recommend this book but there are
several reasons why you might want to use the `rstan` and `rstanarm` R packages
instead of the `rethinking` package (which uses Stan internally) that Richard
designed for the book: we (Stan developers) have not validated any of the code
underlying `rethinking`, nor have we verified the Stan code that `rethinking`
generates, nor can we guarantee that the `rethinking` package will continue to
be maintained. That said, it does look like a cool package.

* [Statistical Rethinking: A Bayesian Course with Examples in R and
Stan](http://xcelab.net/rm/statistical-rethinking/)

#### Gelman and Hill

This book is full of great material but was written before Stan. We now
recommend using our [`rstanarm`](http://mc-stan.org/interfaces/rstanarm) package
to fit the models instead of the `lme4` package used in the book (switiching is
easy because you can use the same model formulas). We also recommend using Stan
instead of Bugs (which was the best option at that time) for the more advanced
models towards the end of the book.

* [Data Analysis Using Regression and Multilevel/Hierarchical Models](http://www.stat.columbia.edu/~gelman/arm/)

#### Kruschke

I haven't read this, but the latest edition also includes content on Stan

* [Doing Bayesian Data Analysis](https://sites.google.com/site/doingbayesiandataanalysis/)



# Model comparison and variable selection

Some (freely available) papers written (or recommended) by various members of
the Stan team:

* [Practical Bayesian model evaluation using leave-one-out cross-validation and WAIC](http://arxiv.org/abs/1507.04544) (already integrated with `rstanarm` and
can be used with models fit using `rstan`)
* [Projection predictive variable selection using Stan+R](http://arxiv.org/abs/1508.02502) (this will be implemented in our
`rstanarm` package soon)
* [Projection predictive model selection for Gaussian processes](http://arxiv.org/abs/1510.04813)

# Papers Using Stan

For a (not nearly exhaustive) sample of how Stan is being used by researchers
in various fields check out the **Papers Using Stan** section at http://mc-stan.org/citations/.


# Stan-related R packages

#### Written & maintained by Stan developers
* [`rstan`](http://mc-stan.org/interfaces/rstan.html) (R interface to Stan)
* [`rstanarm`](http://mc-stan.org/interfaces/rstanarm.html) (R-style modeling
interface to Stan for applied regression models, e.g. with `formula` and `data.frame`, also a _lot_ of vignettes and thorough documentation)
* [`shinystan`](http://mc-stan.org/interfaces/shinystan.html) (GUI for exploring Stan models)
* [`loo`](http://mc-stan.org/interfaces/loo.html) (model comparison, CV)

#### Written & maintained by Stan users
I think there are more than just these two, but I think these are the most developed

* [`brms`](https://github.com/paul-buerkner/brms)
* [`rethinking`](https://github.com/rmcelreath/rethinking)


# Hamiltonian Monte Carlo (HMC) in depth

#### Radford Neal's intro to HMC

Freely available chapter from the Handbook of Markov Chain Monte Carlo:

* [_MCMC Using Hamiltonian Dynamics_](http://www.mcmchandbook.net/HandbookChapter5.pdf)

#### David Mackay's book Information Theory, Inference, and Learning

There is a nice chapter on efficient Monte Carlo methods, including HMC. The
book is free (link below) and HMC covered in chapter 30. There's also a bit more
on HMC in some later chapters:

* [_Information Theory, Inference, and Learning_](http://www.inference.phy.cam.ac.uk/itila/book.html)

#### Matt Hoffman and Andrew Gelman's original paper on NUTS (No-U-Turn Sampler)

This describes the particular variant of HMC used by Stan, which allows Stan to
avoid some of the manual tuning required for HMC. There have been some
modifications to the NUTS algorithm that we use for Stan since the paper came
out, but the important stuff is in the paper:

* [_The No-U-Turn Sampler: Adaptively Setting Path Lengths in Hamiltonian Monte Carlo_](http://www.stat.columbia.edu/~gelman/research/published/nuts.pdf)

#### Michael Betancourt's papers

Michael Betancourt, one of the Stan developers, has *a lot* of papers on both
the theory behind HMC and the challenges that arise in practice. Some of these
papers are *very* challenging reads. The first one listed below is probably
the simplest and talks about parameterizations of hierarchical models.

* [_Hamiltonian Monte Carlo for Hierarchical Models_](http://arxiv.org/abs/1312.0906)

* [_The Geometric Foundations of Hamiltonian Monte Carlo_](http://arxiv.org/abs/1410.5110)

* [_On the Geometric Ergodicity of Hamiltonian Monte Carlo_](http://arxiv.org/abs/1601.08057)

* [_Optimizing the Integrator Step Size for Hamiltonian Monte Carlo_](http://arxiv.org/abs/1411.6669)

* [_Identifying the Optimal Integration Time in Hamiltonian Monte Carlo_](http://arxiv.org/abs/1601.00225)
