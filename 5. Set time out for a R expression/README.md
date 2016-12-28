# 5. Set time out for a R expression

####Contains 
 - Set time out for a R expression
 - Set time out with trycatch
 - Set time out for rvest crawler
 - Set time out for RSelenium crawler

================
```
## Set time out :
evalWithTimeout(Sys.sleep(4), timeout = 3, onTimeout = "error")

## Set time out with trycatch
tryCatch({
    evalWithTimeout(Sys.sleep(4), timeout = 3, onTimeout = "error")
    print("Done!")
  }, 
  TimeoutException = function(ex){ 
    print("Time out!")
  }, 
  error = function(e) {
    print("Error!")
  })
```

[Code Example](https://github.com/r3dmaohong/R_Notes/blob/master/5.%20Set%20time%20out%20for%20a%20R%20expression/SetTimeOut.R)