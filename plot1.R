library(dplyr)

#read data from zip file
data <- read.table(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), header=T, sep=";")

#subset only used data, excluding missing value
data_sub<-subset(data, (
  (strptime(Date, "%d/%m/%Y")==strptime("1/2/2007","%d/%m/%Y"))
  |
  (strptime(Date, "%d/%m/%Y")==strptime("2/2/2007","%d/%m/%Y"))
  )
  &Global_active_power!="?")

#remove unused variable "data"
rm(data)

#create the graphic in a png file
png(filename = "plot1.png", width = 480, height = 480)
graph1<-as.numeric(data_sub$Global_active_power)
hist(graph1, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

#close the png device
dev.off()