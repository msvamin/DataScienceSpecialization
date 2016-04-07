setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BalLADF <- NEI[NEI$fips=="24510" | NEI$fips=="06037" ,]
vehicleRel = SCC[grep('Vehicle',SCC$EI.Sector, ignore.case=TRUE),]
vehicleCodes = vehicleRel["SCC"]
BalLAVehDF <- BalLADF[BalLADF$SCC %in% vehicleCodes$SCC,]

df = aggregate(BalLAVehDF$Emissions,by=list(BalLAVehDF$year,BalLAVehDF$fips),FUN=sum)
names(df) <- c("year", "fips", "Emissions")
g <- ggplot(df,aes(year, Emissions))
g + geom_bar(stat="identity") + facet_grid(.~fips)
# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot5.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()