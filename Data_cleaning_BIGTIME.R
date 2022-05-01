library(shiny)
library(tidyverse)
library(scales)
library(plotly)
library(googleVis)
library(rvest)
library(dplyr)
library(plyr)
library(data.table)
library(stringr)
library(gdata)

# Setting work directory
setwd("C:/Users/rober/OneDrive/Documents/Spring 2022 UTSA/R/UFC")

# loading in relevant data files
ufc.hist <- read.csv("UFC_avg.csv")
ufc.odds <- read.csv("UFC_odds.csv")
ufc.athlete <- read.csv("raw_fighter_details.csv")
ufc.fights <- read.csv("total_fight_data.csv")
ufc.totals <- read.csv("UFC_totals_per_fight.csv")

# Subset Data to Common indicators
ufc.totals <- ufc.totals %>% subset(Fight_type %in% c("Bantamweight Bout",  
                                                      "Catch Weight Bout","Featherweight Bout","Flyweight Bout","Heavyweight Bout",
                                                      "Light Heavyweight Bout","Lightweight Bout","Middleweight Bout","Open Weight Bout",
                                                      "UFC Bantamweight Title Bout","UFC Featherweight Title Bout","UFC Flyweight Title Bout",
                                                      "UFC Heavyweight Title Bout",
                                                      "UFC Light Heavyweight Title Bout","UFC Lightweight Title Bout","UFC Lightweight Title Bout",
                                                      "UFC Middleweight Title Bout",
                                                      "UFC Welterweight Title Bout","UFC Women's Bantamweight Title Bout","UFC Women's Featherweight Title Bout",
                                                      "UFC Women's Flyweight Title Bout","UFC Women's Strawweight Title Bout",
                                                      "Welterweight Bout","Women's Bantamweight Bout","Women's Featherweight Bout","Women's Flyweight Bout",
                                                      "Women's Strawweight Bout"))

### Corner Color Winner
ufc.totals$Winner.Color <- fifelse(ufc.totals$R_fighter == ufc.totals$Winner, "Red",
                                   fifelse(ufc.totals$B_fighter == ufc.totals$Winner, "Blue", "Draw"))


### Changing character columns to numeric for analysis/plotting
ufc.totals[,c(3:28)] <- 
  sapply(ufc.totals[,c(3:28)], as.numeric)

ufc.totals$year <- as.numeric(ufc.totals$year) # best choice for output purposes
                                               # otherwise: ufc.totals$year <- format(ufc.totals$year, format="%Y")

save(ufc.totals, file = "ufc.totals.RData")

####################################################################################################################

### Creating New Data more compatible with SHINY

sig_acc <- ufc.totals %>%            
  group_by(year) %>%                         
  summarize(avg=mean(TOTAL_SIG_STR_ACC, na.rm = TRUE)) %>%
  print.data.frame(., digits=4)

plot_ly(sig_acc, x=sig_acc$year, y=sig_acc$name, mode='lines',type='scatter', height=450)



sig_acc <- ufc.totals %>% 
  group_by(Fight_type) %>%
  group_by(year) %>%                         
  summarise_at(vars(TOTAL_SIG_STR_ACC),             
               list(avg = mean), na.rm=TRUE)


############################################################################################

dat <- ufc.totals %>% select(3:28,30,32)

type <- c("Bantamweight Bout","Catch Weight Bout","Featherweight Bout","Flyweight Bout","Heavyweight Bout", "Light Heavyweight Bout","Lightweight Bout","Middleweight Bout","Open Weight Bout","UFC Bantamweight Title Bout","UFC Featherweight Title Bout","UFC Flyweight Title Bout",
          "UFC Heavyweight Title Bout","UFC Light Heavyweight Title Bout","UFC Lightweight Title Bout","UFC Lightweight Title Bout",
          "UFC Middleweight Title Bout","UFC Welterweight Title Bout","UFC Women's Bantamweight Title Bout","UFC Women's Featherweight Title Bout",
          "UFC Women's Flyweight Title Bout","UFC Women's Strawweight Title Bout","Welterweight Bout","Women's Bantamweight Bout","Women's Featherweight Bout","Women's Flyweight Bout",
          "Women's Strawweight Bout")
yrs <- c("1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", 
         "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019",
         "2020", "2021")
Metrics <- c("Knock-Downs","Significant Strikes Landed","Significant Strikes Attempted",
             "Significant Strikes Accuracy","Take-Downs Landed",
             "Take-Downs Attempted","Take-Down Accuracy",
             "Submissions Attempted","Head Strikes Landed","Head Strikes Attempted","Head Strike Accuracy",
             "Body Strikes Landed","Body Strikes Attempted",
             "Body Strike Accuracy","Leg Strikes Landed","Leg Strikes Attempted",
             "Leg Strike Accuracy","Distance Strikes Landed","Distance Strikes Attempted",
             "Distance Strike Accuracy","Clinch Strikes Landed",
             "Clinch Strikes Attempted","Clinch Strike Accuracy")
Tab <- c("Striking", "Striking", "Striking", "Striking", 
         "Grappling", "Grappling", "Grappling", "Grappling", 
         "Head Strikes", "Head Strikes", "Head Strikes", "Body Strikes", 
         "Body Strikes", "Body Strikes", "Leg Strikes", "Leg Strikes", 
         "Leg Strikes", "Striking", "Striking", "Striking", 
         "Grappling", "Grappling", "Grappling")

clean_data <- c(Tab = character(), Metrics = character(), Fight_type = character(), Average = character(), years = character())

for(i in 1:length(type)){
  for (j in 1:length(yrs)) {
      x <- subset(dat, dat$Fight_type == type[i])
      y <- subset(x, x$year == yrs[j])
      avg <- colMeans(y[1:23], na.rm = TRUE)
      iteration <- data.frame(Tab, Metrics, Fight_type = type[i], Average = avg, years=yrs[j])
      clean_data <- rbind(clean_data, iteration)
  }
}

clean_data$years <- as.numeric(clean_data$years)
clean_data$Average <- as.character(clean_data$Average)
clean_data <- dplyr::filter(clean_data, !(Average == "NaN"))
clean_data$Average <- as.numeric(clean_data$Average)


write.csv(clean_data, "clean_data.csv")
save(clean_data, file = "clean_data.RData")
