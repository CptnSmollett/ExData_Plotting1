#plot2.R

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

# 3. Making a plot and saving it as a PNG file
with(data, plot(DateTime, Global_active_power,
                  xlab = "",
                  ylab = "Global Active Power (kilowatts)",
                  type = "l"))
dev.copy(device = png, filename = "plot2.png")
dev.off()