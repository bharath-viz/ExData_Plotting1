
#Below code will Unzip and Read delimited source data
#filter source data
source_data <- read.delim(unzip("exdata_data_household_power_consumption.zip",
                                "household_power_consumption.txt"),sep = ";")

#Convert date variable from character to date type 
source_data$Date_num <- as.Date(strptime(source_data$Date,format =  "%d/%m/%Y"))

#Subset data between 2007-02-01 and 2007-02-02
source_eda_data <- subset(source_data,
                          source_data$Date_num >= as.Date("2007-02-01")
                          & source_data$Date_num <= as.Date("2007-02-02"))

source_eda_data$Datetime_num <- strptime(paste(source_eda_data$Date,
                                               source_eda_data$Time),
                                         format =  "%d/%m/%Y %H:%M:%S")
message(
  "Total Observations in filtered data:",
  nrow(source_eda_data),
  "\nFiltered data has a Start date=",
  min(source_eda_data$Datetime_num),
  " and End date=",
  max(source_eda_data$Datetime_num)
)

#Open Graphic device
png("plot4.png")

par(mfrow=c(2,2))

#plot 1-1
plot(source_eda_data$Datetime_num,
     source_eda_data$Global_active_power,
     type ="l",
     ylab = "Global Active Power (Kilowatts)",
     xlab="")

#plot 1-2
plot(source_eda_data$Datetime_num,
     source_eda_data$Voltage,
     type ="l",
     ylab = "Voltage",
     xlab="datetime")

#plot 2-1

plot(source_eda_data$Datetime_num ,
     source_eda_data$Sub_metering_1,type = "l",
     ylab = "Energy sub metering",
     xlab="")

lines(source_eda_data$Datetime_num ,
      source_eda_data$Sub_metering_2,col="red")

lines(source_eda_data$Datetime_num ,
      source_eda_data$Sub_metering_3,col="blue")

legend("topright",col = c("black","red","blue"),lty=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#plot 2-2
plot(source_eda_data$Datetime_num,
     source_eda_data$Global_reactive_power,
     type ="l",
     ylab = "Global_reactive_power",
     xlab="datetime")


#close png graphic device
dev.off()

