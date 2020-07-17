# Basics of data.table: Smooth data exploration ----
# https://www.r-exercises.com/2017/08/23/basics-of-data-table-smooth-data-exploration/

library(data.table)
library(AER)

1
"Load the data.table package. Furtermore (install and) load the AER package and run the command data(\"Fertility\") which loads the dataset Fertility to your workspace. Turn it into a data.table object."
data("Fertility")

dt <- as.data.table(Fertility)

2
"Select rows 35 to 50 and print to console its age and work entry."
dt[35:50, .(age, work)]

3
"Select the last row in the dataset and print to console."
dt[.N]

4
"Count how many women proceeded to have a third child."
dt[morekids=="yes", .N]

5
"There are four possible gender combinations for the first two children. Which is the most common? Use the by argument."
dt[, .N, by = .(gender1, gender2)]

6
"By racial composition what is the proportion of woman working four weeks or less in 1979?"
dt[, mean(work <= 4), by = .(afam, hispanic, other)]

7
"Use %between% to get a subset of woman between the age of 22 and 24 and calculate the proportion who had a boy as their firstborn."
dt[age %between% c(22,24), mean(gender1 == "male")]

8
"Add a new column, age squared, to the dataset."
dt[, age_sq := age^2]

9
"Out of all the racial composition in the dataset which had the lowest proportion of boys for their firstborn. With the same command display the number of observation in each category as well."
dt[, .(.N, prop_m = mean(gender1 == "male")), 
   by = .(afam, hispanic, other)][order(prop_m)]

10
"Calculate the proportion of women who have a third child by gender combination of the first two children?"
dt[, mean(morekids == "yes"), by = .(gender1, gender2)]
