
# Roger IL Grande
# EM-622 Project 5


# Load the necessary libraries
library(lubridate)
library(tidyr)
library(dplyr)
library(ggplot2)
library(plyr)
library(reshape)
library(tidyquant)
library(googleVis)
library(highcharter)
library(tidyverse)


# Set working directory
setwd("~/Documents/R Projects")

FIFAData <- read.csv("fifa2019.csv", header = TRUE) # Import FIFA data

View(FIFAData)

str(FIFAData) # Check if the data are imported as correct forms

# Compare agility and strength of lean players over 30 with agility and strength of lean players under 30
# This chart sheds light on the relationship between age, agility, and strength

# Subset data into age, strength, and agility columns only

Age_Strength_Agility <- subset(FIFAData, select = c("Age", "Strength", "Agility", "Body.Type"))

Age_Strength_Agility <- filter(Age_Strength_Agility, Body.Type == "Lean", na.rm = TRUE)



# Subset data into under 25 and over 30

Under_25 <- filter(Age_Strength_Agility, Age < 25, na.rm = TRUE)

Over_30 <- filter(Age_Strength_Agility, Age >= 30, na.rm = TRUE)

Under_25[1:3869, 1:1] <- "Under 25"

Over_30[1:799, 1:1] <- "Over 30"


# Subset into just strength and just agility data

Under_25_Strength <- subset(Under_25, select = c("Age", "Strength"))
Under_25_Agility <- subset(Under_25, select = c("Age", "Agility"))

Over_30_Strength <- subset(Over_30, select = c("Age", "Strength"))
Over_30_Agility <- subset(Over_30, select = c("Age", "Agility"))

Stacked_Strength <- bind_rows(Under_25_Strength, Over_30_Strength) # Stack the data vertically to be used in the box plot
Stacked_Agility <- bind_rows(Under_25_Agility, Over_30_Agility)


# Create the two box plots


ggplot(Stacked_Strength, aes(x=Age, y=Strength, fill=Age)) +
  geom_boxplot(alpha=0.7) +
  scale_fill_brewer(palette="Set1") +
  stat_summary(fun=mean, geom="point", shape=20, size=5, color="red", fill="red") +
  labs(title = "Strength Under 25 vs Strength Over 30", x = "Age", y = "Strength Value") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_y_continuous(breaks=seq(0,100,5)) +
  coord_flip() # Flips the plots to be horizontal


ggplot(Stacked_Agility, aes(x=Age, y=Agility, fill=Age)) +
  geom_boxplot(alpha=0.7) +
  scale_fill_brewer(palette="Set2") +
  stat_summary(fun=mean, geom="point", shape=20, size=5, color="red", fill="red") +
  labs(title = "Agility Under 25 vs Strength Over 30", x = "Age", y = "Strength Value") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_y_continuous(breaks=seq(0,100,5)) +
  coord_flip() # Flips the plots to be horizontal





# Of those with sprint speed of at least 85, what is the percentage breakdown of body types?
# This chart covers two variables: Sprint Speed and Body Type

Fast_Sprinters <- filter(FIFAData, SprintSpeed >= 85, na.rm = TRUE)

Fast_Sprinters <- subset(Fast_Sprinters, select = c("Body.Type"))



ggplot(data=Fast_Sprinters, aes(x = factor(1), fill = factor(Body.Type))) +
  geom_bar(width = 1, stat = "count") +
  coord_polar("y", start=0) +
  theme_void() +
  labs(fill = "Body.Type") +
  geom_text(aes(label = scales::percent(..count.. / sum(..count..))), stat = "count", position = position_stack(vjust = .6)) +
  labs(title = "Fast Sprinters Body Type") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_discrete(name = "Body Type")


# What is the percentage breakdown of preferred foot for goalkeepers?
# This chart covers two variables: Position and Preferred Foot

Goal_Keepers <- filter(FIFAData, Position == "GK", na.rm = TRUE)

Goal_Keepers <- subset(Goal_Keepers, select = c("Preferred.Foot"))


ggplot(data=Goal_Keepers, aes(x = factor(1), fill = factor(Preferred.Foot))) +
  geom_bar(width = 1, stat = "count") +
  coord_polar("y", start=0) +
  theme_void() +
  labs(fill = "Preferred.Foot") +
  geom_text(aes(label = scales::percent(..count.. / sum(..count..))), stat = "count", position = position_stack(vjust = .5)) +
  labs(title = "Goal Keepers Preferred Foot") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_discrete(name = "Preferred Foot")




# Considering players worth at least 1M, who is worth more overall, strikers or wingers?
# This plot covers two variables: Position and value

FIFAData$Value <- gsub("M", "", as.character(FIFAData$Value), n)
FIFAData$Value <- gsub("€", "", as.character(FIFAData$Value), n)

Strikers <- filter(FIFAData, Position =="ST", na.rm = TRUE) # Strikers only

Strikers <- subset(Strikers, select = c("Value", "Position")) # Only value data and position

Strikers$Position <- gsub("ST", "Striker", Strikers$Position)


Wingers <- filter(FIFAData, Position =="RW" | Position == "LW", na.rm = TRUE) # Wingers only

Wingers <- subset(Wingers, select = c("Value", "Position")) # Only value data and position

Wingers$Position <- gsub("RW", "Winger", Wingers$Position)

Wingers$Position <- gsub("LW", "Winger", Wingers$Position)


# Stack data
Stacked_Strikers_Wingers <- bind_rows(Strikers, Wingers) # Stack the data vertically to be used in the box plot

Stacked_Strikers_Wingers <- Stacked_Strikers_Wingers[!grepl("K", Stacked_Strikers_Wingers$Value),] # Remove rows for players not worth at least 1M
Stacked_Strikers_Wingers <- Stacked_Strikers_Wingers[!grepl("-", Stacked_Strikers_Wingers$Value),]

Stacked_Strikers_Wingers$Value <- as.numeric(Stacked_Strikers_Wingers$Value)


# Create the box plot
ggplot(Stacked_Strikers_Wingers, aes(x=Value, y=Position, fill=Value)) +
  geom_boxplot(alpha=0.7) +
  scale_fill_brewer(palette="Set1") +
  stat_summary(fun=mean, geom="point", shape=20, size=5, color="red", fill="red") +
  labs(title = "Strikers vs Wingers Value", x = "Value (€M)", y = "Position") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks=seq(0,125,25))





# Create an interactive world map that shows the average player age and number of players in each country

Nationality_and_Age <- subset(FIFAData, select = c("Nationality", "Age"))

Avg_Age <- aggregate( Age ~ Nationality, Nationality_and_Age, mean ) # Create a data frame with average ages

Avg_Age$Age <- as.integer(Avg_Age$Age) # Remove decimal points

Player_Count <- count(Nationality_and_Age, "Nationality") # Count the number of players from each country

Map_Data <- data.frame(Nationality = c(Avg_Age$Nationality), Number_Players = c(Player_Count$freq), Avg_Age = c(Avg_Age$Age)) # Organize the map data

Map = gvisGeoChart(Map_Data, locationvar="Nationality", colorvar="Number_Players", hovervar="Avg_Age") # Plot the map
plot(Map)





# Create interactive rainfall line plot

rainfallData <- read.csv("rainfall.csv", header = TRUE) # Import the rainfall dataset

# Create the interactive plot
rainfallData %>% hchart(
  'line', hcaes(x = WY, y = Total),
  color = "steelblue")



