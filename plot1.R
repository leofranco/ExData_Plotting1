library(readr)

# read all the data into memory
household <- read_delim("household_power_consumption.txt",delim=";",col_types="ccnnnnnnn",na=c("na","?"))

# create one new variable paring the Date and Time columns
DateTime <- strptime(paste(household$Date,household$Time),format="%d/%m/%Y %H:%M:%S")
household <- cbind(DateTime,household)

# We only need a small subset of this data
# so we are going to subset it
datetime1 <- strptime("01/02/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")
datetime2 <- strptime("02/02/2007 23:59:59",format="%d/%m/%Y %H:%M:%S")
household_subset <- household[ (household$DateTime>=datetime1) & (household$DateTime<=datetime2) , ]

png(filename = "plot1.png", width = 480, height = 480)
hist(household_subset$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()