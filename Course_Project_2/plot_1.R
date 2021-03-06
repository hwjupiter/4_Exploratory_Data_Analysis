# load the necessary library for data.table functions
#install.packages("data.table")
library("data.table")

# read in the data used for the analysis. Assuming it has already been downloaded and unzipped
nei_data <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
class_data <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# create a data frame of the sample data
nei_df <- data.table(nei_data)

# separate the data necessary for plot number 1 - the years and the corresponding emmission levels, and
# add up the emissions for each year
nei_annual <- nei_df[, list(emissions=sum(Emissions)), by=year]
# convert the data to numric format for plotting
nei_annual$year = as.numeric(as.character(nei_annual$year))
nei_annual$emissions = as.numeric(as.character(nei_annual$emissions))

# create a png graphics device and plot the bar graph (chosen for better indication)
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
barplot(nei_annual[, emissions], names = nei_annual[, year], xlab = "Years", ylab = "Emissions"
        , main = "Total Emissions")
dev.off()