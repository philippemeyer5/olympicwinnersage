#Olympic gold medal winners by age and sport
#packages

library(tidyverse)
library(Rmisc)
install.packages('ggthemes', dependencies = TRUE)
library(ggthemes)

data <- read.csv("C:/Users/Iudex/Desktop/r experiments/Olympic sports by age/athlete_events.csv", header = TRUE)
summary(data)

#filter for gold medals and summer games
datafiltered <- data %>% filter(Season == "Summer", Medal == "Gold", Age > 1)
summary(datafiltered)

#aggregate on sport level
aggregate(datafiltered[,4], list(datafiltered$Sport), mean)
#quite the difference between sports. How to plot it?

#aggregate on year level
aggregate(datafiltered[,4], list(datafiltered$Year), mean)
#Not too much of a development here

x <- summarySE(datafiltered, measurevar="Age", groupvars=c("Sex","Sport" ))
x[is.na(x)] <- 0

png(file="C:/Users/Iudex/Desktop/r experiments/Olympic sports by age/age_sport.png",width=1280, height=720)
ggplot(x,aes(x=Sport, y=Age, color=Sex)) + 
      geom_errorbar(aes(ymin=Age-sd, ymax=Age+sd), width=.1) +
      geom_line() +
      geom_point() +
      theme_economist() +
      scale_colour_economist() +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) 
dev.off()

#a + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

