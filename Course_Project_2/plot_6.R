# load the necessary libraries for data.table and ggplot2 functions
#install.packages("data.table")
library("data.table")
library("ggplot2")

# read in the data used for the analysis. Assuming it has already been downloaded and unzipped
nei_data <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
class_data <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# create a data frame of the sample data
nei_df <- data.table(nei_data)
scc_df <- data.table(class_data)

# Subset the original data for vehicles
subset01 <- grepl("vehicle", scc_df[, SCC.Level.Two], ignore.case=TRUE)
vehicles_SCC <- scc_df[subset01, SCC]
vehicles_NEI <- nei_df[nei_df[, SCC] %in% vehicles_SCC,]

# Create another subset consisting only of the vehicles in Baltimore City
baltimore_vehicles_NEI <- vehicles_NEI[fips=="24510",]
baltimore_vehicles_NEI[, city := c("Baltimore City")]

# Create another subset consisting only of the vehicles in Los Angeles
losangeles_vehichles_NEI <- vehicles_NEI[fips == "06037",]
losangeles_vehichles_NEI[, city := c("Los Angeles")]

# Combine the two city vehicle data frames into a single data frame
city_vehicles_NEI <- rbind(baltimore_vehicles_NEI,losangeles_vehichles_NEI)

# Create a png graphics device to show the plot
png(filename = "plot6.png")

ggp4 <- ggplot(city_vehicles_NEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & Los Angeles, 1999-2008"))

print(ggp4)

dev.off()