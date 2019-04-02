library(data.table)

# Read the data
power_cons <- data.table::fread("household_power_consumption.txt", na.strings = "?")

# To prevent Scientific Notation
power_cons[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Paste (Date, Time) then tranform them to POSIXct
power_cons[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# subset the data we need
power_cons <- power_cons[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Create a png file
png("plot4.png")

# Set mfrow to be 2*2
par(mfrow=c(2,2))

# Create the plots
with(power_cons, plot(dateTime, Global_active_power, type = "l", xlab = "" ,ylab = "Global Active Power"))

with(power_cons, plot(dateTime, Voltage, type = "l"))

plot(power_cons$dateTime, power_cons$Sub_metering_1, type = "l", xlab = "",ylab = "Energy sub metering")
lines(power_cons$dateTime, power_cons$Sub_metering_2, col = "red")
lines(power_cons$dateTime, power_cons$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), lwd = c(1,1), bty = "n", cex = .5)

with(power_cons, plot(dateTime, Global_reactive_power, type = "l"))

# Close the dev
dev.off()
     
     