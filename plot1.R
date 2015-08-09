if (!file.exists("data")) {
        dir.create("data")
        setwd("data")
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./data/zipdata.zip")
        }     

hpc <- read.table(unz("./data/zipdata.zip","household_power_consumption.txt"), header = FALSE, sep = ";", skip = 66637, nrows = 2880, na.strings = "?")
colnames(hpc) <- colnames(read.table(unz("./data/zipdata.zip","household_power_consumption.txt"), header = TRUE, sep = ";", nrows = 5))

Dat <- strptime(paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S")
hpc <- cbind(hpc, Dat)
library(dplyr)
hpc <- tbl_df(hpc)

hist(hpc$Global_active_power, col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatt)", xlim=c(0,6), ylim=c(0,1200))
dev.copy(png, "plot1.png")
dev.off()