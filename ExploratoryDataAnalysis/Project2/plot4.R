# Reading the files
setwd("C:/Amin/Coursera/ExploratoryDataAnalysisProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extracting the codes related to Coal Combustion
coalRel = SCC[grep('Coal',SCC$EI.Sector, ignore.case=TRUE),]
coalCodes = coalCodes["SCC"]

# Subsetting the main dataset with coal codes
coalDF <- NEI[NEI$SCC %in% coalCodes$SCC,]

# Adding a new variable containing the state code
coalDF$state <- substr(coalDF$fips,1,2)

# Aggregating the Emissions by state and year
coalbyStateYear = aggregate(coalDF$Emissions,by=list(coalDF$state, coalDF$year),FUN=sum)
names(coalbyStateYear) <- c("state","year","Emissions")

# Plotting the result
g <- ggplot(coalbyStateYear,aes(year, Emissions))
g + geom_bar(stat="identity") + facet_wrap(~state,nrow=5) + ggtitle("Total Emissions by States for Different Years")

# Copying a png file
pngFileName = "C:/Amin/Coursera/ExploratoryDataAnalysisProject2/plot4.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()