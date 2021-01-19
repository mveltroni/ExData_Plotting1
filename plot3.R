library(dplyr)

#read data from zip file
data <- read.table(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), header=T, sep=";")

#subset only used data, excluding missing value
data_sub<-subset(data, (
  (strptime(Date, "%d/%m/%Y")==strptime("1/2/2007","%d/%m/%Y"))
  |
  (strptime(Date, "%d/%m/%Y")==strptime("2/2/2007","%d/%m/%Y"))
  )
  &Sub_metering_1!="?"
  &Sub_metering_2!="?"
  &Sub_metering_3!="?")

#remove unused variable "data"
rm(data)

#create the graphic in a png file
png(filename = "plot3.png", width = 480, height = 480)
graph<-as.numeric(data_sub$Sub_metering_1)
plot(graph,type = "l", ylab="Energy sub metering", xaxt = "n", xlab="")
axis(1,at=c(0,length(data_sub$Date)/2,length(data_sub$Date)),labels=c("Thu", "Fri", "Sat"))
graph<-as.numeric(data_sub$Sub_metering_2)
lines(graph, col="red")
graph<-as.numeric(data_sub$Sub_metering_3)
lines(graph, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"),lty=1, lwd=2)

#close the png device
dev.off()

