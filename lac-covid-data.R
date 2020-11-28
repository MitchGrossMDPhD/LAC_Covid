library(tidyverse)
library(dslabs)
library(readxl)
# see working directory
getwd()
setwd("/users/144fa/Documents/R")
# set path to the location for raw data files in the dslabs package and list files
path <- system.file("extdata", package="dslabs")
list.files(path)



path <- system.file("extdata", package = "dslabs")
files <- list.files(path)
files


#-------  Try reading internet files 

# Table: Cases/Death by Date
url <- "https://lacdph.shinyapps.io/covid19_surveillance_dashboard/_w_a0d76298/session/ff8c0f907b3edf832fd7d810355480bf/download/download3?w=a0d76298"

##Table: Tests by Date
url_testing <- "https://lacdph.shinyapps.io/covid19_surveillance_dashboard/_w_a0d76298/session/ff8c0f907b3edf832fd7d810355480bf/download/download6?w=a0d76298"
# consider using read_csv(url) to directly download 
dat <- read_csv(url)
download.file(url, "lacdph-cases.csv")
download.file(url_testing, "lacdph-testing.csv")
dat2 <- "lacdph-testing.csv"
testing <- read_csv("lacdph-testing.csv")

tempfile()
tmp_filename <- tempfile()
download.file(url, tmp_filename)
dat <- read_csv(tmp_filename)
file.remove(tmp_filename)

#dat <- read_csv("lacdph-cases.csv")
p <- ggplot(dat,aes(as.Date(date_use),new_case, avg_cases)) +
  geom_line() +
  xlab("")
p


ggplot(dat,aes(x=as.Date(date_use), y = value)) + 
  geom_line(aes(y = new_case)) + 
   geom_smooth(aes(y = avg_cases),color="grey50",alpha = 0.5,method="gam",na.rm=TRUE) +
  ggtitle("LA County Daily Cases and 7 day average (smoothed)")



ggplot(testing, aes(x=as.Date(date_use), y=value)) +
    geom_smooth(aes(y=parse_number(percent_positive_tests))) + 
    ggtitle("LAC County Daily Tests and Percent Positive")

# took this out of graph: geom_line(aes(y=as.numeric(tests))) +

currentDate <- Sys.Date()
x <-"lacdph-cases.csv"
y <- "lacdph-testing.csv"
#cvsFileName <-"blank"
csvFileName <- paste(currentDate,x,sep="")
csvTestingDate <-paste(currentDate,y,sep="")

write_csv(dat, csvFileName) 

write_csv(testing, csvTestingDate) 

# # Dummy data
# data <- data.frame(
#   day = as.Date("2017-06-14") - 0:364,
#   value = runif(365) + seq(-140, 224)^2 / 10000
# )
# 
# # Most basic bubble plot
# p <- ggplot(data, aes(x=day, y=value)) +
#   geom_line() + 
#   xlab("")
# p




#----------- read using R-base functions
# filename <- "murders.csv"
# filename1 <- "life-expectancy-and-fertility-two-countries-example.csv"
# filename2 <- "fertility-two-countries-example.csv"
# dat=read.csv(file.path(path, filename))
# dat1=read.csv(file.path(path, filename1))
# dat2=read.csv(file.path(path, filename2))
# 
# fullpath1 <-file.path(path,filename1)
# file.copy(fullpath1, filename1)
# fullpath2 <-file.path(path,filename2)
# file.copy(fullpath2, filename2)