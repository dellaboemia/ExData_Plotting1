# Coursera Data Science Specialization
# Exploratory Data Analysis
# Project 1
# Plot 2 - Global Active Power Linechart

# Include requisite libraries
library(dplyr)
library(data.table)
library(downloader)

# Download Household Power Consumption text File
# Create a data directory to house the data, if it doesn't already exist, then download and unzip the dataset
message("Downloading Dataset...")
if (!file.exists("epcData")){
  dir.create("epcData")
  setwd("./epcData")
  url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download(url, dest="epcData.zip", mode="wb") 
  unzip ("epcData.zip")
  
} else {
  setwd("./epcData")
}


# Read the Household Power Consumption text file into a data table for processing
message("Reading Dataset...")
epcDataAll <- read.table("household_power_consumption.txt",
                         header = TRUE, 
                         sep = ";",
                         colClasses=c(rep("character",2),rep("numeric",7)),
                         na.strings = "?")
setwd("..")  # Reset the working directory so that the plots and scripts reside in the same directory.

# Combine Date and Time variables into a single datetime object and convert the date to a date object
message("Converting and creating date, time and datetime objects ...")
epcDataAll[,"DateTime"] <- with(epcDataAll, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
epcDataAll$Date <- as.Date(epcDataAll$Date, format = "%d/%m/%Y")

# Create a copy of the data table that contains only the observations for 2007-02-01 and 2007-02-02.  
# First, we convert the Date variable from the character class to the date class.  Next we create date the 
# variables to contain the start and end dates.  Lastly, we use the filter function to extract only the 
# observations of interest.
message("Creating data frame with observations for 2007-02-01 and 2007-02-02...")
startDate <- as.Date("2007-02-01", format = "%Y-%m-%d")
endDate   <- as.Date("2007-02-02", format = "%Y-%m-%d")
epcData   <- filter(epcDataAll, Date >= startDate & Date <= endDate)
epcData   <- arrange(epcData, DateTime)

#Create Plot 2 - Global Active Power Linechart
# First, we set the background for the plot to white, then initialize the png graphic file device with the designated 
# size using the png function.  Next, plot the line chart to the device, then use the axis.Date function to 
# properly format the x-axis labels with day of week. Finally, we close the device.
message("Creating Plot 2...")
dateRange=c(min(epcData$DateTime), max(epcData$DateTime))
plot.new()
png(file = "plot2.png", width = 480, height = 480, bg="white")
plot(epcData$DateTime, epcData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
axis.Date(1, at = seq(dateRange[1], dateRange[2], by = "day"), format = "%b")
dev.off()

message("Plot created successfully!")