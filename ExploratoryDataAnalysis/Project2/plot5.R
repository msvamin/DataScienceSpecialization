# Reading the files
setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting for Baltimore City
BaltimoreDF <- NEI[NEI$fips=="24510",]

# Subsetting for Vehicles
vehicleRel = SCC[grep('Vehicle',SCC$EI.Sector, ignore.case=TRUE),]
vehicleCodes = vehicleRel["SCC"]
BalVehDF <- BaltimoreDF[BaltimoreDF$SCC %in% vehicleCodes$SCC,]

# Aggregating Emissions by year
EmsVehBal = aggregate(BalVehDF$Emissions,by=list(BalVehDF$year),FUN=sum)
names(EmsVehBal) <- c("year","Emissions")
EmsVehBal$year <- as.character(EmsVehBal$year)

# Plotting the Result
g <- ggplot(EmsVehBal, aes(year, Emissions))
g + geom_bar(stat="identity") + ggtitle("Emissions from Motor Vehicles in Baltimore")

# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot5.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()