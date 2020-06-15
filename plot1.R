# plot1.R

# Check for data file
datafile1 <- "./household_power_consumption.txt"
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

# Plot to png file
print("Plotting")
# Set output file parameters
png(filename="plot1.png", width=480, height=480, units='px')
# Plot a histogram
hist(d2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
# Close file graphics device
dev.off()