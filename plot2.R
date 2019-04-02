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
png("plot2.png")

# Create the plot
with(power_cons, plot(dateTime, Global_active_power, type = "l", xlab = "" ,ylab = "Global Active Power (kilowatts)"))

# Close the dev
dev.off()