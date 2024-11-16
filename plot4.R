url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip", files = "household_power_consumption.txt")
data <- read.csv("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
head(data)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
df <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
head(df)

par(mfrow = c(2, 2))

png("plot4.png",width=480,height=480)
plot(df$DateTime, df$Global_active_power, type = "l", col = "black",
     xlab = "", ylab = "Global Active Power (kilowatts)",xaxt="n")

tick_positions <- seq(as.POSIXct("2007-02-01 00:00:00"), 
                      as.POSIXct("2007-02-03 00:00:00"), 
                      by = "day")

axis(1, at = tick_positions, labels = format(tick_positions, "%a")) 

plot(df$DateTime, df$Voltage, type = "l", col = "black",
     xlab = "datetime", ylab = "Voltage",xaxt="n")
axis(1, at = tick_positions, labels = format(tick_positions, "%a")) 

plot(df$DateTime, df$Sub_metering_1, type = "l", col = "black",
     xlab = "", ylab = "Energy sub metering",xaxt="n")
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1,cex=0.2, bty = "n")
axis(1, at = tick_positions, labels = format(tick_positions, "%a")) 


plot(df$DateTime, df$Global_reactive_power, type = "l", col = "black",
     xlab = "datetime", ylab = "Global Reactive Power (kilowatts)",xaxt="n")

axis(1, at = tick_positions, labels = format(tick_positions, "%a")) 
dev.off()