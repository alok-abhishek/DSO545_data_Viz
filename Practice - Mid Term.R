## Assignment 1...

# set the working directory
setwd("C:/Users/alok_/OneDrive/MBA Academics/Second Semester/DSO-545 Statistical Computing and Data Visualization/Assignment")

cdcp_data = read.csv("BRFSS.csv")

summary(cdcp_data)

## Find the average, standard deviation, and median of wtdesire (weight desired).

average_wt_desire = mean(cdcp_data$wtdesire)
std_dev_wt_desire = sd(cdcp_data$wtdesire)
median_wt_desire = median(cdcp_data$wtdesire)

## Create a numerical summary for height and age, and compute the interquartile range for each. (hint, look for the summary() command, and search google for how to compute the IQR)

summary(cdcp_data$height)
summary(cdcp_data$age)

IQR(cdcp_data$height)
IQR(cdcp_data$age)

## What is the average age of female respondents?

library(dplyr)

cdcp_data %>%
  filter(gender=='f') %>%
  summarise(avg = mean(age))


cdcp_data_mean_female_age = mean(cdcp_data[cdcp_data$gender=='f',8])

## What proportion of the sample reports being in excellent health? (nrow() might be helpful here)


nrow(cdcp_data[cdcp_data$genhlth=="excellent",])/nrow(cdcp_data)
  
  
## Find the median weight of respondents without health insurance and who had not exercised in the last month.

cdcp_data %>%
  filter(hlthplan==0, exerany==0) %>%
  summarise(median_weight = median(weight))


## Assignment - 2...

setwd("C:/Users/alok_/OneDrive/MBA Academics/Second Semester/DSO-545 Statistical Computing and Data Visualization/Assignment/assignment_2")

## Read the two datasets into two different dataframes, and then combine the two dataframes into one
## using rbind(). (Note: there may be some redundant information that you will need to remove- the two
## datasets have data on years from 2000-2003, so please remove the data for years 2000-2003 (inclusive)
## from the first datafile “US_births_1994_2003.csv”) How many observations are in this newly created dataframe?


US_births_1994_2003 = read.csv("US_births_1994_2003.csv")
US_births_2000_2014 = read.csv("US_births_2000_2014.csv")

US_births_data = rbind(US_births_1994_2003,US_births_2000_2014[US_births_2000_2014$year>2003,])

## How many births occured on Friday the Thirteenth in the US between 1994 and 2014 (inclusive)?

US_births_data %>%
  filter(day_of_week=='Fri',date_of_month=='13') %>%
  summarise(no_brt_fri_13 = sum(births))


## Create an EXACT copy of the following graph. Can you think of any potential reasons for the lower
## amount of births on weekends?

library(ggplot2)

US_births_data %>%
  group_by(day_of_week) %>%
  ggplot(aes(x= day_of_week,y= births)) +
  geom_bar(stat = "identity", fill = "light blue") +
  xlab("")+
  ylab("Birth Count")+
  ggtitle("Number of Births in the US, 1994−2014") + 
  theme(plot.title = element_text(hjust = 0.5))


## Create a dot plot, showing the top 20 countries hosting the highest number of Syrian refugees.

syria_refugees = read.csv("syria_refugees.csv")

syria_refugees %>%
  arrange(desc(refugees)) %>%
  slice(1:20)%>%
  ggplot(aes(x=reorder(Country,refugees),y=refugees))+
  geom_point(stat = "identity") +
  coord_flip() +
  labs(title="Syrian Refugee Crisis",x="",y="Number of Syrian Refugees")+
  theme(plot.title = element_text(hjust = 0.5))

## Create a dot plot, showing the top 20 countries who has the highest percentage increase in their population.

syria_refugees %>%
  mutate(percent_increase = refugees/Population) %>%
  arrange(desc(percent_increase)) %>%
  slice(1:20)%>%
  ggplot(aes(x=reorder(Country,percent_increase),y=percent_increase))+
  geom_point(stat = "identity") +
  coord_flip() +
  labs(title="Syrian Refugee Crisis",x="",y="% of Syrian Refugees")+
  theme(plot.title = element_text(hjust = 0.5))


## Assignment 3...

setwd("C:/Users/alok_/OneDrive/MBA Academics/Second Semester/DSO-545 Statistical Computing and Data Visualization/Assignment/assignment_3")

drinks_data = read.csv("drinks.csv")


## Which countries consume at least 300 (>=300) beer drinks per person?

drinks_data %>%
  filter(beer_servings>=30)


## How many countries consume at least 300 total drinks per person?

