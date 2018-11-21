#--- clean working environment --------------------
rm(list=ls())

#--- setwd ----------------------------------------
setwd('//dsfin/corpcom/LBBDR/TNG/Session 2')

#--- load data ------------------------------------
#load in .tsv file using read.table
#provide the following arguements

#file = 'homework session 2.tsv'
#sep = '\t'         -- this is a tab seperated file
#header = TRUE      -- the first row in the data contains the headers

df <- read.table()

#--- look at the head of the data ------------------


#--- explore summary statistics using summary() ----


#--- Start by exploring X2, Y2 ---------------------

#plot X2, Y2


#correlation X2, Y2


#create a linear model Y2 ~ X2 and save as model


#add the linear model to the plot using abline() and passing model as the argument


#--- Homework questions -----------------

# 1. Do the linear models of each dataset differ

# 2. Are there any similarities between the summary statistics across the four datasets

# 3. What do you see when you visualise dataset X1,Y1 


# --- FIN ---------------------------