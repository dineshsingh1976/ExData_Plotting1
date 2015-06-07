# setting working directory  
setwd('C:/Users/prisha/Documents/R/R-3.2.0/exdata-data-household_power_consumption')

# required packages
library(data.table)
library(lubridate)

# make sure the sources data folder exists
if (!file.exists('sourcedata')) {
  dir.create('sourcedata')
}

if (!file.exists('sourcedata/power_consumption.txt')) {

  file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  setInternet2(use = TRUE)
 
  download.file(file.url,'C:/Users/prisha/Documents/R/R-3.2.0/exdata-data-household_power_consumption/power_consumption.zip' )
   unzip('C:/Users/prisha/Documents/R/R-3.2.0/exdata-data-household_power_consumption/power_consumption.zip',exdir='sourcedata',overwrite=TRUE)

  # read the raw table and limit to 2 days
  variable.class<-c(rep('character',2),rep('numeric',7))
  
  power.consumption<-read.table('sourcedata/household_power_consumption.txt', header=TRUE,   sep=';',na.strings='?',colClasses=variable.class)
  
 power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]
   # clean up the variable names and convert date/time fields
  cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity',
          'SubMetering1','SubMetering2','SubMetering3')
  colnames(power.consumption)<-cols
  power.consumption$DateTime<-dmy(power.consumption$Date)+hms(power.consumption$Time)
  power.consumption<-power.consumption[,c(10,3:9)]
  
  # write a clean data set to the directory
  write.table(power.consumption,file='sourcedata/power_consumption.txt',sep='|',row.names=FALSE)
} else {
# check to see if the existing tidy data set exists; if not, make it...

    
  
  power.consumption<-read.table('sourcedata/power_consumption.txt',header=TRUE,sep='|')
  power.consumption$DateTime<-as.POSIXlt(power.consumption$DateTime)
 
}
# remove the large raw data set 
if (file.exists('sourcedata/household_power_consumption.txt')) {
  x<-file.remove('sourcedata/household_power_consumption.txt')
}