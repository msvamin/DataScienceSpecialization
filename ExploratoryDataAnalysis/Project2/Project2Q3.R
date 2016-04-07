setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimoreDF <- NEI[NEI$fips=="24510",]
df = aggregate(BaltimoreDF$Emissions,by=list(BaltimoreDF$year,BaltimoreDF$type),FUN=sum)
g <- ggplot(BaltimoreDF,aes(as.character(year), Emissions))
g + geom_bar(stat="identity") + facet_grid(.~type)

# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot2.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()