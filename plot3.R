url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip", files = "household_power_consumption.txt")
data <- read.csv("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
head(data)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
df <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
head(df)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
par(mar=c(5,4,2,2))
png("plot3.png",width=480,height=480)
plot(df$DateTime, df$Sub_metering_1, type = "l", col = "black",
     xlab='',
     ylab = "Energy sub metering",
     ylim = c(0, max(c(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3))),
     xaxt = "n")

lines(df$DateTime, df$Sub_metering_2, col = "red")

lines(df$DateTime, df$Sub_metering_3, col = "blue")

tick_positions <- seq(as.POSIXct("2007-02-01 00:00:00"), 
                      as.POSIXct("2007-02-03 00:00:00"), 
                      by = "day")

axis(1, at = tick_positions, labels = format(tick_positions, "%a")) 

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, cex=0.8,bty="n")
dev.off()