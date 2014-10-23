##################################################################################
## Exploratory Data Analysis
## by Jeff Leek, PhD, Brian Caffo, PhD, Roger D. Peng, PhD
## 
## plot5.R by JAGomez
## 23-Oct-2014
##
## plot5.R that does the following:
## 1. Read Data and subset it
## 2. Open Graphic Device PNG
## 3. Create plot
##
##################################################################################

library(ggplot2)

## Read data from files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset data for Motor Vehicle in Baltimore
Veh <- grep("vehicle", SCC$EI.Sector, value=T, ignore.case=T)
VehSCC <- SCC[SCC$EI.Sector %in% Veh, ]["SCC"]
rm(SCC)
Baltimore <- subset(NEI, fips == "24510")
VehNEI <- subset(Baltimore, Baltimore$SCC %in%  VehSCC$SCC)
rm(NEI)

## Total Motor Vehicle emissions for each of the years in Baltimore
TotalVeh <- aggregate(VehNEI["Emissions"], list(year = VehNEI$year), sum)

## Open Graphic Device PNG
png(filename = "plot5.png")

##Generates the plot
qplot(year, Emissions, data=TotalVeh, geom="line") + 
      ggtitle(expression("Baltimore" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year"))

##Close Graphic Device
dev.off()