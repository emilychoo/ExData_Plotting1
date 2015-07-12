## Reading only the data from the dates 2007-02-01 and 2007-02-02 using sqldf package 

library(sqldf)
file <- "./household_power_consumption.txt"
sqlStatement <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
data <- read.csv.sql(file, sql=sqlStatement, sep=";")

# data variable should contain 2880 rows and 9 columns
dim(data) 

# Convert Date variable into Date Class; Time variable into DateTime Class
dateTime <- paste(data$Date,data$Time)
data$Date <- as.Date(data$Date,"%d/%m/%Y")
data$Time <- strptime(dateTime, "%d/%m/%Y %H:%M:%S")


# Open PNG device; create 'plot3.png' in working directory
png(filename="plot3.png", 
    width=480, 
    height=480, 
    units="px", 
    bg="white")

# Create plot and send to png file
# Create the base graph
plot(data$Time, data$Sub_metering_1,
     type="l",
     ylab="Energy sub metering", 
     xlab="")

# Add additional components in graph
lines(data$Time, data$Sub_metering_2,
      type="l",
      col="red")
lines(data$Time, data$Sub_metering_3,
      type="l",
      col="blue")

# Add legend to graph
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), 
       col=c('black', 'red', 'blue'))

# Close the png device
dev.off()
