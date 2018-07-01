## Assignment 4...
library(stringr)
library(ggmap)
library(ggplot2)
library(dplyr)
library(lubridate)
library(maps)
library(mapproj)

# set the working directory
setwd("C:/Users/alok_/OneDrive/MBA Academics/Second Semester/DSO-545 Statistical Computing and Data Visualization/Assignment/Assignment_4")

# Case# 1..

states_data = read.csv("states_data.csv")


# Q1: Which 5 States saw the largest population growth (as a percentage change, not absolute change) between 2010 and 2016?

states_data = states_data %>%
  mutate(percentage_growth = 100* ((estimate_2016 - census_2010)/census_2010))



states_data_percent_growth_top5 = states_data %>%
                                    top_n(5,percentage_growth) %>%
                                    arrange(-percentage_growth)


print(states_data_percent_growth_top5$state)


#Q2: Add two new variables, month and year, to your dataset that indicates the month and year that each state was added to the union. Which month saw the most states added?


states_data = states_data %>%
  mutate(admission_date_month = month(mdy(admission_date))) %>%
  mutate(admission_date_year = year(mdy(admission_date))) 


states_data %>%
  count(admission_date_month) %>%
  arrange(-n) %>%
  slice(1:1)

states_data = states_data%>%
  mutate(admission_date_year_group = ifelse(admission_date_year<1800, "Before 1800",ifelse(admission_date_year<1850, "1800 - 1849",ifelse(admission_date_year<1900, "1850 - 1899","After 1900"))))


states_maps = map_data("state")

ggplot(states_maps,aes(x=long,y=lat, group=group))+
  geom_polygon(fill="white", color="black")


states_data$state=tolower(states_data$state)

states_data_maps = merge(x=states_maps, y= states_data, by.x="region",by.y="state", all.x = T)


states_data_maps = arrange(states_data_maps,group,order.x)



states_data_maps %>%
  ggplot(aes(x=long,y=lat, group=group, fill=admission_date_year_group))+
  geom_polygon(color="black") +
  scale_fill_manual(values = c("red", "darkorange", "yellow", "purple"), name = "")+
  theme_void()+ 
  coord_map()+
  ggtitle("States by Year Admitted to Union") + 
  theme(plot.title = element_text(hjust = 0.5))



# Q4 Create a new variable called population_density, defined as the the ratio of population to total area, and recreate an EXACT copy of the following graph. Use colors darkred and white. (Note: Please use estimate_2016 rather than census_2016 when computing population_density).
  
  
  states_data_maps = states_data_maps %>%
    mutate(population_density = (estimate_2016/total_area))
  
  states_data_maps %>%
    ggplot(aes(x=long,y=lat, group=group, fill=population_density))+
    geom_polygon(color="black") +
    scale_fill_gradient(low="white",high="darkred", name = "")+ 
    theme_void()+ 
    coord_map() +
    ggtitle("Population Density (persons per sq. mile) by State") + 
    theme(plot.title = element_text(hjust = 0.5))
  

  # Case# 2...
  
  
  california_counties =   read.csv("california_counties.csv")
  
  
  california_counties = california_counties %>%
    mutate(admission_date_year = year(ymd(date_formed))) 
  
  
  california_counties %>%
    ggplot(aes(x=admission_date_year, fill = "Identity"))+
    geom_bar(color="black")+
    scale_fill_manual(values="lightblue",guide = FALSE)
  
  
  # Q 6 - Create a new variable, percent_democrat, defined as the percentage of the population that voted  democrat in each county during the most recent presidential election. Which county had the highest  percentage of the population vote Democrat?
  
  california_counties = california_counties %>%
    mutate(percent_democrat = (100*(democrat/population))) %>%
    arrange(desc(percent_democrat))
  
  high_cal_dem = california_counties %>%
    top_n(1,percent_democrat)

  print("Highest Democrates voters")
  print(high_cal_dem)  

  
  california_counties = california_counties %>%
    mutate(Party = ifelse(democrat>=republican, "Democrat","Republican"))
  
  
  california_map = map_data("county") %>%
    filter(region=="california")
  
  
  california_counties$county=tolower(california_counties$county)
  
  california_counties_maps = merge(x=california_map, y= california_counties, by.x="subregion",by.y="county", all.x = T)
  
  
  california_counties_maps = arrange(california_counties_maps,group,order)
  
  california_counties_maps %>%
    ggplot(aes(x=long,y=lat, group=group, fill=Party))+
    geom_polygon(color="black") +
    scale_fill_manual(values= c("blue","red"), name= " ")+
    theme_void()+ 
    coord_map() +
    ggtitle("California Voters by County") + 
    theme(plot.title = element_text(hjust = 0.5))

  
  
  
  
  