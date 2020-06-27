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
png("plot4.png")

# Create plot 4
par(mfrow = c(2,2))
plot(df$DateTime, df$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowats)")
plot(df$DateTime, df$Voltage, 
     type = "l", 
     xlab = "", 
     ylab = "Voltage")
plot(df$DateTime, df$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Engergy sub metering")
lines(df$DateTime, df$Sub_metering_2,
      type = "l",
      col = "red")
lines(df$DateTime, df$Sub_metering_3,
      type = "l",
      col = "blue")
legend(x = "topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"),
       cex = 0.5)
plot(df$DateTime, df$Global_reactive_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global reactive power")

# Close .png file
dev.off()

#Remove unwanted files and objects
file.remove(files[2])
rm(files,URL,df)

