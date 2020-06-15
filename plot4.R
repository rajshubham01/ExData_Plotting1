# plot4.R

# Check for data file
datafile1 <- "./data/household_power_consumption.txt"
if (!file.exists(datafile1))
{
  print(paste("Please place data file here: ", datafile1))
}

# Read data file
print("Reading data file")
d <- read.csv(datafile1, sep=";")

# Subset first so we're working with just the data we need
print("Subsetting data")
d2 <- d[d$Date %in% c('1/2/2007', '2/2/2007'),]

# Convert needed data types
print("Converting data types")
d2[, "Global_active_power"]  <- as.numeric(as.character(d2[, "Global_active_power"]))
d2[, "Voltage"]  <- as.numeric(as.character(d2[, "Voltage"]))
d2[, "Global_reactive_power"]  <- as.numeric(as.character(d2[, "Global_reactive_power"]))
d2[, "Sub_metering_1"]  <- as.numeric(as.character(d2[, "Sub_metering_1"]))
d2[, "Sub_metering_2"]  <- as.numeric(as.character(d2[, "Sub_metering_2"]))
d2[, "Sub_metering_3"]  <- as.numeric(as.character(d2[, "Sub_metering_3"]))
d2$datetime <- as.POSIXct(paste(d2$Date,d2$Time), format="%d/%m/%Y %H:%M:%S")

# Plot to png file
print("Plotting")
# Set output file parameters
png(filename="plot4.png", width=480, height=480, units='px')
# Set a 2 x 2 matrix of plots
par(mfcol=c(2,2))
# Upper left
plot(d2$datetime, d2$Global_active_power, type="l", xlab="", ylab="Global Active Power")
# Lower left
plot(d2$datetime, d2$Sub_metering_1, col="black", type="n", ylim=c(-1,39), xlab="", ylab="Energy sub metering", yaxs="i")
lines(d2$datetime, d2$Sub_metering_1, col="black")#, ylim=c(0,30))
lines(d2$datetime, d2$Sub_metering_2, col="red")#, ylim=c(0,30))
lines(d2$datetime, d2$Sub_metering_3, col="blue")#, ylim=c(0,30))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n", x.intersp=0.5, y.intersp=0.9)
# Upper right
plot(d2$datetime, d2$Voltage, type="l", xlab="datetime", ylab="Voltage")
# Lower right
plot(d2$datetime, d2$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
# Close file graphics device
dev.off()