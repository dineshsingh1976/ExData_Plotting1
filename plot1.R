# set working directory (change this to fit your needs)
setwd('C:/Users/prisha/Documents/R/R-3.2.0/exdata-data-household_power_consumption')

# make sure the plots folder exists
if (!file.exists('plots')) {
  dir.create('plots')
}

# load data
source('get_clean_data.R')
 
# open device
png(filename='plot1.png',width=480,height=480,units='px')

# plot data
hist(power.consumption$GlobalActivePower,main='Global Active Power',xlab='Global Active Power (kilowatts)',col='red')

# Turn off device
x-dev.off()