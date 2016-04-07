# Reading the files
setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting for Baltimore and LA
BalLADF <- NEI[NEI$fips=="24510" | NEI$fips=="06037" ,]

# Subsetting for Vehicles
vehicleRel = SCC[grep('Vehicle',SCC$EI.Sector, ignore.case=TRUE),]
vehicleCodes = vehicleRel["SCC"]
BalLAVehDF <- BalLADF[BalLADF$SCC %in% vehicleCodes$SCC,]

# Aggregating Emissions by year and city
EmsBalLA = aggregate(BalLAVehDF$Emissions,by=list(BalLAVehDF$year,BalLAVehDF$fips),FUN=sum)
names(EmsBalLA) <- c("year", "fips", "Emissions")
EmsBalLA$year <- as.character(EmsBalLA$year)

# Plotting the results
g <- ggplot(EmsBalLA,aes(year, Emissions))
g + geom_bar(stat="identity") + facet_grid(.~fips) + ggtitle("Emissions from Motor Vehicles in LA County and Baltimore City")

# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot6.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()