## load the file; limit number of rows and specify classes to speed up the load
x<-read.table("household_power_consumption.txt", header = TRUE, sep = ";",na.strings ="?",nrows=70000)
## convert the Date and Time variables to Date/Time classes
x$Date<-as.Date(x$Date,format="%d/%m/%Y")
## select relevant dates
x<-x[x$Date>"2007-01-31"&x$Date<"2007-02-03",]
y<-paste(x$Date,x$Time)
Date_Time<-strptime(y,format="%Y-%m-%d %H:%M:%S")
##add the new column
data<-cbind(Date_Time,x)
## plot
png(file = "plot2.png",width = 480, height = 480,)
plot(data$"Date_Time",data$"Global_active_power",xlab="",ylab="Global Active Power (kilowatts)",type="l")
dev.off()