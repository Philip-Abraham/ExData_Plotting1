# Install downloader package to read zip files
require("downloader") || install.packages("downloader")

# Download dataset zip file using downloader package
library(downloader)
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "dataset")


hpc <- read.table("./dataset/household_power_consumption.txt", skip = 66637, header = FALSE, nrows = 2880, sep = ";",na.strings = "?", stringsAsFactors = FALSE, col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")) 

# list rows of data that have missing values 
missing_val<-hpc[!complete.cases(hpc),]
missing_val

# Combine Date and Time Columns
hpc$datetime <- paste(hpc$Date, hpc$Time)


# Install lubridate package to better work with dates and times
require("lubridate") || install.packages("lubridate")

library(lubridate)

# Convert the combined date and time column into date-time format showing the day of the week
# Since the original data contain dates and times in day-month-year-hours-min-sec format, use dmy_hms

dat <- dmy_hms(hpc$datetime) ### Date time format
str(hpc)

#### Create four subplots on a 2 x 2 grid columnwise fill
par(mfcol=c(2,2))

plot(dat, hpc$Global_active_power, type = "l", xlim = c(min(dat), max(dat)), xlab = "", ylab = "Global Active Power (kilowatts)") 

plot(dat, hpc$Sub_metering_1, type = "l", xlim = c(min(dat), max(dat)), xlab = "", ylab = "Energy sub metering") 
lines(dat, hpc$Sub_metering_2, col="red")
lines(dat, hpc$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black","red", "blue"), cex = .75, bty = "n", xjust = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(dat, hpc$Voltage, type = "l", xlim = c(min(dat), max(dat)), xlab = "datetime", ylab = "Voltage")

plot(dat, hpc$Global_reactive_power, type = "l", xlim = c(min(dat), max(dat)), xlab = "datetime", ylab = "Global_reactive_power")


# To avoid unexpected funky graphics, he best practice is to create a script file that begins with a 
# call to the device driver ( png, etc), runs the graphics commands, and then finishes with a call to dev.off()
png(file="plot4.png",width=480,height=480)

par(mfcol=c(2,2))

plot(dat, hpc$Global_active_power, type = "l", xlim = c(min(dat), max(dat)), xlab = "", ylab = "Global Active Power (kilowatts)") 

plot(dat, hpc$Sub_metering_1, type = "l", xlim = c(min(dat), max(dat)), xlab = "", ylab = "Energy sub metering") 
lines(dat, hpc$Sub_metering_2, col="red")
lines(dat, hpc$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black","red", "blue"), cex = .75, bty = "n", xjust = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(dat, hpc$Voltage, type = "l", xlim = c(min(dat), max(dat)), xlab = "datetime", ylab = "Voltage")

plot(dat, hpc$Global_reactive_power, type = "l", xlim = c(min(dat), max(dat)), xlab = "datetime", ylab = "Global_reactive_power")


dev.off()
# Show the currently active graphics device 
dev.cur()


