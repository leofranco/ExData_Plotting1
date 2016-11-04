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

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2), oma=c(2,0,0,0))

plot(household_subset$DateTime, household_subset$Global_active_power, type="n", ylab="Global Active Power (kilowatts)",xlab="")
lines(household_subset$DateTime, household_subset$Global_active_power,col="black")

plot(household_subset$DateTime, household_subset$Voltage, type="n", ylab="Voltage",xlab="datetime")
lines(household_subset$DateTime, household_subset$Voltage,col="black",xlab="datetime")

plot(household_subset$DateTime, household_subset$Sub_metering_1, type="n", ylab="Energy sub metering",xlab="")
lines(household_subset$DateTime, household_subset$Sub_metering_1,col="black")
lines(household_subset$DateTime, household_subset$Sub_metering_2,col="red")
lines(household_subset$DateTime, household_subset$Sub_metering_3,col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

plot(household_subset$DateTime, household_subset$Global_reactive_power, type="n", ylab="Global_reactive_power",xlab="datetime")
lines(household_subset$DateTime, household_subset$Global_reactive_power,col="black",xlab="datetime")

dev.off()