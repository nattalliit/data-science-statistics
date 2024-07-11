
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

household_power_consumption <- read_delim("~/Documents/GitHub/datasciencecoursera/4-Exploratory-Data-Analysis/Project/household_power_consumption.txt", 
                                          ";", escape_double = FALSE, trim_ws = TRUE)

class(household_power_consumption$Date)


# Convert date into date format

household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")

# Subset dataset

household_power_consumption_subset <- subset(household_power_consumption, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

data1 <- subset(household_power_consumption, Date %in% c("1/2/2007","2/2/2007"))

# Remove nulls
household_power_consumption_subset <- household_power_consumption_subset[complete.cases(household_power_consumption_subset),]

# Plot 1

# base
plot1base <- hist(household_power_consumption_subset$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

# ggplot
plot1 <- ggplot(household_power_consumption_subset, aes(x=Global_active_power)) + 
  geom_histogram(color="black", fill="red") +
  labs(title="Global active power",x="Global active power (kilowatts)", y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
