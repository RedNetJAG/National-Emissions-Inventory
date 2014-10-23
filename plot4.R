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

library(ggplot2)

## Read data from files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset data for Coal Combustion
Coal <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
                "Fuel Comb - Electric Generation - Coal", 
                "Fuel Comb - Industrial Boilers, ICEs - Coal"))
rm(SCC)
CoalNEI <- subset(NEI, NEI$SCC %in%  Coal$SCC)
rm(NEI)

## Total Coal Combustion emissions for each of the years
TotalCoalComb <- aggregate(CoalNEI["Emissions"], list(year = CoalNEI$year), sum)

## Open Graphic Device PNG
png(filename = "plot4.png", width = 480, height = 480, units = "px")

##Generates the plot
plot(TotalCoalComb, type="l", main = "Emissions from Coal Combustion for the US",
     xlim = c(1999, 2008))

##Close Graphic Device
dev.off()