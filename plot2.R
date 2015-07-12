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


# Open PNG device; create 'plot2.png' in working directory
png(filename="plot2.png", 
    width=480, 
    height=480, 
    units="px", 
    bg="white")

# Create plot and send to png file
plot(data$Time, data$Global_active_power,
     type="l",
     ylab="Global Active Power (kilowatts)", 
     xlab="")

# Close the png device
dev.off()
