
# Create a png file for the plot. Do this first as the legend does not fit correctly if the graph is resized afterwards
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

# Plot the three sub metering values on the same line graph. 
# Use the plot() function to create the inital plot, then use the lines() function to add the others
plot(data_subset$Sub_metering_1 ~ data_subset$Date_Time, ylab = "Energy Sub Metering", xlab = "", type = "l")
lines(data_subset$Sub_metering_2 ~ data_subset$Date_Time, col = "red")
lines(data_subset$Sub_metering_3 ~ data_subset$Date_Time, col = "blue")

# Add a legend to the graph so the different sub metering values can be distinguished
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

dev.off()