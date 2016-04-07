# Reading the files
setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting the dataset for Baltimore
BaltimoreDF <- NEI[NEI$fips=="24510",]

# Aggregating the Emissions by year and type
EmsByYearType = aggregate(BaltimoreDF$Emissions,by=list(BaltimoreDF$year,BaltimoreDF$type),FUN=sum)
names(EmsByYearType) <- c("year", "type", "Emissions")
# Converting the year value to string to better represent the values on the plot
EmsByYearType$year <- as.character(EmsByYearType$year)

# Plotting the result
g <- ggplot(EmsByYearType,aes(year, Emissions))
g + geom_bar(stat="identity") + facet_grid(.~type) + ggtitle("Total PM2.5 Emissions by Different Types in Baltimore City")

# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot3.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()