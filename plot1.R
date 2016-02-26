# Coursera Data Science Specialization
# Exploratory Data Analysis
# Project 1
# Plot 1 - Histogram Global Power

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

# Create a copy of the data table that contains only the observations for 2007-02-01 and 2007-02-02.  
# First, we convert the Date variable from the character class to the date class.  Next we create date the 
# variables to contain the start and end dates.  Lastly, we use the filter function to extract only the 
# observations of interest.
message("Creating subset of data table based upon start and end dates...")
epcDataAll$Date <- as.Date(epcDataAll$Date, format="%d/%m/%Y")
startDate       <- as.Date("2007-02-01", format = "%Y-%m-%d")
endDate         <- as.Date("2007-02-02", format = "%Y-%m-%d")
epcData         <- filter(epcDataAll, Date >= startDate & Date <= endDate)

# Create Plot 1 - Global Active Power Histogram.
# First, we initialize the png graphic file device with the designated 
# size using the png function.  Next, write the histogram to the device, then close the device.
message("Creating Plot 1")
png(file = "plot1.png", width = 480, height = 480, bg="white")
hist(epcData$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     main = "Global Active Power", 
     breaks = 20)
dev.off()

message("Plot created successfully!")