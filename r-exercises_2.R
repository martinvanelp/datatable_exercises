# Beyond the basics of data.table: Smooth data exploration ----
# https://www.r-exercises.com/2017/09/06/beyond-the-basics-of-data-table-smooth-data-exploration/

library(data.table)

1
"Load the data available to your working environment using fread(), don't forget to load the data.table package first."
"https://www.r-exercises.com/wp-content/uploads/2017/08/toy_cor.csv"
toy_cor = fread(file = "./data.table/toy_cor.csv")

2
"Using one line of code print out the most common car model in the data, and the number of times it appears."
toy_cor[, .N, by = Model][N == max(N)]
# toy_cor[, .N, by = Model][order(N)][.N]
# toy_cor[, .N, by = Model][which.max(N)]

3
"Print out the mean and median price of the 10 most common models."
toy_cor[, .(.N, mean(Price), median(Price)), 
        by = Model][order(N, decreasing = TRUE)][1:10]
# toy_cor[, .(.N, medianPrice = median(Price), meanPrice = mean(Price)),
#         by = Model][order(-N)][1:10]

4
"Delete all columns that have Guarantee in its name."
toy_cor[ , .SD, .SDcols = !patterns('Guarantee')] 

5
"Add a new column which is the squared deviation of price from the average price of cars the same color."
toy_cor[, dPrice2 := (Price - mean(Price))^2, by = Color]
# toy_cor[, sq_dev_bycol := (Price - mean(Price))^2,  by = Color]

6
"Use a combintation of .SDcols and lapply to get the mean value of columns 18 through 35."
lapply(toy_cor[, .SD, .SDcols = 18:35], mean)
toy_cor[, lapply(.SD, mean), .SDcols = 18:35]

7
"Print the most common color by age in years?"
toy_cor[, .N, by = .(floor(Age_08_04/12), Color)][
    order(floor, N), .SD[.N], by = floor]

8
"For the dummy variables in columns 18:35 recode 0 to -1. You might want to use the set function here."
for (j in 18:35) {
    set(toy_cor,
        i = toy_cor[, which(.SD == 0), .SDcols = j],
        j = j,
        value = -1)
}

9
"Use the set function to add "yuck!" to the varible Fuel_Type if it is petrol. Just because."
set(toy_cor,
    i = toy_cor[, which(.SD == "Petrol"), .SDcols = "Fuel_Type"],
    j = "Fuel_Type",
    value = "Petrol yuck!"
)

10
"Using .SDcols and one command create two new variables, log of Weight and Price."
toy_cor[, (c("logWeight", "logPrice")) := lapply(.SD, log),
   .SDcols = c("Weight", "Price")]
