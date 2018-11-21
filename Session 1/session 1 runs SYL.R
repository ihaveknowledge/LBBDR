setwd('//dsfin/corpcom/LBBDR/TNG/Session 1')
getwd()
df <- read.csv('session1_2017.csv')
head(df)
df$PHper1000_2017 <- (df$ph2017 / df$population2017) * 1000
boxplot(df$PHper1000_2017, main='Public Houses per 1,000 population (2017)', ylab='Rate per 1,000 population')
df <- df[-1, ]
barplot(height = df$PHper1000_2017, names.arg = substr(df$area, 1, 3), main = 'Number of Public Houses per 1,000 residents (2017)', xlab='London Borough Truncated', ylab='Rate per 1,000 residents')
