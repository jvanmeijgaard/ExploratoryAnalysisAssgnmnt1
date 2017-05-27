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

# To create plot 3 - use plot function - and then add points
png(filename='ExploratoryAnalysisAssgnmnt1/plot3.png', width=480, height=480)
with(consumption,{
    plot(DateTime, Sub_metering_1, type='l', xlab=NULL, ylab='Energy sub metering')
    points(DateTime, Sub_metering_2, type='l', col = 'red')
    points(DateTime, Sub_metering_3, type='l', col = 'blue')
    legend('topright', lty=c(1,1), col=c('black','red','blue'), legend=names(consumption)[grepl('Sub',names(consumption))])
})
dev.off()


