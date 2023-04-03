## R_DSIS_week13_elements_data_vis.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Data Science for International Studies (DSIS)
## University of Michigan, Winter 2022, Winter 2021, Winter 2020
##
## Week 13
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## For this R tutorial, we will learn how:
##
## (1) make a simple plot() and barplot()
##
## (2a) Explore R color names are available here: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
## (2b) Explore https://colorbrewer2.org/ for a useful place to find colorblind safe color sets.
## (2c) Understand basic color theory for visualization. Specifically, understand a color system and how to use it.
##
## (3) Pull data from a website and generate several plots.
##
## (4) Pull data from ourworldindata.org and generate a plot.
##
## NOTE that you can google: "Quick R graphical parameters" for a good resource for making graphs
## the URL is here: http://www.statmethods.net/advgraphs/parameters.html
##
## R color names are available here: 
## http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
##
## A good article on color systems:
## https://wtamu.edu/~cbaird/sq/2015/01/22/why-are-red-yellow-and-blue-the-primary-colors-in-painting-but-computer-screens-use-red-green-and-blue/
##
## Notes on the efficacy of color systems:
## Any color system is measured by the number of different colors that are created by combinations of the primary colors of that color system. 
## The set of colors is called the "color gamut" of the system. 
## We could estimate the probability of any combination of the set of colors in the color gamut using the probability and set theory we developed in week 9 and week 10 of the course. 
## Some color systems have more total possible colors than others. 
## A color system with a large gamut (more possible combinations from the set) can more effectively represent of different colors, which are all combinations of the primary colors.
## 
##########################################################################

## read in data using read.csv() function
##data <- read.csv("http://cfariss.com/code/ny_stop_frisk.csv")
data <- read.csv("DSIS_Data/ny_stop_frisk.csv")

## inspect the dataset
names(data)
head(data)

## print to screen one of the column names from the dataset data
data$total

## see examples of R color names here: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
COLOR <- "lightblue"


## make a plot using the barplot() function
par(mfrow=c(1,1), mar=c(5,4,4,4))
barplot(data$total)

barplot(data$total,
  beside=T,
  space=0,
  col=COLOR, # I used the named variable defined above instead of naming here
  font=2,
  font.lab=2,
  ylab="Total Stop and Frisks",
  main="Stop and Frisks by Race in 2012",
  xpd=F,
  horiz=F,
  names.arg=data$race,
  ylim=c(0, 1.1*max(data$total)) # I made the top of the plot a little bit larger than the largest value
)

## additional plot elements
box() # add box around plot region


## read in data using read.csv() function
##data <- read.csv("http://cfariss.com/code/ny_stop_frisk_black.csv")
data <- read.csv("DSIS_Data/ny_stop_frisk_black.csv")

## make a plot using the plot() function
par(mfrow=c(1,1))
plot(data$total,
  type="o",
  col="navy",
  bg="lightblue",
  pch=21,
  ylim=c(0, 1.1*max(data$total)), # I made the top of the plot a little bit larger than the largest value
  xlab="Year",
  ylab="Total Stop and Frisks",
  main="Stop and Frisks for African Americans Over Time",
  xaxt="n"
)

# additional plot elements
axis(side=1, at=c(1,2,3,4,5,6,7,8,9,10), label=data$year)



## add multiple plots to one image using the par() function and the mfrow argument
par(mfrow=c(1,2))

## read in data using read.csv() function
##data <- read.csv("http://cfariss.com/code/ny_stop_frisk.csv")
data <- read.csv("DSIS_Data/ny_stop_frisk.csv")
COLOR <- "lightblue"

barplot(data$total, beside=T, space=1, col=COLOR, font=2, font.lab=2, ylab="Total Stop and Frisks", main="Stop and Frisks by Race in 2012", xpd=F, horiz=F, names.arg=data$race, ylim=c(0, 1.1*max(data$total)))
box()

## read in data using read.csv() function
##data <- read.csv("http://cfariss.com/code/ny_stop_frisk_black.csv")
data <- read.csv("DSIS_Data/ny_stop_frisk_black.csv")

## make a plot using the plot() function
plot(data$total, type="o", col="navy", bg="lightblue", pch=21, ylim=c(0, 1.1*max(data$total)), xlab="Year", ylab="Total Stop and Frisks", main="Stop and Frisks for African Americans Over Time", xaxt="n")
axis(side=1, at=c(1,2,3,4,5,6,7,8,9,10), label=data$year)

