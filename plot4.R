##################################################################################
## Exploratory Data Analysis
## by Jeff Leek, PhD, Brian Caffo, PhD, Roger D. Peng, PhD
## 
## plot4.R by JAGomez
## 23-Oct-2014
##
## plot4.R that does the following:
## 1. Read Data and subset it
## 2. Open Graphic Device PNG
## 3. Create plot
##
##################################################################################

## Read data from files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Total PM2.5 emissions for each of the years
TotalPM25 <- tapply(NEI$Emissions, NEI$year, sum)

## Open Graphic Device PNG
png(filename = "plot4.png")

##Generates the plot
plot(names(TotalPM25), TotalPM25, type = "l", 
     main = "Total PM2.5 Emissions by Year in the US", xlab = "Year", ylab = "Emissions")

##Close Graphic Device
dev.off()