
library(dplyr)

rawdata <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

energy <- rawdata %>%
    filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
    mutate_each(funs(as.numeric), -Date, -Time) %>%
    mutate(DateTime = paste(Date, Time))

energy$DateTime <- strptime(energy$DateTime, "%d/%m/%Y %H:%M:%S")

with(energy, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.copy(png, "plot2.png")
dev.off()
