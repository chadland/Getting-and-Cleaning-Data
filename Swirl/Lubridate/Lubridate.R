Sys.getlocale("LC_TIME")
library(lubridate)
help(package = lubridate)
this_day<-today()
this_day
month(this_day)
wday(this_day)
wday(this_day, label=TRUE)
this_moment <- now()
this_moment
hour(this_moment)
my_date <- ymd("1989-05-17")
my_date
class(my_date)
ymd("1989 May 17")
mdy("March 12, 1975")
dmy(25081985)
ymd("1920.1.2")
ymd("1920/1/2")
dt1
ymd_hms(dt1)
help(lubridate)
dt2
ymd(dt2)
update(this_moment, hours = 8, minutes = 34, seconds = 55)
this_moment
this_moment <- update(this_moment, hours = 10, minutes = 09, seconds = 55)
this_moment
nyc <- now(tzone = "America/New_York")
nyc
depart <- nyc + days(2)
depart
depart<- update(depart, hours = 17, minutes = 34)
arrive <- depart + hours(15) + minutes(50)
?with_tz
arrive <- with_tz(arrive, tzone = "Asia/Hong_Kong")
arrive
last_time <- mdy("Juni 17, 2008",tz = "Singapore")
how_long <- new_interval(start = last_time, arrive)
mdy("Juni 17, 2008")
?new_interval
as.period(how_long)

stopwatch()