drinks_data %>%
  mutate(total_drinks = beer_servings+spirit_servings+wine_servings) %>%
  filter(total_drinks>=300) %>%
  count(country)

## Amongst countries in which at least 300 total drinks were consumed per person, which country drank
## the most beer as a percentage of total drinks consumed, and what is that percentage?

drinks_data %>%
  mutate(total_drinks = beer_servings+spirit_servings+wine_servings) %>%
  filter(total_drinks>=300) %>%
  mutate(percent_beer = 100*(beer_servings/total_drinks)) %>%
  arrange(desc(percent_beer)) %>%
  slice(1:1)
  
  
## Subset your data to include only the top 20 countries in total servings of alcohol consumed per year
## and create and EXACT copy of the following graph.

drinks_data %>%
  mutate(total_drinks = beer_servings+spirit_servings+wine_servings) %>%
  top_n(20,total_drinks) %>%
  ggplot(aes(x=reorder(country,total_drinks),y=total_drinks)) +
  geom_point(stat = "identity")+
  coord_flip()

## Case 2..

congress_data = read.csv("congress.csv")

## Create a dataframe that includes only democrats and republicans.

congress_data %>%
  filter(party=='D'|party=='R')

## Create an EXACT copy of the following graph that shows the age distributin for democrats and
## republicans in the congress.


congress_data %>%
  filter(party=='D'|party=='R') %>%
  group_by(party,age) %>%
  ggplot(aes(x=age, fill=party)) +
  geom_histogram(color='black') +
  facet_grid(.~party) +
  scale_fill_manual(values=c("blue","red"),guide = FALSE) +
  labs(title="Age Distributions for Democrats and Republicans in Congress", x= "Age", y = "Count") +
  theme(plot.title = element_text(hjust = 0.5))
  
  
## Create an EXACT copy of the following graph that shows the distribution of ages for the senate and
## the congress (democrats and republicans combined). (Note: its okay if your graph is wider or narrower,taller or shorter)


congress_data %>%
  filter(party=='D'|party=='R') %>%
  group_by(party,age) %>%
  ggplot(aes(x=chamber, y=age)) +
  geom_boxplot()+
  labs(title="Boxplot of Congressional Age by Chamber",x="Age",y="Chamber") +
  theme(plot.title = element_text(hjust = 0.5))


## Create an EXACT copy of the following graph that shows the number of senate members for both
## democrats and republicans for congress 104 through congress 113.


congress_data %>%
  filter(party=='D'|party=='R') %>%
  group_by(party,age) %>%
  filter(chamber=="senate",congress>=104 & congress<=113) %>%
  ggplot(aes(x=congress, fill = party, group = party)) +
  geom_histogram(position = position_dodge(width = 0.95), binwidth = 1) +
  scale_fill_manual(values=c("blue","red")) +
  scale_x_continuous(breaks = c(104,105,106,107,108,109,110,111,112,113))+
  scale_y_continuous(breaks = c(0,10,20,30,40,50,60))+
  labs(title="Democrat vs Republican in Senate",x="Congress #",y="Count") +
  theme(plot.title = element_text(hjust = 0.5))


## Facebook dataset...

library(MASS)

setwd("C:/Users/alok_/OneDrive/MBA Academics/Second Semester/DSO-545 Statistical Computing and Data Visualization/")
fb_data = read.csv("facebook.tsv",sep="\t")

## Create a bar chart that shows the distribution of the birthdays on each day of the month. Do you see
## anything weird? If so, do further investigation.

fb_data %>%
  group_by(dob_day) %>%
  ggplot(aes(x=dob_day)) +
  geom_bar()+
  scale_x_continuous(breaks = c(1:31)) +
  xlab("Birth Day")


## Create a side by side histogram that shows the friend count distribution for males vs. females.

fb_data %>%
  filter(!is.na(gender)) %>%
  group_by(friend_count) %>%
  ggplot(aes(x=friend_count)) +
  geom_histogram(binwidth = 33) +
  coord_cartesian(xlim=c(0,1000)) +
  scale_x_continuous(breaks = seq(0,1000,200)) +
  facet_wrap(~gender)

## Box Plot..

fb_data %>%
  filter(!is.na(gender)) %>%
  ggplot(aes (x=gender, y=friend_count)) +
  geom_boxplot() +
  coord_cartesian(ylim = c(0,1000))

## Scatter Plot..
fb_data %>%
  ggplot(aes(x=age,y=friend_count))+
  geom_point(size =0.3, alpha=1/10)

