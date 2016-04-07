setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
totalPollbyYear <- tapply(NEI$Emissions, NEI$year, FUN=sum)
barplot(totalPollbyYear, main="Total PM2.5 Emission")

# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot1.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()