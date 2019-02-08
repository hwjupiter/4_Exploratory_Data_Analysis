# Load the URL and filenames for the dataset
data_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data_file <- "exdata_data_household_power_consumption.zip"
data_path <- "exdata_data_household_power_consumption"

#check if the file exists. If not, download and unzip it
if (!file.exists(data_file)) {
  download.file(data_URL, data_file)
  unzip(data_file)
}

# Read in the whole data set
full_data <- read.table(file.path(data_path, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")

# Convert the date column to a date format that can be easily understood
full_data$Date <- as.Date(full_data$Date, format = "%d/%m/%Y")

# Subset the complete dataset to isolate only the dates of interest in this case
data_subset <- subset(full_data, Date >= "2007-02-01" & Date <= "2007-02-02")

# Combine the date and time columns and convert them into a format that R can use easily for plotting, then add this
# new column to the existing subset 
date_time <- paste(data_subset$Date, data_subset$Time)
data_subset$Date_Time <- as.POSIXct(date_time)