library(tidyr)
#http://vita.had.co.nz/papers/tidy-data.pdf

students
?gather
gather(students, sex, count, -grade)

students2
res <- gather(students2, sex_class, count, -grade)
res
?separate
separate(res, sex_class, into=c("sex", "class"))

?spread

extract_numeric("class5")

students4

passed
failed

passed <- mutate(passed, status="passed")
failed <- mutate(failed, status="failed")

bind_rows(passed,failed)

sat