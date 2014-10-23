##################################################################################
## Exploratory Data Analysis
## by Jeff Leek, PhD, Brian Caffo, PhD, Roger D. Peng, PhD
## 
## plot3.R by JAGomez
## 23-Oct-2014
##
## plot3.R that does the following:
## 1. Read Data and subset it
## 2. Open Graphic Device PNG
## 3. Create plot
##
##################################################################################

## Read data from files
NEI <- readRDS("summarySCC_PM25.rds")

## subset data
Baltimore <- subset (NEI, fips == "24510")
rm(NEI)

## Total PM2.5 emissions for each of the years
TotalPM25 <- tapply(Baltimore$Emissions, Baltimore$year, sum)

## Open Graphic Device PNG
png(filename = "plot2.png", width = 480, height = 480, units = "px")

##Generates the plot
plot(names(TotalPM25), TotalPM25, type = "l", 
     main = "Total PM2.5 Emissions by Year in Baltimore", xlab = "Year", ylab = "Emissions")

##Close Graphic Device
dev.off()