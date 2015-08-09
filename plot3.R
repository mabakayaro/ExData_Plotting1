if (!file.exists("data")) {
        dir.create("data")
        
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./data/zipdata.zip")
        
}     

hpc <- read.table(unz("./data/zipdata.zip","household_power_consumption.txt"), header = FALSE, sep = ";", skip = 66637, nrows = 2880, na.strings = "?")
colnames(hpc) <- colnames(read.table(unz("./data/zipdata.zip","household_power_consumption.txt"), header = TRUE, sep = ";", nrows = 5))

Dat <- strptime(paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S")
hpc <- cbind(hpc, Dat)
library(dplyr)
hpc <- tbl_df(hpc)

png("plot3.png", width = 480, height = 480)

with(hpc, plot(Dat, Sub_metering_1, type = "l",ylab = "Energy sub metering", xlab = "", col = "black" ))
lines(Dat, hpc$Sub_metering_2, col = "red")
lines(Dat, hpc$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col =c("black", "red", "blue"), legend = c("Sub_meter_1","Sub_meter_2","Sub_meter_3"))

dev.off()