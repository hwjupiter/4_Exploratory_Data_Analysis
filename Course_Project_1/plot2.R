
# Plot a line graph of gloabl active power over time. 
# set the plot tyle equal to l for a line graph
plot(data_subset$Global_active_power ~ data_subset$Date_Time, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")

# Create a png file of the line graph using dev.copy
dev.copy(png, filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
dev.off()