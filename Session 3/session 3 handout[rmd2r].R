#' ---	
#' title: "An Introduction to dplyr"	
#' author: "Phil Canham"	
#' date: "30th October 2018"	
#' output: word_document	
#' ---	
#' 	
#' # An Introduction to dplyr	
#' 	
#' Dplyr is one of the most useful R librarys for manipulating data. Think of it like a Swiss Army knife for data.	
#' 	
#' ## What does it do? 	
#' 	
#' Once we have a data set to work with, almost always it is not in the format,
#' or shape that we want it to be. In Excel we might for example use filters, formulas, lookups and pivot tables 
#' to make the data more useful. In R we can use the tools in the dplyr libarary to do these things and much more.	
#' 	
#' The other important thing to remember is that in R we normally provide a series of instructions
#'  which can then always be repeated and changed without having to start again each time,
#' so we have total control of what happens to the data, and the original data should never be permanently overwritten unless we explicity ask R to do this (which is generally bad practice)	
#' 	
#' The author of the library, Hadley Wickham,  has streamlined the process of data manipulation
#'  by following a common format using the concept of verbs, (ie words used to describe actions).
#'  The key dplyr verbs we will consider today are:	
#' 	
#' * filter	
#' * select	
#' * arrange	
#' * mutate	
#' * group_by	
#' * summarise	
#' 	
#' ### Lets try them out	
#' 	
#' ### First we clear the memory and any previously loaded work from R Studio	
#' 	
#' 	
rm(list= ls())	

#' ### Second, set the working directory to allow us to load in our data	
#' 	
#' 	
setwd('//dsfin/corpcom/LBBDR/TNG/Session 3')	
#' 	
#' 	
#' ### We can now load any librarys we are interested in using - here we load the dplyr library	

library(dplyr)	
# I also want to use another library which prints out much neater tables but we dont need to do this	
library(tibble)	
#' 	
#' 	
#' ### The next step is to read in the data from our csv file	
#' 	
#' 	
flights <- read.csv('session3a.csv')	
#' 	
#' ### and have a look at a summary of the data we have loaded	
#' 	
#' 	

summary(flights)	
#' 	
#' 	
#' This dataset contains all flights departing from Houston airports IAH (George Bush Intercontinental)	
#' and HOU (Houston Hobby) in 2011. The data comes from the Research and Innovation Technology	
#' Administration at the Bureau of Transportation statistics: http://www.transtats.bts.gov/DatabaseInfo.asp?DB_ID=120&Link=0	
#' 	
#' Information on the variables and the dataset can be found [here](https://cran.r-project.org/web/packages/hflights/hflights.pdf "Symbol Types")	
#' 	
#' There is also a pdf of this document in the working directory folder	
#' 	
#' 	
#' 	
#' 	
#' ### now check the top few rows of the data	
#' 	
#' 	
head(flights)	


x <- flights %>% 
  group_by(Month) %>% 
  summarise(count = n())

barplot(height = x$count , names.arg = x$Month, col = "lightblue")
#' 	
#' 	
#' 	
#' ### lets use the tibble library to convert our data frame into a format that prints out nicely	
#' 	
#' 	
flights <- as.tibble(flights) ## remember we dont need to do this step it is just for better display	
#' 	
#' 	
#' 	
#' ## filter: Keep rows matching criteria	
#' 	
#' * Base R approach to filtering forces you to repeat the data frame's name	
#' * dplyr approach is simpler to write and read	
#' * Command structure (for all dplyr verbs):	
#'     * first argument is a data frame	
#'     * return value is a data frame	
#'     * nothing is modified in place	
#' * Note: dplyr generally does not preserve row names	
#' 	
#' 	
# base R approach to view all flights on January 1

df <- flights[flights$Month==1 & flights$DayofMonth==1, ]	
#' 	
#' 	
#' 	
# dplyr approach	
# note: you can use comma or ampersand to represent AND condition	


df <- filter(flights, Month==1, DayofMonth==1)	
	
# use pipe for OR condition	##### NB THIS IS DIFFERENT TO THE PIPE OPERATOR
df <- filter(flights, UniqueCarrier=="AA" | UniqueCarrier=="UA")	
#' 	
#' 	
#' 	
# you can also use %in% operator	
filter(flights, UniqueCarrier %in% c("AA", "UA"))	
#' 	
#' 	
#' 	
#' ## select: Pick columns by name	
#' 	
#' * Base R approach is awkward to type and to read	
#' * dplyr approach uses similar syntax to `filter`	
#' * Like a SELECT in SQL	
#' 	
#' 	
# base R approach to select DepTime, ArrTime, and FlightNum columns	
flights[, c("DepTime", "ArrTime", "FlightNum")]	
 	
#' 	
#' 	
# dplyr approach	
select(flights, DepTime, ArrTime, FlightNum)	
	
# use colon to select multiple contiguous columns, and use `contains` to match columns by name	
# note: `starts_with`, `ends_with`, and `matches` (for regular expressions) can also be used to match columns by name	
select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))	
#' 	
#' 	
#' 	
#' ## "Chaining" or "Piping"	
#' 	
#' * One way to perform multiple operations in one line is by nesting but this can be quite complex to follow	
#' * We can also write commands in a natural order by using the `%>%` pipe operator (which can be pronounced as "then")	
#' 	
#' for example	
#' 	
#' eat food %>% drink beer	
#' 	
#' eat food THEN drink beer	
#' 	
#' 	
#' 	
# nesting method to select UniqueCarrier and DepDelay columns and filter for delays over 60 minutes	
filter(select(flights, UniqueCarrier, DepDelay), DepDelay > 600)	
#' 	
#' 	
#' 	
# chaining or piping method	
flights %>%	
    select(UniqueCarrier, DepDelay) %>%	
    filter(DepDelay > 600)	
