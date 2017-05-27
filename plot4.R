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

# To create plot 4 - create 4 plots together
png(filename='ExploratoryAnalysisAssgnmnt1/plot4.png', width=480, height=480)

par(mfcol=c(2,2))

#plot 1 - this is the same as previously plotted - upper left corner
with(consumption, plot(DateTime, Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowatts)'))

#plot 2 - this is the same as previously plotted - lower left corner
with(consumption,{
    plot(DateTime, Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
    points(DateTime, Sub_metering_2, type='l', col = 'red')
    points(DateTime, Sub_metering_3, type='l', col = 'blue')
    legend('topright', lty=c(1,1), col=c('black','red','blue'), legend=names(consumption)[grepl('Sub',names(consumption))])
})

#plot 3 - plot voltage - upper right corner
with(consumption, plot(DateTime, Voltage, type='l'))

#plot 4 - plot global reactive power - lower right corner
with(consumption, plot(DateTime, Global_reactive_power, type='l'))

dev.off()


