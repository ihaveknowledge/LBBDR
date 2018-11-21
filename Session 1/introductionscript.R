#LBBD R User Group Session 1

#--------Introduction to R-----------

#This is a comment

# a
# b
# c

#----Logical---------------------
class(T)
5 > 3
"john" == "john"
is.numeric(2)

#-----Numeric--------------------
5/2
2.4+1.2

#-----Integer--------------------
a <- as.integer(2)
class(a)
5L/2

#-----Character------------------
name = "john"
Name = 'John'
toupper(name)
tolower(Name)

#-----Vector---------------------
name <- c("Tom", "Richard", "Harold", "Barbara", "Edith", "Friday", "Norman")
ages <- c(23, 52, 34, 16, 42, 34, 24)
summary(ages)
name[2]

1:5
-10:10

#--------------Data Frame-----------------
name_age <- data.frame(name, ages)

#select using column name
name_age$name

#select using column or row number using [row,column]
name_age[,2] #column 2
name_age[2,] # row 2
name_age[2,2] # row 2, column 2

#select using column name and row number
name_age$name[3]

#-----Factor-----------------------------
class(name_age$name)
class(as.character(name_age$name))











#-----------------Practical session 1------------

#Set working directory
setwd("Y:\\Insight Hub\\LBBDr User Group\\Session 1")

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

#clear your environment
rm(list=ls())
