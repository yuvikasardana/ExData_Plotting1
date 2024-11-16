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
df$Global_active_power <- as.numeric(df$Global_active_power)
png("plot1.png", width = 480, height = 480)
hist(df$Global_active_power, 
     main = " Global Active Power",
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "red", 
     border = "black",
     )  
dev.off()

