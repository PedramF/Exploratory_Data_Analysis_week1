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

#Plot 3

plot3 <- function(data=NULL) {
  if(is.null(data))
    df3 <- load_data()
  
  png("plot3.png", width=480, height=480)

  plot(df3$Time,
       df3$Sub_metering_1,
       type="l",
       xlab="",
       ylab="Energy sub metering")
  
  lines(df3$Time,df3$Sub_metering_2,col="red")
  lines(df3$Time,df3$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"),
         c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
         lty=c(1,1), lwd=c(1,1))
  
dev.off()
print("plot3.png has been saved")

}