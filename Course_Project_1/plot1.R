
# Plot a histogram of the global active power to see how often each value occurs
hist(data_subset$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Create a png file of the histogram using dev.copy
dev.copy(png, filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
dev.off()
