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

# Create another subset consisting only of the vehicles in Baltimore
baltimore_vehicles_NEI <- vehicles_NEI[fips=="24510",]

# Create a png graphics device for the new plot
png(filename = "plot5.png")

ggp3 <- ggplot(baltimore_vehicles_NEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp3)

dev.off()
