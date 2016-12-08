# 1. Extracting Tables from PDF

Extracting Tables from PDF using "tabulizer".

```
library(tabulizer)
extract_tables("PDF's url")
```

"extract_tables" will get a list.
In the list, it contains data frames seperated by PDF's page.

================
While facing problem installing "tabulizer", try this:

```
install.packages("ghit")
library(ghit)
ghit::install_github(c("leeper/tabulizerjars", "leeper/tabulizer"), INSTALL_opts = "--no-multiarch", dependencies = c("Depends", "Imports"))
```



[Code Example](https://github.com/r3dmaohong/R-Memo/blob/master/1.%20Extracting%20Tables%20from%20PDF/extract_table_from_PDF.R)