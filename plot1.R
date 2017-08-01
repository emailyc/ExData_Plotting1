if(!file.exists("household_power_consumption.txt")) { #Check wether the folder containing the data sets exists in the working directory.
        if(!file.exists("exdata-data-household_power_consumption.zip")){ # If not then see whether the zip file exist. #If not then download it.
                switch(Sys.info()[['sysname']],
                       Windows = {download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                                                "exdata-data-household_power_consumption.zip", method = "wininet", mode = "wb")},
                       Linux  = {download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                                               "exdata-data-household_power_consumption.zip", method="curl")},
                       Darwin = {download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                                               "exdata-data-household_power_consumption.zip", method="curl")})
                unzip(normalizePath("exdata-data-household_power_consumption.zip"), exdir=getwd()) #And unzip it
                unlink("exdata-data-household_power_consumption.zip", recursive = T)
        } else if (file.exists("exdata-data-household_power_consumption.zip")) { # If the zip exists then unzip it.
                unzip(normalizePath("exdata-data-household_power_consumption.zip"), exdir=getwd())
                unlink("exdata-data-household_power_consumption.zip", recursive = T)
        }
}

library(dplyr)
library(lubridate)

hihi = read.table("household_power_consumption.txt", header = T, sep = ';', stringsAsFactors = F, na.strings = '?',
                  colClasses = c(rep("character",2),rep("numeric",7))) %>% 
        .[grep("^[1-2]/2/2007", .$Date),] %>% 
        transform(., Date = as.Date(.$Date,format='%d/%m/%Y'))


png(file = 'plot1.png', width = 480, height = 480, bg = NA)
hist(hihi$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
dev.off()