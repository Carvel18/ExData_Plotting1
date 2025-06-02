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

png("plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()