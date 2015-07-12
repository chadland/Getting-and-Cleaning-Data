#1.Download file 
library(RCurl)
URL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
x <- getURL(URL)
out <- read.csv(textConnection(x))
head(out)

#2.How many properties are worth $1,000,000 or more? 
sum(out$VAL==24,na.rm = TRUE)
#53

#Use the data you loaded from Question 1. Consider the variable FES in the code book. 
#Which of the "tidy data" principles does this variable violate? 
out$FES

#Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
  
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
install.packages('XLConnect')
library('XLConnect')
URL <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'
download.file(URL, 'c:\\temp\\test.xlsx', mode="wb")
library(xlsx)
dat <- read.xlsx("c:\\temp\\test.xlsx",startRow = 18, endRow = 23,colIndex = seq(7,15,1),sheetName = "NGAP Sample Data")
#Read rows 18-23 and columns 7-15 into R and assign the 
#result to a variable called:  dat  What is the value of:  

sum(dat$Zip*dat$Ext,na.rm=T)  
#36534720

#(original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

#4. Read the XML data on Baltimore restaurants from here: 
  
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 

#How many restaurants have zipcode 21231? 

require(XML)
library(XML)
data <- xmlParse("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml")
xml_data <- xmlToList(data)
xmltop <- xmlRoot(data) 
xmlName(xmltop[[1]])
xmlName(xmltop)

zipcode <- as.numeric(xpathSApply(xmltop,"//row//zipcode", xmlValue))
sum(zipcode==21231)
#[1] 127

#The American Community Survey distributes downloadable data about United States 
#communities. Download the 2006 microdata survey about housing for the state of 
#Idaho using download.file() from here:
  
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

#using the fread() command load the data into an R object  
#DT  Which of the following is the fastest way to calculate the average 
#value of the variable pwgtp15 

library(data.table)
URL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(URL, 'c:\\temp\\pid.csv', mode="wb")
DT <- fread("c:\\temp\\pid.csv")

system.time(tapply(DT$pwgtp15,DT$SEX,mean)) #0.02
system.time(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15)) #0.01
system.time(mean(DT$pwgtp15,by=DT$SEX)) #0, does not calculate average of both sexes
system.time(rowMeans(DT)[DT$SEX==1])
system.time(DT[,mean(pwgtp15),by=SEX]) #0
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)) #0.01

#DT[,mean(pwgtp15),by=SEX]