## go back to just one plot per image
par(mfrow=c(1,1))


## using color to define or reference a known object or entity where the "true" shape is not present in the image
Louise <- c(.25,0.75,2.5,1.0,.05,2.0)
Louise_color <- c("black", "burlywood1", "darkolivegreen3", "burlywood1", "black", "pink")
barplot(Louise)
barplot(matrix(Louise))
barplot(matrix(Louise), col=c(Louise_color), xlim=c(0,5), width=1)

Gene <- c(.15,.15,0.85,1.0,2.0,1.25,1.0)
Gene_color <- c("darkred","white", "burlywood1", "lightblue3", "yellow1", "burlywood1", "black")
barplot(matrix(Gene), col=c(Gene_color), add=T, space=1.5, width=1.25)

Tina <- c(.15,.15,0.85,.75,1.25,1.5,1.0,1.0)
Tina_color <- c("white","black", "white", "burlywood1", "lightblue4", "lightblue2", "burlywood1", "black")
barplot(matrix(Tina), col=c(Tina_color), add=T, space=3.75, width=1)


## triadic colors (programmed with RBG colors)
par(mfrow=c(1,2), mar=c(4,4,2,2))
barplot(c(1,1,1), col=c("red", "green", "blue"), yaxt="n", space=0, main="Primary Colors (Additive)", names.arg=c("red", "green", "blue"))
barplot(c(1,1,1), col=c("cyan", "magenta", "yellow"), yaxt="n", space=0, main="Primary Colors (Subtractive)", names.arg=c("cyan", "magenta", "yellow"))
par(mfrow=c(1,1))

## triadic colors (programmed with RBG colors) plot with the color number
par(mfrow=c(1,2), mar=c(4,4,2,2))
barplot(c(1,1,1), col=c("red", "green", "blue"), yaxt="n", space=0, main="Primary Colors (Additive)", names.arg=c("2", "3", "4"))
barplot(c(1,1,1), col=c("cyan", "magenta", "yellow"), yaxt="n", space=0, main="Primary Colors (Subtractive)", names.arg=c("5", "6", "7"))
par(mfrow=c(1,1))

## complementary colors (programmed with RBG colors)
par(mfrow=c(2,3), mar=c(4,4,2,2))
barplot(c(1,1), col=c("cyan", "red"), yaxt="n", space=0, names.arg=c("cyan", "red"))
barplot(c(1,1), col=c("magenta", "green"), yaxt="n", space=0, names.arg=c("magenta", "green"))
barplot(c(1,1), col=c("yellow", "blue"), yaxt="n", space=0, names.arg=c("yellow", "blue"))
barplot(c(1,1), col=c(5, 2), yaxt="n", space=0, names.arg=c("5", "2"))
barplot(c(1,1), col=c(6, 3), yaxt="n", space=0, names.arg=c("6", "3"))
barplot(c(1,1), col=c(7, 4), yaxt="n", space=0, names.arg=c("7", "4"))
par(mfrow=c(1,1))


## color wheel(programmed with RBG colors)
library(grDevices)
par(mfrow=c(2,2), mar=c(1,1,1,1))
pie(rep(1,6), col=rainbow(6), border=NA, labels=c("red", "yellow", "green", "cyan", "blue", "magenta"))
pie(rep(1,12), col=rainbow(12), border=NA)
pie(rep(1,24), col=rainbow(24), labels=NA, border=NA)
pie(rep(1,256), col=rainbow(256), labels=NA, border=NA)
par(mfrow=c(1,1))

## split complementary colors (user selected from Rcolor.pdf)
par(mfrow=c(3,3))
barplot(c(1,2,3), col=c("darkslateblue", "darkolivegreen1", "orange"), yaxt="n")
barplot(c(1,2,3), col=c("darkslateblue", "green", "orange"), yaxt="n")
barplot(c(1,2,3), col=c("darkorchid4", "green", "orange"), yaxt="n")
barplot(c(1,2,3), col=c("darkorchid", "green", "darkorange2"), yaxt="n")
barplot(c(1,2,3), col=c("orange", "lightblue", "darkred"), yaxt="n")
barplot(c(1,2,3), col=c("darkorange", "navy", "yellow"), yaxt="n")
barplot(c(1,2,3), col=c("red", "navy ", "darkolivegreen1"), yaxt="n")
barplot(c(1,2,3), col=c("red","navy ", "seagreen1 "), yaxt="n")
barplot(c(1,2,3), col=c("yellow", "darkorchid4", "turquoise3"), yaxt="n")
par(mfrow=c(1,1))


