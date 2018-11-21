#LBBD R User Group Session 1


#-----------------Practical session 1------------

#Set working directory
setwd("\\\\Dsfin\\corpcom\\LBBDR\\TNG\\Session 1")

#Read csv file
session1_df <- read.csv("session1.csv")

#examine top 10 records
head(session1_df)

#produce summary statistics
summary(session1_df)

#explore spread of data using boxplot
boxplot(session1_df[4:5])

#the first record in the data frame (City of London) is a clear outlier
#Remove from dataset
session1_df <- session1_df[-1,]

#relook at the top 10 records, notice that City of London is no longer there
head(session1_df)

#recheck the summary statistics
summary(session1_df)

#a new boxplot will show that there are no outliers now that City of London has been removed
boxplot(session1_df[4:5])

#create new variables for number of public houses per 1000 residents for both years
session1_df$phper10002006 <- (session1_df$ph2006/session1_df$population2006)*1000
session1_df$phper10002016 <- (session1_df$ph2016/session1_df$population2016)*1000

#look at the top 10 rows with the new data present
head(session1_df)

#look at the summary statistics
summary(session1_df)

#explore the new variables using a boxplot, notice that there are some outliers
boxplot(session1_df[6:7])

#sort the data frame to show top 3 boroughs for 2016
head(session1_df[order(-session1_df$phper10002016), ], 3)

#save data frame to csv file
write.csv(session1_df, "session1_Output.csv")


#--- additional piece for people to work through -------------

df <- read.csv("session1_2017.csv", stringsAsFactors = F)

df <- df[-1,]

df$phper10002017 <- (df$ph2017/df$population2017)*1000
head(df[order(-df$phper10002017), ], 3)

barplot(height = df$phper10002017, names.arg = df$area, 1, 3)
barplot(height = df$phper10002017, names.arg = substr(df$area, 1, 3))

#clear your environment
rm(list=ls())
