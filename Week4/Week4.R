#Question 1
#The American Community Survey distributes downloadable data about United States communities. 
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
  
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 

#and load the data into R. The code book, describing the variable names is here: 
  
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

#Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
#What is the value of the 123 element of the resulting list?

library(RCurl)
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
x <- getURL(URL)
micro.data.survey.2006<- read.csv(textConnection(x))
head(micro.data.survey.2006)
help(strsplit)
names(micro.data.survey.2006)

strsplit(names(micro.data.survey.2006), "wgtp")[123]

#Answer: [1] ""   "15"

#Question 2
#Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
  
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 

#Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 

#Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table

library(RCurl)
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
x <- getURL(URL)
Gross.Domestic.Product<- read.csv(textConnection(x), skip=4, nrows=215)
Gross.Domestic.Product<-Gross.Domestic.Product[which(Gross.Domestic.Product$X!="" & is.na(Gross.Domestic.Product$X.1)==FALSE), c("X", "X.1", "X.3", "X.4")]
names(Gross.Domestic.Product) <- c("CountryCode", "rankingGDP", "Long.Name", "gdp")
head(Gross.Domestic.Product)

mean(as.numeric(paste0(gsub(",", "", Gross.Domestic.Product$gdp))))

#Answer: 377652.4

#Question 3
#In the data set from Question 2 what is a regular expression that would
a#llow you to count the number of countries whose name begins with "United"? 
#Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

grep("*United",Gross.Domestic.Product$Long.Name), 5
grep("*United",Gross.Domestic.Product$Long.Name), 2
grep("^United",Gross.Domestic.Product$Long.Name), 3
grep("^United",Gross.Domestic.Product$Long.Name), 4

#Answer: grep("^United",Gross.Domestic.Product$Long.Name), 3

#Question 4
#Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
  
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 

#Load the educational data from this data set: 
  
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 

#Match the data based on the country shortcode. Of the countries for which the 
#end of the fiscal year is available, how many end in June? 

#Original data sources: 
# http://data.worldbank.org/data-catalog/GDP-ranking-table 
# http://data.worldbank.org/data-catalog/ed-stats

library(RCurl)
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
x <- getURL(URL)
Gross.Domestic.Product<- read.csv(textConnection(x), skip=4, nrows=215)
Gross.Domestic.Product<-Gross.Domestic.Product[which(Gross.Domestic.Product$X!="" & is.na(Gross.Domestic.Product$X.1)==FALSE), c("X", "X.1", "X.3", "X.4")]
names(Gross.Domestic.Product) <- c("CountryCode", "rankingGDP", "Long.Name", "gdp")
head(Gross.Domestic.Product)
NROW(Gross.Domestic.Product)

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
x <- getURL(URL)
educational.data<- read.csv(textConnection(x))
head(educational.data)
NROW(educational.data)

#merge data
data.merged <- merge(x =Gross.Domestic.Product,y=educational.data,all=FALSE, by = "CountryCode" )
head(data.merged)
NROW(data.merged)
names(data.merged)
data.merged$Special.Notes

sum(grepl('June 30', data.merged$Special.Notes))

#Answer: 13

#Question 5
#You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly 
#traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price 
#and get the times the data was sampled.

library(quantmod)
library(xts)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
head(sampleTimes)

#How many values were collected in 2012? How many values were collected on Mondays in 2012?
head(amzn)
NROW(amzn["20120101/20121231"])

amzn.2012 <- amzn["20120101/20121231"]
sum(.indexwday(amzn.2012)==1)

#Answer; 250, 47

