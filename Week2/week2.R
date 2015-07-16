#Q1
#Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on 
#your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to 
#find the time that the datasharing repo was created. What time was it created? This tutorial may be useful 
#(https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "e32d957e6729b6e13cde",
                   secret = "c0df88b7dea0a90551d59a3363154ffa632d945b")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
install.packages("rjson")
library(rjson)

json <- content(req)
json1 <- jsonlite::fromJSON(toJSON(json))
json1[which(json1$name == "datasharing"),]$created_at

#Answer: "2013-11-07T13:25:07Z"


#Q2
#The sqldf package allows for execution of SQL commands on R 
#data frames. We will use the sqldf package to practice the queries we might send with the 
#dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an 
#R object called

# acs

library(RCurl)
library(sqldf)
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
x <- getURL(URL)
acs<- read.csv(textConnection(x))
head(acs)
result <- sqldf("select pwgtp1 from acs where AGEP < 50")

#Answer: sqldf("select pwgtp1 from acs where AGEP < 50")

#Q3
#Using the same data frame you created in the previous problem, what is the equivalent 
#function to unique(acs$AGEP)
result <- sqldf("select distinct AGEP from acs")

#Answer: sqldf("select distinct AGEP from acs")


#Q4
#How many characters are in the 10th, 20th, 30th and 100th 
#lines of HTML from this page: 
  
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)
htmlCode
nchar(htmlCode[c(10,20,30,100)])

#Answer: 45 31  7 25

#Q5
#Read this data set into R and report the sum of the numbers in the fourth of the nine columns. 
#https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
#Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
#(Hint this is a fixed width file format)


fwf.file <- read.fwf(
  file=url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
  skip=4,
  widths=c(12, 7,4, 9,4, 9,4, 9,4))

head(fwf.file)
sum(fwf.file[,4])

#Answer: 32426.7
