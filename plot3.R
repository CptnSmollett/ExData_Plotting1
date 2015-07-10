#plot3.R

# 1. Reading data for 01.02.2007 and 02.02.2007
# raw dataset file expected in working directory
filename = "household_power_consumption.txt"
column.names = read.csv2(filename, nrow=1)
data = read.csv2(filename,
                 skip = 66636, nrows = 2880,
                 col.names = colnames(column.names),
                 na.strings = "?",
                 as.is = TRUE)

# 2. Preparing data to plot
data$DateTime = strptime(paste(data$Date, data$Time, sep = " "),
                         "%d/%m/%Y %H:%M:%S")
data$Sub_metering_1 = as.numeric(data$Sub_metering_1)
data$Sub_metering_2 = as.numeric(data$Sub_metering_2)
data$Sub_metering_3 = as.numeric(data$Sub_metering_3)

# 3. Making a plot and saving it as a PNG file
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
           y.intersp = 1)
})



## BUG: legend is cut on the right if script is run in RStudio on Windows
## see: https://class.coursera.org/exdata-030/forum/thread?thread_id=66
dev.copy(device = png, filename = "plot3.png")
dev.off()