#' 	
#' 	
#' * Chaining increases readability significantly when there are many commands	
#' * Operator is automatically imported from the [magrittr](https://github.com/smbache/magrittr) package	
#' * %>% Can be used to replace nesting in R commands outside of dplyr	
#' * the shortcut key is ctrl/shift M	
#' 	
#' 	
# create two vectors and calculate Euclidian distance between them. This is the less readable way without chaining	
x1 <- 1:5; x2 <- 2:6	
sqrt(sum((x1-x2)^2))	
#' 	
#' 	
#' 	
# chaining method	
(x1-x2)^2 %>% sum() %>% sqrt()	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
#' ## arrange: Reorder rows	
#' 	
#' 	
# base R approach to select UniqueCarrier and DepDelay columns and sort by DepDelay	
flights[order(flights$DepDelay), c("UniqueCarrier", "DepDelay")]	
#' 	
#' 	
#' 	
# dplyr approach	
flights %>%	
    select(UniqueCarrier, DepDelay) %>%	
    arrange(DepDelay)	
#' 	
#' 	
#' 	
# use `desc` for descending	
flights %>%	
    select(UniqueCarrier, DepDelay) %>%	
    arrange(desc(DepDelay))	
#' 	
#' 	
#' 	
#' 	
#' ## mutate: Add new variables	
#' 	
#' * Create new variables that are functions of existing variables	
#' 	
#' 	
# base R approach to create a new variable Speed (in mph)	
flights$Speed <- flights$Distance / flights$AirTime*60	
flights[, c("Distance", "AirTime", "Speed")]	
#' 	
#' 	
#' 	
# dplyr approach (prints the new variable but does not store it)	
flights %>%	
    select(Distance, AirTime) %>%	
    mutate(Speed = Distance/AirTime*60)	
	
# store the new variable	
flights <- flights %>% mutate(Speed = Distance/AirTime*60)	
	
# look at the names of the variables in flights	
	
names(flights) # we can see that "Speed" has no been added to the dataframe at the end	
	
#' 	
#' 	
#' 	
#' 	
#' ## summarise: Reduce variables to values	
#' 	
#' * Primarily useful with data that has been grouped by one or more variables	
#' * Think of pivot tables in Excel as a comparable idea	
#' * `group_by` creates the groups that will be operated on	
#' * `summarise` uses the provided aggregation function to summarise each group	
#' 	
#' 	
# base R approaches to calculate the average arrival delay to each destination	
head(with(flights, tapply(ArrDelay, Dest, mean, na.rm=TRUE)))	
head(aggregate(ArrDelay ~ Dest, flights, mean))	
#' 	
#' 	
#' 	
# dplyr approach: create a table grouped by Dest, and then summarise each group by taking the mean of ArrDelay	
flights %>%	
    group_by(Dest) %>%	
    summarise(avg_delay = mean(ArrDelay, na.rm=TRUE)) ### the na.rm = TRUE tells R to ignore any missing values  to avoid an error	
#' 	
#' 	
#' ### There are three other variants of `summarise`	
#' * _all affects every variable	
#' * _at affects variables selected with a character vector or vars()	
#' * _if affects variables selected with a predicate function:	
#' 	
#' ### So for example:	
#' * `summarise_at` allows you to apply the same summary function to multiple columns at once	
#' * Note: `mutate_at` is also available	
#' 	
#' 	
# for each carrier, calculate the percentage of flights cancelled or diverted	
flights %>%	
    group_by(UniqueCarrier) %>%	
    summarise_at(vars(Cancelled, Diverted), funs(mean))	
	
#### so the above can be read as "  for the dataframe called flights, group by the Unique Carrier id THEN summarise these groups	
# using the variables Cancelled and Diverted using the MEAN function "	
	
# we can also do more than one summary	
	
# for each carrier, calculate the minimum and maximum arrival and departure delays	
flights %>%	
    group_by(UniqueCarrier) %>%	
    summarise_at(vars(ArrDelay, DepDelay), funs(min, max), na.rm = TRUE)	
  	
#' 	
#' 	
#' 	
#' * Helper function `n()` counts the number of rows in a group	
#' * Helper function `n_distinct(vector)` counts the number of unique items in that vector	
#' 	
#' 	
# for each day of the year, count the total number of flights and sort in descending order	
flights %>%	
    group_by(Month, DayofMonth) %>%	
    summarise(flight_count = n()) %>%	
    arrange(desc(flight_count))	
	
# rewrite more simply with the `tally` function	
flights %>%	
    group_by(Month, DayofMonth) %>%	
    tally(sort = TRUE)	
	
# for each destination, count the total number of flights and the number of distinct planes that flew there	
flights %>%	
    group_by(Dest) %>%	
    summarise(flight_count = n(), plane_count = n_distinct(TailNum))	
#' 	
#' 	
#' * Grouping can sometimes be useful without summarising	
#' 	
#' 	
# for each destination, show the number of cancelled and not cancelled flights	
flights %>%	
    group_by(Dest) %>%	
    select(Dest,Cancelled) %>%	
    table() %>%  #### table() is actually a base R function	
    head(20) ### show top 20 rows	
#' 	
#' 	
