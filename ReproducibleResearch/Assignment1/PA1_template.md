---
title: 'Reproducible Research: Assignment 1'
author: "Amin"
date: "Friday, October 09, 2015"
output: html_document
---

This is the report for the peer assignemt 1 of the course of Reproducible Research on Coursera. The aim of this assignment is to use data from a personal activity monitoring device and do some basic exploratory data analysis and generate a short report.

#Loading and preprocessing the data
The data is in a zipped csv file called activity.zip, We load the data as a data frame called "actData". We also remove the rows with NA values from the  data frame and save it as another data frame called "actDataComp". 

```r
actData <- read.csv(unzip(zipfile="activity.zip"))
actDataComp <- actData[complete.cases(actData),]
head(actData)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```

```r
head(actDataComp)
```

```
##     steps       date interval
## 289     0 2012-10-02        0
## 290     0 2012-10-02        5
## 291     0 2012-10-02       10
## 292     0 2012-10-02       15
## 293     0 2012-10-02       20
## 294     0 2012-10-02       25
```

#What is mean total number of steps taken per day?
In this part, we ignore the missing values in the data frame and use the "actDataComp". Firstly, we calculate the total number of steps taken per day using the aggregate function.  

```r
totalSteps <- aggregate(steps~date, data=actDataComp, sum)
head(totalSteps)
```

```
##         date steps
## 1 2012-10-02   126
## 2 2012-10-03 11352
## 3 2012-10-04 12116
## 4 2012-10-05 13294
## 5 2012-10-06 15420
## 6 2012-10-07 11015
```
  
  The histogram of the total steps per day is as follows:  

```r
hist(totalSteps$steps,breaks=10)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png) 
  
  The bar plot of the total steps per day is given below:  

```r
barplot(totalSteps$step, main="Total steps per day", xlab="day")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 
  
  The difference between these plots is a kind of obvious. The bar plot gives the value of steps for every date, while the histogram counts the days which its number of steps falls in the specific interval.  
  
  The mean and median of the total steps per day is given below.

```r
totStepMean <- mean(totalSteps$steps)
totStepMed <- median(totalSteps$steps)
totStepMean
```

```
## [1] 10766.19
```

```r
totStepMed
```

```
## [1] 10765
```

#What is the average daily activity pattern?
In this part, the number of steps is averaged across all days to calculate the average activity pattern.

```r
pattSteps <- aggregate(steps~interval, data=actDataComp, mean)
```

  The result is:

```r
plot(pattSteps$interval,pattSteps$steps)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png) 

  The 5-minute interval with maximum number of steps is:

```r
MaxInterval <- pattSteps[which.max(pattSteps$steps),]
MaxInterval
```

```
##     interval    steps
## 104      835 206.1698
```

#Imputing missing values
Firstly, we calculate the total number of rows with missing data in the original data frame.

```r
sum(!complete.cases(actData))
```

```
## [1] 2304
```

  We replace the missing values with the average for the 5-minute interval.
Firstly, we calculate the total number of rows with missing data in the original data frame. For this, we use the "pattSteps" data frame.

```r
actDataFill <- actData
for(i in 1:nrow(actDataFill)) {
  if(is.na(actDataFill$steps[i])) {
    actDataFill$steps[i] <- as.integer(pattSteps[pattSteps$interval==actDataFill$interval[i],]$steps)
  }
}
head(actDataFill)
```

```
##   steps       date interval
## 1     1 2012-10-01        0
## 2     0 2012-10-01        5
## 3     0 2012-10-01       10
## 4     0 2012-10-01       15
## 5     0 2012-10-01       20
## 6     2 2012-10-01       25
```

  The histogram of the total number of steps per day is as follows.

```r
totalStepsFill <- aggregate(steps~date, data=actDataFill, sum)
hist(totalStepsFill$steps,breaks=10)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png) 

  The mean and median of the total steps per day for thew filled data frame are:

```r
totStepMeanFill <- mean(totalStepsFill$steps)
totStepMedFill <- median(totalStepsFill$steps)
totStepMeanFill
```

```
## [1] 10749.77
```

```r
totStepMedFill
```

```
## [1] 10641
```

  The values of the mean and median are different, but the differences are not that significant. It seems that the bias of the missing values are not that significant.
  
#Are there differences in activity patterns between weekdays and weekends?
For this part, we add a new factor variable as a new column to the data frame with two levels- "weekday" and "weekend".

```r
Days <- factor(weekdays(as.Date(actDataFill$date)))
levels(Days) <- list(weekday=c("Monday","Tuesday","Wednesday","Thursday","Friday"),weekend=c("Saturday","Sunday"))
actDataFill$day <- Days
head(actDataFill)
```

```
##   steps       date interval     day
## 1     1 2012-10-01        0 weekday
## 2     0 2012-10-01        5 weekday
## 3     0 2012-10-01       10 weekday
## 4     0 2012-10-01       15 weekday
## 5     0 2012-10-01       20 weekday
## 6     2 2012-10-01       25 weekday
```

  Now, we calculate the average number of steps taken per 5-minute interval, for the weekdays and weekends, separately.

```r
meanData <- aggregate(steps ~ interval + day, data=actDataFill, mean)
head(meanData)
```

```
##   interval     day      steps
## 1        0 weekday 2.15555556
## 2        5 weekday 0.40000000
## 3       10 weekday 0.15555556
## 4       15 weekday 0.17777778
## 5       20 weekday 0.08888889
## 6       25 weekday 1.57777778
```

  The plot for the result is given below.

```r
library(ggplot2)
ggplot(meanData,aes(interval,steps)) + geom_line() + facet_grid(day~.)
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15-1.png) 

  The plot shows that the pattern of number of steps for the weekdays is different from that of weekends.
