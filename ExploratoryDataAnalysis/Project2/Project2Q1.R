# Reading the files
setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting the NEI dataset and summing on years
#DFbyYear = aggregate(NEI$Emissions,by=list(NEI$year),FUN=sum)
#names(DFbyYear) <- c("year","Emissions")
#totalPollbyYear <- tapply(NEI$Emissions, NEI$year, FUN=sum)
barplot(DFbyYear$Emission, main="Total PM2.5 Emission")

# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot1.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()