# Exploratory Data Analysis
#Project 1

library(ggplot2)

# OSX
getwd()
setwd("~/Documents/Data_Science_Specialization/ExploratoryDataAnalysis")

# Import data 
my_data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

# Create new data frame "my_data2" with combined Date and Time
my_data$DateTime = paste(my_data$Date, my_data$Time, sep = " ")

# Transform to Date-Time format
my_data$DateTime_fmt <- strptime(my_data$DateTime, format="%d/%m/%Y %H:%M:%S")

# Add Day based on given date
my_data$Day <- weekdays(my_data$DateTime_fmt)

head(my_data)
# Organize columns
my_data <- my_data[, c(1,2,10,11,12,3,4,5,6,7,8,9)]
head(my_data) #looks better

# Subset imported data set [raw_data] for Date = 2007-02-01 and 2007-02-02
data_small <- subset(my_data, DateTime_fmt >= as.POSIXct('2007-02-01 00:00:00') & DateTime_fmt <= as.POSIXct('2007-02-02 23:59:59'))

# Transform variables from Factor type to Numeric type
data_small$Global_active_power <- as.numeric(as.character(data_small$Global_active_power))
data_small$Global_reactive_power <- as.numeric(as.character(data_small$Global_reactive_power))
data_small$Voltage <- as.numeric(as.character(data_small$Voltage))
data_small$Global_intensity <- as.numeric(as.character(data_small$Global_intensity))
data_small$Sub_metering_1 <- as.numeric(as.character(data_small$Sub_metering_1))
data_small$Sub_metering_2 <- as.numeric(as.character(data_small$Sub_metering_2))
data_small$Sub_metering_3 <- as.numeric(as.character(data_small$Sub_metering_3))


# Plot 3 Energy Sub Metering 1 - 3 between Feb 01-02 2007
plot(data_small$DateTime_fmt, data_small$Sub_metering_1, type = "l", main="", xlab="", ylab="Energy sub metering", col="black")
lines(data_small$DateTime_fmt, data_small$Sub_metering_2, col = "red")
lines(data_small$DateTime_fmt, data_small$Sub_metering_3, col = "blue")
legend("topright", pch = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
