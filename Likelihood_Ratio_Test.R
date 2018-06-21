---
title: "Insight Project: Likelihood Ratio Test and Beyond"
output: html_notebook
---
```{r}
setwd("/home/ericbarnhill/Documents/code/insight/rtr")

# read in dfs
dfs = data.frame(
    term = character(),
    score = double(),
    period = integer()
)
for (n in 0:2) {
    filename = paste0("df_", n, ".csv")
    df = read.csv(filename, stringsAsFactors = F)
    term = df["key"]
    score = as.numeric(df["score"])
    period = rep(n, nrow(score))
}


```

