##################################################################################
## Exploratory Data Analysis
## by Jeff Leek, PhD, Brian Caffo, PhD, Roger D. Peng, PhD
## 
## plot6.R by JAGomez
## 23-Oct-2014
##
## plot6.R that does the following:
## 1. Read Data and subset it
## 2. Open Graphic Device PNG
## 3. Create plot
##
##################################################################################

library(ggplot2)

## Read data from files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset data for Motor Vehicle in Baltimore OR Los Angeles County
Veh <- grep("vehicle", SCC$EI.Sector, value=T, ignore.case=T)
VehSCC <- SCC[SCC$EI.Sector %in% Veh, ]["SCC"]
rm(SCC)
BaltLAC <- subset(NEI, fips == "24510"|fips == "06037")
VehNEI <- subset(BaltLAC, BaltLAC$SCC %in%  VehSCC$SCC)
rm(NEI)

## Total Motor Vehicle emissions for each of the years in both cities
TotalVeh <- aggregate(VehNEI["Emissions"], list(fips=VehNEI$fips, year=VehNEI$year), sum)
TotalVeh[TotalVeh$fips == "06037", ][,"fips"]<- "Los Angles County"
TotalVeh[TotalVeh$fips == "24510", ][, "fips"] <- "Baltimore City"

## Open Graphic Device PNG
png(filename = "plot6.png")

##Generates the plot
qplot(year, Emissions, data=TotalVeh, color=fips, geom="line") + 
        ggtitle(expression("Baltimore & Los Angeles County" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year"))

##Close Graphic Device
dev.off()