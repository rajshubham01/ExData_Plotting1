# plot3.R

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
d2[, "Sub_metering_1"]  <- as.numeric(as.character(d2[, "Sub_metering_1"]))
d2[, "Sub_metering_2"]  <- as.numeric(as.character(d2[, "Sub_metering_2"]))
d2[, "Sub_metering_3"]  <- as.numeric(as.character(d2[, "Sub_metering_3"]))
d2$Date <- as.POSIXct(paste(d2$Date,d2$Time), format="%d/%m/%Y %H:%M:%S")

# Plot to png file
print("Plotting")
# Set output file parameters
png(filename="plot3.png", width=480, height=480, units='px')
# Setup plot first, then use lines for each variable
plot(d2$Date, d2$Sub_metering_1, col="black", type="n", ylim=c(-1,39), xlab="", ylab="Energy sub metering", yaxs="i")
lines(d2$Date, d2$Sub_metering_1, col="black")
lines(d2$Date, d2$Sub_metering_2, col="red")
lines(d2$Date, d2$Sub_metering_3, col="blue")
# Add legend in top right corner
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black","red","blue"))
# Close file graphics device
dev.off()