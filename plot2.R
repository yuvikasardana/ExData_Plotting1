url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip", files = "household_power_consumption.txt")
data <- read.csv("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
head(data)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
df <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
head(df)

#install.packages('sqldf')
library(sqldf)
png("plot2.png", width = 480, height = 480)
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format = "%Y-%m-%d %H:%M:%S")
plot(df$DateTime, df$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "", xaxt='n')
axis(1, at = tick_positions, labels = format(tick_positions, "%a")) 
dev.off()