## data cleaning with R 

## loading the libraries 
library(tidyverse)
library(ggplot2)

# loading the data 
land <- read.csv("C:/Users/Atolb/publiclands.csv")
# to get an overview of the data
glimpse(land)
summary(land)
# to get the number of rows and columns
nrow(land)
ncol(land)

# to get unique values
unique(land$State)
sum(is.na(land))

###  there are 50 regions in the United States , but we only have 42 states , so we will add the 8 remaining states with their corresponding publiclandacres  # nolint

missing_states <- tibble(State = c('Connecticut','Delaware','Hawai','Iowa','Maryland','Massachusetts','New Jersey','Rhode Island'),PublicLandAcres = c(0,0,0,0,0,0,0,0)) # nolint

# using the function rbind , since we have created 2 datatframe withe the same column names , we can use rbind function to merge them  # nolint
land <- rbind(land,missing_states)

# using the aggregate function 
mean (land$PublicLandAcres)
sum(land$PublicLandAcres)

## loading a new dataset 
employees <- read.csv("C:/Users/Atolb/employees.csv")
sum(employees$Salary) # its value is NA because there is an entry with NA value 
# we should na.rm = TRUE , to get the correct value 
sum(employees$Salary,na.rm=TRUE)
mean(employees$Salary,na.rm=TRUE)
min(employees$Salary,na.rm=TRUE)
max(employees$Salary,na.rm=TRUE)

## loading a new dataset ##
continents <- read.csv("C:/Users/Atolb/continents.csv")
## we have duplicated data for the contient Europe and Antarctica , to get unique values  # nolint
unique(continents$Continent)

continents <- continents %>% 
filter(!(Continent == 'Antarctica' & Population > 100000)) # to select data different from Antarctica and population > 100000 # nolint

## loading a new dataset ##
carpinteria <- read.csv("C:/Users/Atolb/population.csv")
glimpse(carpinteria) # 16 rows and 2 columns 

## filter the data to exclude the lines of the total 
carpinteria <- carpinteria %>% 
filter(!(Subject %in% c('Total','Female','Male')))

###### FORMATTING DATA IN R #########
weather <- read.csv("C:/Users/Atolb/mexicanweather.csv")
# adding year , month , day to the dataset
install.packages("lubridicate")
library(lubridate)
# creating columns
weather$year <- year(weather$date)
weather$month <- month(weather$date)
weather$day <- day(weather$date)


# Let's make this dataset t a little wider to get the 
# minimum and maximum temperatures as part of the same observation.
# That requires the spread function

library(tidyverse)
weather <- weather %>%
  spread(element, value) # this will create columns (TMAX AND TMIN) with their value 
sum(is.na(weather))

# filter the NAS values out of the data 
weather <- weather %>%
  filter(!(is.na(TMAX) & is.na(TMIN)))
  sum(is.na(weather$TMAX))
# count the na values per column
colSums(is.na(weather))
na_count <- sapply(weather, function(y) sum(length(which(is.na(y))))) # another way of doing it  # nolint
na_count <- data.frame(na_count)

## renaming the columns 
weather <- weather %>%
rename(maxtemp=TMAX,mintemp=TMIN) %>% 
select(station,date,mintemp,maxtemp)

# divide the temperature by 10 for the max and min  temperature 
weather <- weather %>% 
mutate(maxtemp=maxtemp/10)%>% 
mutate(mintemp=mintemp/10)

# numbers stored as text 

# the columns are without name , to name the columns , we create a vector with the names ´ # nolint

names <- c("DRG","ProviderID","Name","Address","City","State","ZIP","Region","Discharges", # nolint
           "AverageCharges" ,"AverageTotalPayments","AverageMedicarePayments"
           )
inpatient <- read_tsv("C:/Users/Atolb/inpatient.tsv",skip=1,col_names=names)
summary(inpatient)
# defining explicitly , the data types : c stands for character , i for integer , n stands for number  # nolint
types <- 'ciccccccinnn' # nolint
inpatient <- read_tsv("C:/Users/Atolb/inpatient.tsv",skip=1,col_names=names,col_types=types) # nolint
summary(inpatient)

### INCONSISTENT SPELLING ### 
names <- c('inspectionID','RestaurantName' , 'OtherName','LicenseNumber','FacilityType','Risk', # nolint
           'Address','City','State','ZIP','InspectionDate','InspectionType','Results','Violations',
           'Latitude' , 'Longitude','Location')

Inspection <- read_csv("C:/Users/Atolb/inspections.csv")
names(Inspection) <- names
Inspection <- data.frame(Inspection)
glimpse(Inspection)

# calculate total inspections per restaurant and arrange them in a descending order  # nolint
Inspection %>% 
group_by(RestaurantName) %>%
summarize(Inspection=n()) %>% 
arrange(desc(Inspection))

# detecting the outliers
whitehouse <- read_csv("C:/Users/Atolb/whitehouse.csv", col_types = "ccncci" )
# to detect the outliers , we can use boxplots 
boxplot(whitehouse$Salary)
# there seems to be some outliers in the data , some officers with a salary greater than 1 million which is not normal  # nolint

whitehouse %>%
  filter(Salary > 1000000) # there are 2 cases 

whitehouse %>%
mutate(Salary=ifelse(Salary > 1000000,NA,Salary)) # replace thoses cases with NA  # nolint

## outliers in subgroups 
tests <- read.csv("C:/Users/Atolb/testscores.csv")
# check for outliers in the age variable
boxplot(tests$age) # students over 15 years in the elementary school 
tests %>% 
filter(age > 15)
# replace those values 
tests <- tests %>% 
mutate(age=ifelse(studentID==10115,7,age)) %>% 
mutate(age=ifelse(studentID==10116,12,age))
boxplot(tests$age~tests$grade)

# # long datasets versus wide datasets : wide datasets have more columns , long datasets have more rows  # nolint
pew <- read_csv("C:/Users/Atolb/pew.csv")
pew.long <- gather(pew,income,freq,-religion)
ncol(pew.long)

# make long datasets wider 
weather <- read_csv("C:/Users/Atolb/mexicanweather.csv")
weather.wide <- spread(weather,element,value) #  # nolint

## review gather and spread

