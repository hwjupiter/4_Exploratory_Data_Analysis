# load the necessary libraries for data.table and ggplot2 functions
#install.packages("data.table")
library("data.table")
library("ggplot2")

# read in the data used for the analysis. Assuming it has already been downloaded and unzipped
nei_data <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
class_data <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# create a data frame of the sample data
nei_df <- data.table(nei_data)
# subset the total data frme to isolate the Baltimore City data
nei_baltimore <- subset(nei_df, fips == "24510")

# separate the data necessary for plot number 2 - the years and the corresponding emmission levels, and
# add up the emissions for each year
bm_annual <- nei_baltimore[, list(emissions=sum(Emissions)), by=c("year", "type")]
# convert the data to numric format for plotting
bm_annual$year = as.numeric(as.character(bm_annual$year))
bm_annual$emissions = as.numeric(as.character(bm_annual$emissions))

# create a png graphics device and plot the bar graph (chosen for better indication)

png(filename = "plot3.png")
    
ggp <- ggplot(nei_baltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity")+
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)

dev.off()