#Data

load_data <- function() {
  filename <- "household_power_consumption.txt"
  df <- read.table(filename,
                   header=TRUE,
                   sep=";",
                   colClasses=c("character", "character", rep("numeric",7)),
                   na="?")
  
  # convert date and time variables to Date/Time class
  df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
  df$Date <- as.Date(df$Date, "%d/%m/%Y")
  
  # only use data from the dates 2007-02-01 and 2007-02-02
  dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
  df <- subset(df, Date %in% dates)
  
  return(df)
  
}

#Plot4

plot4 <- function(data=NULL) {
  if(is.null(data))
    df4 <- load_data()
  
  png("plot4.png", width=480, height=480)

  par(mfrow=c(2,2))

  ##Plot 1 small
  plot(df4$Time,df$Global_active_power, type="l", xlab="", ylab="Global Active Power")

  ##Plot 2 small
  plot(df4$Time,df$Voltage, type="l", xlab="datetime", ylab="Voltage")

  ##Plot 3 smal
  plot(df4$Time,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(df4$Time,df$Sub_metering_2,col="red")
  lines(df4$Time,df$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly

  #Plot 4 small
  plot(df4$Time,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
print("plot4.png has been saved")

}