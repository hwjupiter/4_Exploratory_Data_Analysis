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

# Subset coal combustion related NEI data
combustion01 <- grepl("comb", scc_df[, SCC.Level.One], ignore.case=TRUE)
coal01 <- grepl("coal", scc_df[, SCC.Level.Four], ignore.case=TRUE) 
combustionSCC <- scc_df[combustion01 & coal01, SCC]
combustionNEI <- nei_df[nei_df[,SCC] %in% combustionSCC]


# create a png graphics device and plot the bar graph (chosen for better indication)
png(filename = "plot4.png")

ggp2 <- ggplot(combustionNEI,aes(x = factor(year),y = Emissions/10^5)) +
  geom_bar(stat="identity", fill ="#FF9999", width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp2)

dev.off()
