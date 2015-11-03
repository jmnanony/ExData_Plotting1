
library(dplyr)

rawdata <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

energy <- rawdata %>%
    filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
    mutate_each(funs(as.numeric), -Date, -Time) %>%
    mutate(DateTime = paste(Date, Time))

energy$DateTime <- strptime(energy$DateTime, "%d/%m/%Y %H:%M:%S")


par(mfcol = c(2,2), cex = 0.7)
with(energy, {
plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(DateTime, Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering")
points(DateTime, Sub_metering_2, col = "red", type = "l")
points(DateTime, Sub_metering_3, col = "blue", type = "l")
legend("topright", bty= "n", text.width = 85000, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(DateTime, Voltage, col = "black", type = "l", xlab = "datetime", ylab = "Voltage")
plot(DateTime, Global_reactive_power, col = "black", type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})


dev.copy(png, "plot4.png")
dev.off()
