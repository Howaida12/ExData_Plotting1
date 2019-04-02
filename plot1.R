library(data.table)

# Read the data
power_cons <- data.table::fread("household_power_consumption.txt", na.strings = "?")

# Convert using as.Date
power_cons[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Subset the data to the dates we need
power_cons <- subset(power_cons, power_cons$Date >= "2007-02-01" & power_cons$Date <= "2007-02-02")

# Create a png file
png("plot1.png")

# Create the histogram
hist(power_cons$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# close the dev
dev.off()