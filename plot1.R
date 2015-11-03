
library(dplyr)

rawdata <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

energy <- rawdata %>%
    filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
    mutate_each(funs(as.numeric), -Date, -Time)

hist(energy$Global_active_power, main = "Global Active Power", col ="red", xlab = "Global Active Power (kilowatts)")

dev.copy(png, "plot1.png")
dev.off()
