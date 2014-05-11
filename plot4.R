## load the file; limit number of rows and specify classes to speed up the load
x<-read.table("household_power_consumption.txt", header = TRUE, sep = ";",na.strings ="?",nrows=70000)
## convert the Date and Time variables to Date/Time classes
x$Date<-as.Date(x$Date,format="%d/%m/%Y")
## select relevant dates
x<-x[x$Date>"2007-01-31"&x$Date<"2007-02-03",]
y<-paste(x$Date,x$Time)
Date_Time<-strptime(y,format="%Y-%m-%d %H:%M:%S")
## add the new column
data<-cbind(Date_Time,x)
## plot
png(file = "plot4.png",width = 480, height = 480,)
par(mfrow = c(2,2)) ##sets up a matrix of plots 
with(data,{
    ## plot2 
    plot(Date_Time,Global_active_power,xlab="",ylab="Global Active Power",type="l")
    ## new plot top right
    plot(Date_Time,Voltage,xlab="datetime",ylab="Voltage",type="l")
    ## plot3
    plot(Date_Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    lines(Date_Time,Sub_metering_1,col="grey60",type="l",lwd=2)
    lines(Date_Time,Sub_metering_2,col="red",type="l")
    lines(Date_Time,Sub_metering_3,col="blue",type="l")
    meters<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
    colours<-c("grey60","red","blue")
    legend("topright", lty = 1, lwd = 2,col = colours, legend = meters,bty="n")
    ## new plot bottom right
    plot(Date_Time,Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
})
dev.off()