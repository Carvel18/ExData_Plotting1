# load_data.R

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "data.zip", method = "curl")
unzip("data.zip")

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   na.strings = "?", stringsAsFactors = FALSE)

# Subset to just 2007-02-01 and 2007-02-02
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Combine date and time into one datetime object
data$DateTime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

source("load_data.R")

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(data$DateTime, data$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power")

plot(data$DateTime, data$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")

plot(data$DateTime, data$Sub_metering_1, type="l", 
     ylab="Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", bty="n", col=c("black", "red", "blue"), lty=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data$DateTime, data$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global Reactive Power")
dev.off()