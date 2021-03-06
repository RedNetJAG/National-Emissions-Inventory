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

library(ggplot2)

## Read data from files
NEI <- readRDS("summarySCC_PM25.rds")

## subset data
Baltimore <- subset (NEI, fips == "24510")
rm(NEI)

## Total PM2.5 emissions for every type of source for each of the years
TotalPM25 <- aggregate(Baltimore["Emissions"], list(type = Baltimore$type, 
                        year = Baltimore$year), sum)

## Open Graphic Device PNG
png(filename = "plot3.png")

##Generates the plot
qplot(year, Emissions, data=TotalPM25, color=type, geom ="line") + 
        ggtitle("Total Emissions by Source Type in Baltimore")

##Close Graphic Device
dev.off()