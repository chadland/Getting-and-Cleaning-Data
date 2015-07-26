ls()

#swirl is a software package that turns the R console into an 
#interactive learning environment. In this programming assignment, 
#you'll have the opportunity to earn up to 3 extra credit points while using swirl
#to practice some key concepts that extend the material covered in the lectures.

#You may find parts of this assignment to be fairly challenging. S
#tick with it and don't hesitate to turn to the forums if you get stuck!
  
library(swirl)
install_from_swirl("Getting and Cleaning Data")
swirl()

#4. Get extra credit for your work!
  
#Upon completing each lesson, swirl will ask for your Coursera credentials:
#Course ID: getdata-030
#Submission login (email): The email address associated with your Coursera account
#Submission password: This is NOT the password that you use to log into the 
#Coursera website. Your submission password can be found at the top of the Programming Assignments page.

#User ID
#2245958 

#Submission Login
#Christer.Hadland@gmail.com 

#Submission Password
#zKarJxvSMm   

#1
mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
dim(mydf)
head(mydf)

library(dplyr)
packageVersion("dplyr")

cran <- tbl_df(mydf)
rm("mydf")

?select
select(cran, ip_id, package, country)

5:20
select(cran, r_arch:country)
select(cran, country:r_arch)

cran

select(cran, -time)
select(cran, -(X:size))

filter(cran, package == "swirl")
filter(cran, r_version == "3.1.1", country == "US")

?Comparison
help(filter)

filter(cran, r_version <= "3.0.2", country == "IN") 
filter(cran, country =="US" | country == "IN")
filter(cran, size>100500, r_os=="linux-gnu")

is.na(c(3, 5, NA, 10))
!is.na(c(3, 5, NA, 10))

filter(cran, !is.na(r_version))

cran2 <- select(cran, size:ip_id)

arrange(cran2, ip_id)

arrange(cran2, desc(ip_id))

arrange(cran2, package, ip_id)

arrange(cran2, country, desc(r_version), ip_id)

cran3 <- select(cran, ip_id, package, size)
cran3

mutate(cran3, size_mb = size / 2^20, size_gb=size_mb/2^10)

mutate(cran3, correct_size = size+1000)

summarize(cran, avg_bytes = mean(size)) 

#Q2
library(dplyr)
cran <- tbl_df(data = mydf)
rm("mydf")
cran
help(group_by)
by_package <- group_by(.data = cran, package)
by_package
summarize(by_package,mean(size))

quantile(pack_sum$count, probs = 0.99) #679.56
top_counts <- filter(pack_sum,count > 679)
top_counts
View(top_counts)
top_counts_sorted <- arrange(top_counts, desc(count))
View(top_counts_sorted)

quantile(pack_sum$unique, probs = 0.99)
top_unique <- filter(pack_sum,unique > 465)
View(top_unique)
top_unique_sorted <- arrange(top_unique, desc(unique))

View(top_unique_sorted)
View(result3)
