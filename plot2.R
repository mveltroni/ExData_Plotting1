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
png(filename = "plot2.png", width = 480, height = 480)
graph2<-as.numeric(data_sub$Global_active_power)
plot(graph2,type = "l", ylab="Global Active Power (kilowatts)", xaxt = "n", xlab="")
axis(1,at=c(0,length(data_sub$Date)/2,length(data_sub$Date)),labels=c("Thu", "Fri", "Sat"))

#close the png device
dev.off()