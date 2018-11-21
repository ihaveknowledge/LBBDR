
rm(list=ls())
setwd('//dsfin/corpcom/LBBDR/TNG/Session 4')



#read in data from csv file

London <- read.csv("london_districts.csv")


summary(London)
library(dplyr)

London %>% filter(Crime > 200) %>% select(Name)

boxplot(London)


London %>% select(Smoking) %>% boxplot()

model <- lm(Life_Male ~ Dom_Gardens, data = London)

London %>% select (Dom_Gardens, Life_Male) %>% plot()

abline(model)

cor(London[3:18])


model2 <-lm(Life_Male ~ Age65plus + Smoking + Deprivation, data  = London)

df <- data.frame('Age65plus' = c(12, 22, 32),
                'Smoking' = c(10, 15,20),
                'Deprivation' = c(21, 21, 21))
df
predict(model2, df)



str(London)

select
mutate
filter
group_by
summarise

London %>% select(Crime) %>% summary()

lm(Life_Male ~  Crime, data = London)

London %>% mutate(high_crime = ifelse(Crime >109, 1,0)) %>%
  
filter(Crime < 200) %>%
  
  group_by(high_crime) %>% summarise(count= n(), 
  mean_smoking = mean(Smoking),
  min_smoking = min(Smoking),
  max_smoke =max(Smoking))




  

