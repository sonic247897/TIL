library("ggplot2")
library("dplyr")
dfmidwest <- as.data.frame(midwest)
nrow(dfmidwest)
head(dfmidwest)

dfmidwest <- rename(dfmidwest, total=poptotal, asian=popasian)
head(dfmidwest)

dfmidwest$asianPercent <- (dfmidwest$asian/dfmidwest$total)*100
head(dfmidwest)
qplot(data=dfmidwest, x =county, y= asianPercent, geom = "line")

asianPct_avg <- mean(dfmidwest$asianPercent)
asianPct_avg
dfmidwest[,"overAvg"] <- ifelse(test = dfmidwest$asianPercent > asianPct_avg, yes="large", no="small")
dfmidwest

table(dfmidwest$overAvg)
qplot(dfmidwest$overAvg)