#create sense of continiouty by adding jitter..

fb_data %>%
  ggplot(aes(x=age,y=friend_count))+
  geom_jitter(size =0.3, alpha=1/10)


##Biochemical Oxygen Demand
## BOD data set

## if data on the x axis is categorical then we need to specify that all categorical variables are part of same group..
## unless you have two different groups..
## if x axis is numeric then you dont need to use group but.. if you change it to categorical variable then need to specify the group..

ggplot(BOD,aes(x= factor(Time),y=demand,group = "time"))+
  geom_line()+
  scale_y_continuous(limits = c(0,22), breaks = 0:22) +
  geom_point(size=4, shape=16)

## important to have y axis start at 0 to show correct slope and mangnitude.. 
## because time is not defined as vector and instead as num


## ToothGrowth dataset..
## ToothGrowth data set

## use dplyr to compute the average lenght of the tooth for each combination of suppliment and dose ...
## sup(VC,OJ) and dose (0.5,1,2)

Tooth_Growth_data = ToothGrowth

Tooth_Growth_data_average = Tooth_Growth_data %>%
  group_by(supp,dose) %>%
  summarise(average_length=mean(len))

## do a line plot to show dose on x axis and lenght on y axis distingush the lines with color..

Tooth_Growth_data_average %>%
  ggplot(aes(x=dose,y=average_length,group=supp, color=supp)) +
  geom_line()


Tooth_Growth_data_average %>%
  ggplot(aes(x=factor(dose),y=average_length,group=supp, color=supp)) +
  geom_line() +
  scale_y_continuous(limits = c(0,30))


Tooth_Growth_data_average %>%
  ggplot(aes(x=factor(dose),y=average_length,group=supp, color=supp)) +
  geom_line() +
  scale_y_continuous(limits = c(0,30)) +
  scale_color_manual(values = c("red","blue"))

### everything using pipe to save memory...

Tooth_Growth_data %>%
  group_by(supp,dose) %>% 
  summarise(average_length=mean(len)) %>%
  ggplot(aes(x=factor(dose),y=average_length,group=supp, color=supp)) +
  geom_line() +
  scale_y_continuous(limits = c(0,30)) +
  scale_color_manual(values = c("red","blue"))

## plot dashed lines..

Tooth_Growth_data %>%
  group_by(supp,dose) %>% 
  summarise(average_length=mean(len)) %>%
  ggplot(aes(x=factor(dose),y=average_length,group=supp, color=supp)) +
  geom_line(linetype="dashed") +
  scale_y_continuous(limits = c(0,30)) +
  scale_color_manual(values = c("red","blue"))

## plot dashed lines and solid lines...

Tooth_Growth_data %>%
  group_by(supp,dose) %>% 
  summarise(average_length=mean(len)) %>%
  ggplot(aes(x=factor(dose),y=average_length,group=supp, color=supp, linetype=supp)) +
  geom_line() +
  scale_y_continuous(limits = c(0,30)) +
  scale_color_manual(values = c("red","blue"))


## check colors defined in r..
list_of_colors = colors()


Tooth_Growth_data %>%
  group_by(supp,dose) %>% 
  summarise(average_length=mean(len)) %>%
  ggplot(aes(x=factor(dose),y=average_length,group=supp, color=supp, linetype=supp)) +
  geom_line() +
  scale_y_continuous(limits = c(0,30)) + 
  scale_color_manual(values = c("red","blue")) +
  scale_linetype_manual(values=c("solid","dashed"))



### gcookbook..

library(gcookbook)

## uspopage data set...
head(uspopage,10)


## fcous only on the data for kids less than 5 years of age..
## 


uspopage %>%
  filter(AgeGroup == "<5") %>%
  ggplot(aes(x=Year,y=Thousands)) +
  geom_area(fill="lightblue", alpha = 0.7)

## five most populus ages..

uspopage %>%
  group_by(AgeGroup) %>%
  arrange(desc(Thousands)) %>%
  slice(1:5)


## stacked area chart..

uspopage %>%
  ggplot(aes(x=Year,y=Thousands, fill=AgeGroup)) +
  geom_area()

## USE DPLYR TO create a dataset that has a new variable with percentage showing percentage that each age group has for that perticular year..

uspopage %>%
  group_by(Year) %>%
  mutate(percente_of_total=(Thousands/sum(Thousands))*100) %>%
  ggplot(aes(x=Year,y=percente_of_total, fill=AgeGroup)) +
  geom_area() +
  scale_fill_brewer(type="Diverging",palette = "Blues")















