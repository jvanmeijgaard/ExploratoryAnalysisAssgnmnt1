#Exploratory Data Analysis - Assignment 1

setwd('~/Analytics/coursera')

#initialize the url and the zip filename
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fname <- "data/powerconsumption.zip"

## Download and unzip the dataset:
if (!file.exists(fname)){ 
    download.file(url, fname)
}

if (!file.exists("data/household_power_consumption.txt")) { 
    unzip(fname, exdir='data') 
}

consumption<-read.table('data/household_power_consumption.txt', 
                        header = TRUE,
                        colClasses = c('character','character',rep('numeric',7)),
                        na.strings = '?',
                        sep=';')

#subset to Feb 1-Feb 2, 2007
consumption <- subset(consumption,Date %in% c('1/2/2007','2/2/2007'))
consumption$DateTime <- with(consumption, strptime(paste(Date,Time),'%d/%m/%Y %H:%M:%S'))

consumption$Date <- as.Date(consumption$Date,'%d/%m/%Y')

# To create plot 2 - use plot function
png(filename='ExploratoryAnalysisAssgnmnt1/plot2.png', width=480, height=480)
with(consumption, plot(DateTime, Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowatts)'))
dev.off()


