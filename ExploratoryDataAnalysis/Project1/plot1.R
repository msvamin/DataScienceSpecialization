# The R code for generating plot1.png

# Reading the data
filename <- "C:/Amin/Coursera/ExploratoryDataAnalysis/Project1/household_power_consumption.txt"
DT <- read.table(filename, sep=";", header=TRUE)
DT <- data.frame(DT)

# Changing the date format
DT$Date <- as.Date(DT$Date, "%d/%m/%Y")

# Subsetting the data
DT = DT[DT$Date == "2007-02-01" | DT$Date == "2007-02-02",]

# Plotting the histogram
hist(as.numeric(as.matrix(DTS$Global_active_power)), col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')

# Copying a png file
pngFileName = "C:/Amin/Coursera/datasciencecoursera/ExploratoryDataAnalysis/Project1/plot1.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()