## colors in hexidemical codes (taken from colorbrewer2.org)
COLORS <- c("#ffffcc", "#a1dab4", "#41b6c4", "#2c7fb8", "#253494")

## a simple barplot using the colors from above
barplot(c(1,2,3,4,5), col=COLORS)


#####################################################################################
## example using up-to-date data on COVID cases and recoveries
## download data from github
recovered_data <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv")
confirmed_case_data <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")

## set high point for the graphs (use log based 2 value; see more below)
high_point <- round(max(log2(c(apply(confirmed_case_data[,-c(1:4)],2,sum)))))
high_point

## reset the parameters for the plot space
par(mfrow=c(1,3), mar=c(4,2,1,5))

## plot the log base 2 data. This makes the y-axis units a doubling from 1 to 2 to 4 to 8 to 16 ...
plot(log2(apply(confirmed_case_data[,-c(1:4)],2,sum)), ylim=c(0, high_point), ylab="", xlab="Days since 1/22/2020", yaxt="n", main="Confirmed Cases", pch=21, col="#d95f02", bg="#fc8d62")
for(i in 1:high_point){ abline(h=i, lwd=.5, lty=2) }
axis(side=2, at=1:high_point, las=2)
axis(side=4, at=c(1:high_point), labels=rep("",high_point), las=2)
mtext(side=4, "log-base-2 (1-unit change on the y-axis is a doubling of cases)",line=2)

plot(log2(apply(recovered_data[,-c(1:4)],2,sum)), ylim=c(0,high_point), ylab="", xlab="Days since 1/22/2020", yaxt="n", main="Recovered Cases", pch=21, col="#1b9e77", bg="#66c2a5")
for(i in 1:high_point){ abline(h=i, lwd=.5, lty=2) }
axis(side=2, at=1:high_point, las=2)
axis(side=4, at=c(1:high_point), labels=rep("",high_point), las=2)

plot(log2(apply(confirmed_case_data[,-c(1:4)],2,sum) - apply(recovered_data[,-c(1:4)],2,sum)), ylim=c(0,high_point), ylab="", xlab="Days since 1/22/2020", yaxt="n", main="Confirmed but not yet Recovered Cases", pch=21, col="#7570b3", bg="#8da0cb")
for(i in 1:high_point){ abline(h=i, lwd=.5, lty=2) }
axis(side=4, at=c(1:high_point), labels=2^c(1:high_point), las=2)
#axis(side=4, at=c(5,10,15,20), labels=2^c(5,10,15,20), las=2)
axis(side=2, at=1:high_point, las=2)

## let's combine the three time series plots into one plot with all of the color coded points

## reset the parameters for the plot space
par(mfrow=c(1,1), mar=c(4,4,1,5))

## make plot
plot(log2(apply(confirmed_case_data[,-c(1:4)],2,sum)), ylim=c(0, high_point), ylab="", xlab="Days since 1/22/2020", yaxt="n", main="COVID-19 Cases", pch=21, col="#d95f02", bg="#fc8d62")

## add more points
points(log2(apply(recovered_data[,-c(1:4)],2,sum)), ylim=c(0,high_point), pch=21, col="#1b9e77", bg="#66c2a5")
points(log2(apply(confirmed_case_data[,-c(1:4)],2,sum) - apply(recovered_data[,-c(1:4)],2,sum)), pch=21, col="#7570b3", bg="#8da0cb")
for(i in 1:high_point){ abline(h=i, lwd=.5, lty=2) }
axis(side=4, at=c(1:high_point), labels=2^c(1:high_point), las=2)
axis(side=2, at=1:high_point, las=2)
mtext(side=2, "log-base-2 (1-unit change on the y-axis is a doubling of cases)",line=2)

legend("bottomleft", legend=c("Confirmed Cases", "Recovered Cases", "Confirmed but not yet Recovered Cases"), fill=c("#fc8d62", "#66c2a5", "#8da0cb"), bty="n", bg="white")



## reset the parameters for the plot space
dev.off()
par(mfrow=c(1,1), mar=c(4,4,1,5))

## make plot with the count (not logged based).
plot(apply(confirmed_case_data[,-c(1:4)],2,sum), 
     ylab="", 
     xlab="Days since 1/22/2020", 
     yaxt="n", 
     main="COVID-19 Cases", 
     pch=21, 
     col="#d95f02", 
     bg="#fc8d62")

