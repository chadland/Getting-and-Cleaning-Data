#Q1
#The American Community Survey distributes downloadable data about United States communities. 
#Download the 2006 microdata survey 
#about housing for the state of Idaho using download.file() from here: 

library(RCurl)
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
x <- getURL(URL)
micro.data.survey.2006<- read.csv(textConnection(x))
head(micro.data.survey.2006)

#Create a logical vector that identifies the households on greater than 10 acres 
#who sold more than $10,000 worth of agriculture products. 
#Assign that logical vector to the variable agricultureLogical. 
#Apply the which() function like this to identify the rows of the data frame where 
#the logical vector is TRUE. 
#which(agricultureLogical) What are the first 3 values that result?

agricultureLogical <- micro.data.survey.2006$ACR==3 & micro.data.survey.2006$AGS==6
head(which(agricultureLogical),3)

#Answer: 125 238 262

#Q2

#Using the jpeg package read in the following picture of your instructor into R 

#https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 

#Use the parameter native=TRUE. What are the 30th and 80th quantiles of 
#the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

library(RCurl)
library(jpeg)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
f <- file.path(getwd(), "jeff.jpg")
download.file(url, f, mode = "wb") "#wb binary"
help(download.file)
img <- readJPEG(f, native = TRUE)
quantile(img, probs = c(0.3, 0.8))

#Answer:
#30%       80% 
#  -15259150 -10575416 

#Q3
#Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 

#Load the educational data from this data set: 
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 

#Match the data based on the country shortcode. How many of the IDs match? 
#Sort the data frame in descending order by GDP rank (so United States is last). 
#What is the 13th country in the resulting data frame? 

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
NROW(unique(data.merged$Long.Name.y))

#Answer: 189
Gross.Domestic.Product[order(Gross.Domestic.Product$rankingGDP,decreasing = TRUE),][13,]

#CountryCode rankingGDP           Long.Name   gdp
#179         KNA        178 St. Kitts and Nevis  767 

#Q4
#What is the average GDP ranking for the "High income: OECD" and 
#"High income: nonOECD" group?

mean(data.merged[data.merged$Income.Group == "High income: OECD",c("rankingGDP")])
mean(data.merged[data.merged$Income.Group == "High income: nonOECD",c("rankingGDP")])

#Answer: 32.96667, 91.91304

#Q5
#Cut the GDP ranking into 5 separate quantile groups. 
#Make a table versus Income.Group. How many countries are Lower middle 
#income but among the 38 nations with highest GDP?

data.merged$quantilegroup <- cut(data.merged$rankingGDP,labels = FALSE, breaks = 5)
NROW(data.merged[which(data.merged$Income.Group == "Lower middle income" & data.merged$quantilegroup==1), ])

#Answer: 5
