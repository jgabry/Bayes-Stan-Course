# Bayes-Stan-Course
Bayes/Stan Short Course NYC


### Some things to install

During one of the breaks before the afternoon session, please run the following code in R to install a few things we'll use later:

```r
# install 'devtools' and then 'bayesplot'
if (!require("devtools")) install.packages("devtools")
library("devtools")
install_github("jgabry/bayesplot")

# also install 'shinystan'
install.packages("shinystan")
```

### RStudio preview version 

RStudio has syntax highlighting for Stan programs, but if you want to get Stan syntax highlighting for the _latest_ version of Stan, you can install the preview version of RStudio from here:

http://www.rstudio.com/products/rstudio/download/preview
