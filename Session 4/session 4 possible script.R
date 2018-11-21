rm(list=ls())

setwd('//dsfin/corpcom/LBBDR/TNG/Session 4')

library(dplyr)

# read in data from csv file
London <- read.csv("london_districts.csv", stringsAsFactors = FALSE)
head(London)
str(London)

boxplot(London[-1:-2])

names(London)

London %>% select(Life_Male, Life_Female) %>% boxplot()

London %>% select(Name, Life_Male, Life_Female) %>% 
  mutate(MLE = Life_Male == max(Life_Male),
         FLE = Life_Female == max(Life_Female)) %>% filter(MLE == TRUE | FLE == TRUE)

model1 <- lm(Life_Male ~ ., data = London[3:18])

summary(model1)

model2 <- lm(Life_Male ~ Smoking + Benefits + Age65plus, data = London)

summary(model2)

new.data <- data.frame('Smoking' = c(30, 30, 20, 20, 20), 
                       'Benefits' = c(200, 240, 200, 240, 240),
                       'Age65plus' = c(29.5, 29.5, 20, 20, 29.5))

predict(model2, newdata = new.data)


with(London, plot(Smoking, Life_Male))
abline(lm(Life_Male ~ Smoking, data = London), col='red')

cor(London[3:8])

corrgram(London[8:14], main = "Correlogram of Marketing Data, Unordered", 
         lower.panel = panel.conf, upper.panel = panel.ellipse, 
         diag.panel = panel.minmax, text.panel = panel.txt)
?corrgram

library(corrgram)
