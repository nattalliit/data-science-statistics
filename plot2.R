# Description:   Data Science at Johns Hopkins 

# Dataset:       Electric power consumption [20Mb] 
#                Download link: [https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip]

# Data transformation


library(readr)
library(ggplot2)

# download data
fileurl = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists('./household_power_consumption')){
  download.file(fileurl,destfile ="./documents/github/datasciencecoursera/4-Exploratory-Data-Analysis/Project/household_consumption.zip", method="curl")
  unzip("./documents/github/datasciencecoursera/4-Exploratory-Data-Analysis/Project/household_consumption.zip", exdir = "./documents/github/datasciencecoursera/4-Exploratory-Data-Analysis/Project/")
}

# read data

household_power_consumption <- read_delim("Documents/GitHub/datasciencecoursera/4-Exploratory-Data-Analysis/Project/household_power_consumption.txt", 
                                          ";", escape_double = FALSE, trim_ws = TRUE)

# Convert date into date format

household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")

# Subset dataset

household_power_consumption_subset <- subset(household_power_consumption, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Set time to plot each observation

household_power_consumption_subset$datetime <- strptime(paste(household_power_consumption_subset$Date, household_power_consumption_subset$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")


# Remove nulls

household_power_consumption_subset <- household_power_consumption_subset[complete.cases(household_power_consumption_subset),]


# Plot 2

plot(household_power_consumption_subset$datetime, household_power_consumption_subset$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")

# Save into png format

dev.copy(png,"plo2.png", width=480, height=480)
dev.off()
