# 4. Simple way to scrape website by rvest

####Contains 
 - scrape web page with table in it
 - Scrape mutiple web pages
 - Using "str_trim" to clean up strings

================
```
## Scraping webpage :
read_html(url) %>% html_nodes("css tag") %>% html_text()

## Setting break time to avoid being banned by the website while crawling multiple pages... 
Sys.sleep(runif(1,2,4))
```



[Code Example](https://github.com/r3dmaohong/R_Notes/blob/master/4.%20Simple%20way%20to%20scrape%20website%20by%20rvest/rvest.R)