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
plot(TimeStamp, as.numeric(as.matrix(DTS$Global_active_power)), type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Copying to a png file
pngFileName = "C:/Amin/Coursera/datasciencecoursera/ExploratoryDataAnalysis/Project1/plot2.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()