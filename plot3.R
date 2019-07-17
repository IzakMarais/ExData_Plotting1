library(lubridate)

#load file
if (!file.exists("power.zip")) {
   download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip")
   unzip("power.zip")
}
power <- read.csv("household_power_consumption.txt", sep = ";",
    colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
    na.strings = "?")

#subset to desired dates
power <- power[power$Date == "1/2/2007"|power$Date == "2/2/2007", ]
#covert date and time into POSIXct
power$DateTime <- with(power, dmy_hms(paste(Date, Time, " ")))

#Plot the required graph
png("plot3.png")
plot(power$DateTime, power$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type="n", )
lines(power$DateTime, power$Sub_metering_1)
lines(power$DateTime, power$Sub_metering_2, col = "red")
lines(power$DateTime, power$Sub_metering_3, col = "blue")
legend("topright", 
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"), lty=c(1,1))
dev.off()