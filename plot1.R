#Below code will Unzip and Read delimited source data
#filter source data
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

png("plot1.png")#Open Graphic device
with(source_eda_data,hist(as.numeric(Global_active_power),col="red",main="Global Active Power",
                          xlab = "Global Active Power (Kilowatts)"))
dev.off()#close gpahic device