## add more points
points(apply(recovered_data[,-c(1:4)],2,sum), ylim=c(0,high_point), pch=21, col="#1b9e77", bg="#66c2a5")
points(apply(confirmed_case_data[,-c(1:4)],2,sum) - apply(recovered_data[,-c(1:4)],2,sum), pch=21, col="#7570b3", bg="#8da0cb")
for(i in 2^(1:high_point)){ abline(h=i, lwd=.5, lty=2) }
axis(side=4, at=2^(1:high_point), labels=2^c(1:high_point), las=2)
#axis(side=2, at=2^(1:high_point), las=2)
#axis(side=2, at=1:high_point, las=2)
mtext(side=2, "log-base-2 (1-unit change on the y-axis is a doubling of cases)",line=2)

legend("topleft", legend=c("Confirmed Cases", "Recovered Cases", "Confirmed but not yet Recovered Cases"), fill=c("#fc8d62", "#66c2a5", "#8da0cb"), bty="n", bg="white")


## make a barplot version with the count data
par(mfrow=c(1,3), mar=c(6,1,1,5))

## print the day before the starting date to screen as a "Date"
as.Date("01/21/2020", "%m/%d/%y")

## add one to the day before the start date
as.Date("01/21/2020", "%m/%d/%y") + 1

## make a sequence of dates
date_range <- as.Date("01/21/2020", "%m/%d/%y") + 1:ncol(confirmed_case_data[,-c(1:4)])
date_range

barplot(apply(confirmed_case_data[,-c(1:4)],2,sum), 
        ylab="", 
        xlab="", 
        yaxt="n", 
        main="Confirmed Cases", 
        space=0, 
        border="#d95f02", 
        col="#fc8d62", 
        ylim=c(0,2^high_point), 
        names.arg=date_range, 
        las=2)
axis(side=4, at=2^(1:high_point), labels=2^c(1:high_point), las=2)
box()

barplot(apply(recovered_data[,-c(1:4)],2,sum), 
        yaxt="n", 
        main="Recovered Cases", 
        space=0, border="#1b9e77", 
        col="#66c2a5", 
        ylim=c(0,2^high_point), 
        names.arg=date_range, 
        las=2)
axis(side=4, at=2^(1:high_point), labels=2^c(1:high_point), las=2)
box()

barplot(apply(confirmed_case_data[,-c(1:4)],2,sum) - apply(recovered_data[,-c(1:4)],2,sum), 
        yaxt="n", 
        main="Confirmed  but not yet Recovered", 
        space=0, 
        border="#7570b3", 
        col="#8da0cb", 
        ylim=c(0,2^high_point), 
        names.arg=date_range, 
        las=2)
axis(side=4, at=2^(1:high_point), labels=2^c(1:high_point), las=2)
box()

#legend("topleft", legend=c("Confirmed Cases", "Recovered Cases", "Confirmed but not yet Recovered Cases"), fill=c("#fc8d62", "#66c2a5", "#8da0cb"), bty="n", bg="white")


#####################################################################################
## replicate an ourworldindata graph: https://ourworldindata.org/covid-vaccinations
##
## obtain the csv data
##
##vaccine_data <- read.csv("https://github.com/owid/covid-19-data/tree/master/public/data/vaccinations/locations.csv")
vaccine_data <- read.csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv")
names(vaccine_data)

## print the system date
Sys.Date()

## use the system date to calcuate the dates that are most recent
vaccine_data$most_recent_date <- Sys.Date() - as.Date(vaccine_data$date)
dim(vaccine_data)
table(vaccine_data$most_recent_date)

names(vaccine_data)

## subset only the country's with the most recent dates
#vaccine_data_last <- subset(vaccine_data, most_recent_date==1 & !is.na(people_fully_vaccinated_per_hundred))
vaccine_data_last <- subset(vaccine_data, most_recent_date==min(vaccine_data$most_recent_date) & !is.na(people_fully_vaccinated_per_hundred))
dim(vaccine_data_last)


## pull out the relevant column-vector of data for plotting

##vaccine_data_last$people_fully_vaccinated_per_hundred[is.na(vaccine_data_last$people_fully_vaccinated_per_hundred)] <- 0

values <- vaccine_data_last$people_fully_vaccinated_per_hundred
location_names <- vaccine_data_last$location

## https://colorbrewer2.org/#type=qualitative&scheme=Paired&n=5
COLORS_QUALITATIVE<- c("#a6cee3", "#1f78b4", "#b2df8a", "#33a02c", "#fb9a99")

