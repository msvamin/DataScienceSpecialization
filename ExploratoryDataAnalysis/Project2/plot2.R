# Reading the files
setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting the dataset for Baltimore
BaltimoreDF <- NEI[NEI$fips=="24510",]

# Calculating the total Emissions by year
totalPollbyYear <- tapply(BaltimoreDF$Emissions, BaltimoreDF$year, FUN=sum)

#Plotting the result
barplot(totalPollbyYear, main="Total PM2.5 Emissions in Baltimore City", xlab="Year", ylab="Emissions")

# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot2.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()