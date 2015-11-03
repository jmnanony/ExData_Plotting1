
library(dplyr)

rawdata <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

energy <- rawdata %>%
    filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
    mutate_each(funs(as.numeric), -Date, -Time) %>%
    mutate(DateTime = paste(Date, Time))

energy$DateTime <- strptime(energy$DateTime, "%d/%m/%Y %H:%M:%S")

with(energy, plot(DateTime, Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering"))
with(energy, points(DateTime, Sub_metering_2, col = "red", type = "l"))
with(energy, points(DateTime, Sub_metering_3, col = "blue", type = "l"))
legend("topright", text.width = 55000, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, "plot3.png")
dev.off()