## https://colorbrewer2.org/#type=sequential&scheme=YlGnBu&n=5
COLORS_SEQUENTIAL <- c("#ffffcc", "#a1dab4", "#41b6c4", "#2c7fb8", "#253494")

## https://colorbrewer2.org/#type=sequential&scheme=YlGnBu&n=9
COLORS_SEQUENTIAL_9 <- c("#ffffd9", "#edf8b1", "#c7e9b4", "#7fcdbb", "#41b6c4", "#1d91c0", "#225ea8", "#253494", "#081d58")

## same versions as above with the lightest color replicated for all the rest after the first 9
COLORS_SEQUENTIAL_9_rep <- c(rep("#ffffd9", length(values)-9), COLORS_SEQUENTIAL_9)

## same versions as above with the lightest color replicated for all the rest after the first 9
COLORS_SEQUENTIAL_9_rep_each <- c(rep(COLORS_SEQUENTIAL_9, each=length(values)/9))
COLORS_SEQUENTIAL_9_rep_each

## set some graphical parameters
par(mfrow=c(1,1), mar=c(4,10,3,3))

## make a sweet barplot
barplot(values[order(values, decreasing=FALSE)],
        xlim=c(0,100),
        xlab="People fully vaccinated per hundred",
        space=0,
        horiz=TRUE,
        main="Share of the population\nfully vaccinated against COVID-19",
        names.arg=location_names[order(values, decreasing=FALSE)],
        las=2,
        xaxt="n",
        col=COLORS_SEQUENTIAL_9_rep,
        cex.names=0.65)

axis(side=1, at=c(0,10,20,30,40,50,60,70,80,90,100))

axis(side=4, at=1:length(values), labels=values[order(values, decreasing=FALSE)], las=2, cex.axis=0.65)

abline(v=70, lty=2, col=grey(.5), lwd=2)

box()




#####################################################################################
# Replicates Figure 1: Number of physical integrity rights allegations over time by organization
# Cordell, Rebecca, K. Chad Clay, Christopher J. Fariss, Reed M. Wood, and Thorin M. Wright. "Recording Repression: Identifying Physical Integrity Rights Allegations in Annual Country Human Rights Reports" International Studies Quarterly (Accepted).
#####################################################################################

