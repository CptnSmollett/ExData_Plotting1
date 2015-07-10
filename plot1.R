#plot1.R

# 1. Reading data for 01.02.2007 and 02.02.2007
# raw dataset file expected in working directory
filename = "household_power_consumption.txt"
column.names = read.csv2(filename, nrow=1)
data = read.csv2(filename,
                 skip = 66636, nrows = 2880,
                 col.names = colnames(column.names),
                 na.strings = "?",
                 as.is = TRUE)

# 2. Making a plot and saving it as a PNG file
par(mfrow = c(1, 1))
hist(as.numeric(data$Global_active_power), main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.copy(device = png, filename = "plot1.png")
dev.off()