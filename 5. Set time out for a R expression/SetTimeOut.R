##Set time out

library(rvest)
## Use the old version
#packageurl <- "https://cran.r-project.org/src/contrib/Archive/R.utils/R.utils_1.29.8.tar.gz"
#install.packages(packageurl, repos=NULL, type="source")
#packageVersion("R.utils")
library(R.utils)

##Demo "evalWithTimeout"
stopFun <- function(x){
  Sys.sleep(x)
  return(paste0("sleep for ", x, " sec(s)..."))
}

evalWithTimeout(stopFun(2), timeout = 3, onTimeout = "error")
#[1] "sleep for 2 sec(s)..."
evalWithTimeout(stopFun(3), timeout = 3, onTimeout = "error")
#Error: reached elapsed time limit

##Demo "evalWithTimeout" with trycatch
timeoutErrorTest <- function(x){
  tryCatch({
    evalWithTimeout(stopFun(x), timeout = 3, onTimeout = "error")
  }, 
  TimeoutException = function(ex){ 
    print("Time out!")
  }, 
  error = function(e) {
    print("Error!")
  })
}

timeoutError(1)
#[1] "sleep for 1 sec(s)..."
timeoutError(3)
#[1] "Time out!"
timeoutError()
#[1] "Error!"

## Set time out for rvest crawler
url <- "http://stackoverflow.com/questions/tagged/r"
title <- evalWithTimeout(
  read_html(url) %>% html_nodes("title") %>% html_text()
  , timeout = 30, onTimeout = "error")

## Additionally...
## Set time out : RSelenium
#remDr$setTimeout(type = "page load", milliseconds = 30000)
