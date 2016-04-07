# The R code for generating plot2.png

# Reading the data
filename <- "C:/Amin/Coursera/ExploratoryDataAnalysis/Project1/household_power_consumption.txt"
DT <- read.table(filename, sep=";", header=TRUE)
DT <- data.frame(DT)

# Changing the date format
DT$Date <- as.Date(DT$Date, "%d/%m/%Y")

# Subsetting the data
DT = DT[DT$Date == "2007-02-01" | DT$Date == "2007-02-02",]
TimeStamp = strptime(paste(DT$Date, DT$Time), "%Y-%m-%d %H:%M:%S")

# Plotting
plot(TimeStamp, as.numeric(as.matrix(DTS$Sub_metering_1)), col = 'black', type="l", xlab = "", ylab = "Energy sub metering")
lines(TimeStamp, as.numeric(as.matrix(DTS$Sub_metering_2)), col = 'red')
lines(TimeStamp, as.numeric(as.matrix(DTS$Sub_metering_3)), col = 'blue')
legend("topright", legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = 1, cex = 0.6)

# Copying to a png file
pngFileName = "C:/Amin/Coursera/datasciencecoursera/ExploratoryDataAnalysis/Project1/plot3.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()