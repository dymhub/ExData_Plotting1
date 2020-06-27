# Load relevant packages
library(dplyr)

setwd("~/Desktop/ExData_Plotting1-master") # Set working directory to cloned repository

# Download & unzip data
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, destfile = "./data.zip")
unzip("data.zip")
file.remove("data.zip")


# read data into a df, filter by relevant date, and convert to correct class 
files <- list.files("./", full.names = TRUE)
df <- read.table(files[2], header = TRUE, sep = ";") %>% 
  tbl_df() %>%
  mutate(Date = dmy(Date)) %>%
  filter(Date >= "2007-02-01") %>%
  filter(Date <= "2007-02-02") %>%
  mutate(DateTime = ymd_hms(paste(Date, Time)), 
         Global_active_power = as.numeric(as.character(Global_active_power)),
         Global_reactive_power = as.numeric(as.character(Global_reactive_power)),
         Voltage = as.numeric(as.character(Voltage)),
         Sub_metering_1 = as.numeric(as.character(Sub_metering_1)),
         Sub_metering_2 = as.numeric(as.character(Sub_metering_2)),
         Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))


# Open .png file
png("plot2.png")

# Create plot 1
par(mfrow = c(1,1))
plot(df$DateTime, df$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowats)")

# Close .png file
dev.off()

#Remove unwanted files and objects
file.remove(files[2])
rm(files,URL,df)

