#plot4.R

# 1. Reading data for 01.02.2007 and 02.02.2007
# raw dataset file expected in working directory
filename = "household_power_consumption.txt"
column.names = read.csv2(filename, nrow=1)
column.classes = c(rep("character", 2), rep("numeric", 7))
data = read.csv2(filename,
                 skip = 66636, nrows = 2880,
                 col.names = colnames(column.names),
                 colClasses = column.classes,
                 na.strings = "?",
                 dec = ".")

# 2. Preparing data to plot
data$DateTime = strptime(paste(data$Date, data$Time, sep = " "),
                         "%d/%m/%Y %H:%M:%S")

# 3. Making plots and saving them as a PNG file
par(mfrow = c(2, 2))

# Global active power by weekdays
with(data, plot(DateTime, Global_active_power,
                xlab = "",
                ylab = "Global Active Power",
                type = "l"))
# Voltage by weekdays
with(data, plot(DateTime, Voltage,
                xlab = "datetime",
                ylab = "Voltage",
                type = "l"))
# Energy sub metering by weekdays
with(data, {
    plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering",
         type = "n")
    lines(DateTime, Sub_metering_1, col = "black")
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lwd = 1,
       y.intersp = 1,
       bty = "n")
})
# Global reactive power by weekdays
with(data, plot(DateTime, Global_reactive_power,
                xlab = "datetime",
                type = "l"))

dev.copy(device = png, filename = "plot4.png")
dev.off()