## hard coded numbers in tabular format read in as a character string
reports.year <- read.table(text = "1999  2000  2001   2002   2003   2004   2005   2006    2007   2008   2009   2010   2011   2012  2013  2014  2015  2016
                            H 804  821 1029  897    0  463  559  641  717  717  757  798  980  941  962  991 1002  991
                            A 1841 2074 1915 1902 1768 1639 1482 1549 1539 1539 1568 1673 1768 1748    0 1606 1578 1473
                            S 6976 8749 9298 7654 6654 6302 6385 7294 6538 6538 7202 7166 5555 5909 5636 5750 5493 5557", header = TRUE,check.names = FALSE)
reports.year

# generate the plot
par(mar=c(6, 5, 5, 9), xpd=TRUE)
reports<-barplot(as.matrix(reports.year),
                 col = c("darkslategrey", "darkcyan", "mediumseagreen"),
                 legend.text=c("Human Rights Watch", "Amnesty International", "US State Department"), xlab="Year", ylab="Number of Allegations", font.main = 4,args.legend = list(x = "topright", bty = "n", inset=c(-0.25, 0), title="Organization"))

par(mar=c(5,5.5,2,.5), mfrow=c(1,3), cex.lab=1.25, font=2)
barplot(as.matrix(reports.year[1,]), space=0, las=2, col="darkslategrey", main="Human Rights Watch", ylim=c(0,10000))
mtext(side=2, "Number of Allegations", line=4.0, cex.lab=1.25)
barplot(as.matrix(reports.year[2,]), space=0, las=2, col="darkcyan", main="Amnesty International", ylim=c(0,10000))
barplot(as.matrix(reports.year[3,]), space=0, las=2, col="mediumseagreen", main="US State Department", xlab="", ylim=c(0,10000))


#####################################################################################
## Always graph your data!
## 
## see https://en.wikipedia.org/wiki/Anscombe%27s_quartet for more details
Anscombes_quartet <- read.csv("http://cfariss.com/code/Anscombes_quartet.csv")
Anscombes_quartet <- read.csv("DSIS_Data/Anscombes_quartet.csv")

apply(Anscombes_quartet,2,mean)
apply(Anscombes_quartet,2,var)

lm(y1 ~ x1, data=Anscombes_quartet)
lm(y2 ~ x2, data=Anscombes_quartet)
lm(y3 ~ x3, data=Anscombes_quartet)
lm(y4 ~ x4, data=Anscombes_quartet)

summary(lm(y1 ~ x1, data=Anscombes_quartet))$r.squared
summary(lm(y2 ~ x2, data=Anscombes_quartet))$r.squared
summary(lm(y3 ~ x3, data=Anscombes_quartet))$r.squared
summary(lm(y4 ~ x4, data=Anscombes_quartet))$r.squared

## plot Anscombes quartet data
par(mfrow=c(2,2), mar=c(4,4,1,1))
plot(Anscombes_quartet$x1, Anscombes_quartet$y1, ylim=c(3,13), xlim=c(3,19), pch=21, bg="darkorange", col="darkorange4", xaxt="n")
abline(reg=lm(y1 ~ x1, data=Anscombes_quartet), col="blue")
axis(side=1, at=c(4,6,8,10,12,14,16,18))

plot(Anscombes_quartet$x2, Anscombes_quartet$y2, ylim=c(3,13), xlim=c(3,19), pch=21, bg="darkorange", col="darkorange4", xaxt="n")
abline(reg=lm(y1 ~ x1, data=Anscombes_quartet), col="blue")
axis(side=1, at=c(4,6,8,10,12,14,16,18))

plot(Anscombes_quartet$x3, Anscombes_quartet$y3, ylim=c(3,13), xlim=c(3,19), pch=21, bg="darkorange", col="darkorange4", xaxt="n")
abline(reg=lm(y1 ~ x1, data=Anscombes_quartet), col="blue")
axis(side=1, at=c(4,6,8,10,12,14,16,18))

plot(Anscombes_quartet$x4, Anscombes_quartet$y4, ylim=c(3,13), xlim=c(3,19), pch=21, bg="darkorange", col="darkorange4", xaxt="n")
abline(reg=lm(y1 ~ x1, data=Anscombes_quartet), col="blue")
axis(side=1, at=c(4,6,8,10,12,14,16,18))


#####################################################################################
## replication of an Rplot I made in 2010 when I took my PhD exams (comprehensive exams)
comps <- read.csv("http://cfariss.com/code/comps_coffee_drinks.csv")
##comps <- read.csv("comps_coffee_drinks.csv")

#dev.off() ## resets the plot area if anything weird is happening
par(mfrow=c(1,1))
barplot(as.matrix(t(comps[,c(2,3,4)])), beside=FALSE, col=c(3,4,"orangered"), ylim=c(0,14.5), space=c(0,0) , xlab="", ylab="drink number by type", main="Caffeine Consumption Count-Down \n to Comprehensive Exams", font.lab=2, cex.lab=1.25)

axis(side=1, at=seq(from=0, to=nrow(comps)-1, by=1), labels=comps$date, las=2,cex.axis=0.75)

abline(v=26, lwd=3, col=1, lty=2)
abline(v=34, lwd=3, col=1, lty=2)

text(6, 13.0, "drink count", cex=1.25, col="lightsteelblue4", font=2)
text(6, 12.5, "espresso shot", cex=1.25, col="orangered", font=2)
text(6, 12.00, "regular coffee", cex=1.25, col="blue", font=2)
text(6, 11.5, "mountain dew", cex=1.25, col=3, font=2)

text(28.60, 11.70, "written \n exams \n 05/10 \n 05/11 \n 05/13", cex=1.00, col=1, font=2)
text(36.5, 12.20, "exam    \n defense \n 05/18  ", cex=1.00, col=1, font=2)

text(20, 14.0, "EXAM=PASS", cex=1.00, col=2, font=2)


mu.final <- mean(na.omit(comps$coffee + comps$dew + comps$espresso))
text(16, 13.0, labels=substitute(mu==mu.final, list(mu.final=mu.final)), cex=1.00, col="lightsteelblue4", font=2)

mu.final <- mean(na.omit(comps$espresso))
text(16, 12.5, labels=substitute(mu==mu.final, list(mu.final=mu.final)), cex=1.00, col="orangered", font=2)

mu.final <- mean(na.omit(comps$coffee))
text(16, 12.00, labels=substitute(mu==mu.final, list(mu.final=mu.final)), cex=1.00, col="blue", font=2)

mu.final <- mean(na.omit(comps$dew))
text(16, 11.5, labels=substitute(mu==mu.final, list(mu.final=mu.final)), cex=1.00, col=3, font=2)


