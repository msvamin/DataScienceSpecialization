setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalRel = SCC[grep('Coal',SCC$EI.Sector, ignore.case=TRUE),]
coalCodes = coalCodes["SCC"]
coalDF <- NEI[NEI$SCC %in% coalCodes$SCC,]
coalDF$state <- substr(coalDF$fips,1,2)
df = aggregate(coalDF$Emissions,by=list(coalDF$state, coalDF$year),FUN=sum)
names(df) <- c("state","year","Emissions")
g <- ggplot(coalDF,aes(year, Emissions))
#g + geom_bar(stat="identity") + facet_grid(.~state)
g + geom_bar(stat="identity") + facet_wrap(~state,nrow=5)
# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot4.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()