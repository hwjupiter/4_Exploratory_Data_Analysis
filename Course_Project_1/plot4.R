
# Create a png graphics device for the new plots
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

# Divide the plotting area into 2 rows and 2 columns
par(mfrow = c(2,2))

# The first plot is a recreation of plot2
plot(data_subset$Global_active_power ~ data_subset$Date_Time, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")

# The second plot is a plot of voltage over time
plot(data_subset$Voltage ~ data_subset$Date_Time, ylab = "Voltage", xlab = "datetime", type = "l")

#The third plot is a recreation of plot 3, including the legend
plot(data_subset$Sub_metering_1 ~ data_subset$Date_Time, ylab = "Energy Sub Metering", xlab = "", type = "l")
lines(data_subset$Sub_metering_2 ~ data_subset$Date_Time, col = "red")
lines(data_subset$Sub_metering_3 ~ data_subset$Date_Time, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

# The fourth plot is a plot of global reactive power over time
plot(data_subset$Global_reactive_power ~ data_subset$Date_Time, ylab = "Global_reactive_power", xlab = "datetime", type = "l")

dev.off()