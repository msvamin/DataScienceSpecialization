setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimoreDF <- NEI[NEI$fips=="24510",]
vehicleRel = SCC[grep('Vehicle',SCC$EI.Sector, ignore.case=TRUE),]
vehicleCodes = vehicleRel["SCC"]
BalVehDF <- BaltimoreDF[BaltimoreDF$SCC %in% vehicleCodes$SCC,]

df = aggregate(BalVehDF$Emissions,by=list(BalVehDF$year),FUN=sum)
names(df) <- c("year","Emissions")
g <- ggplot(coalDF,aes(year, Emissions))
g + geom_bar(stat="identity")
# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot5.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()