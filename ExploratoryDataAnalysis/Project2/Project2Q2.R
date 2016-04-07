setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimoreDF <- NEI[NEI$fips=="24510",]

totalPollbyYear <- tapply(BaltimoreDF$Emissions, BaltimoreDF$year, FUN=sum)
barplot(totalPollbyYear, main="Total PM2.5 Emission in Baltimore City")

# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot2.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()