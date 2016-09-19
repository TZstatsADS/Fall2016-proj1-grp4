library(data.table)
library(dplyr)
detach(package:plyr)
setwd("/Users/nianyiqun/Documents/stat/data science/project1")
varToKeep <- c("PWGTP","ST","SCHL","AGEP","SEX","MSP","WAGP","CIT","COW","WKHP","RAC1P","JWMNP","MARHT","MARHYP","RETP","ANC","DIS","ESR","FOD1P","NATIVITY","OC","OCCP","PERNP","MAR","POVPIP","QTRBIR")
length(varToKeep)

data1 <- fread('ss13pusa.csv',select = varToKeep)
data2 <- fread('ss13pusb.csv',select = varToKeep)

dataAll <- rbind(data1,data2)


# change factors   married status
dataAll$MAR <- factor(dataAll$MAR)
marryStatus <- c("Married","Widowed","Divorced","Separated","Never married or under 15 years old")
levels(dataAll$MAR) <- marryStatus

# change factors     ancestor
dataAll$ANC <- factor(dataAll$ANC)
ancStatus <- c("Single","Multiple","Unclassified","Not reported")
levels(dataAll$ANC) <- ancStatus

# change factor    wage last year
dataAll$WAGP2[dataAll$WAGP %in% c(0:10000)] <- "0-10k"
dataAll$WAGP2[dataAll$WAGP %in% c(10000:20000)] <- "10-20k"
dataAll$WAGP2[dataAll$WAGP %in% c(20000:30000)] <- "20-30k"
dataAll$WAGP2[dataAll$WAGP %in% c(30000:40000)] <- "30-40k"
dataAll$WAGP2[dataAll$WAGP %in% c(40000:50000)] <- "40-50k"
dataAll$WAGP2[dataAll$WAGP %in% c(50000:60000)] <- "50-60k"
dataAll$WAGP2[dataAll$WAGP %in% c(60000:70000)] <- "60k-70k"
dataAll$WAGP2[dataAll$WAGP %in% c(70000:80000)] <- "70k-80k"
dataAll$WAGP2[dataAll$WAGP %in% c(80000:90000)] <- "80k-90k"
dataAll$WAGP2[dataAll$WAGP %in% c(90000:100000)] <- "90k-100k"


# change factor occupation 

dataAll$OCCP1[dataAll$OCCP >= 0010 & dataAll$OCCP <= 0430] <- "MGR"
dataAll$OCCP1[dataAll$OCCP >= 0500 & dataAll$OCCP <= 0740] <- "BUS"
dataAll$OCCP1[dataAll$OCCP >= 0800 & dataAll$OCCP <= 0950] <- "FIN"
dataAll$OCCP1[dataAll$OCCP >= 1005 & dataAll$OCCP <= 1240] <- "CMM"
dataAll$OCCP1[dataAll$OCCP >= 1300 & dataAll$OCCP <= 1560] <- "ENG"
dataAll$OCCP1[dataAll$OCCP >= 1600 & dataAll$OCCP <= 1965] <- "SCI"
dataAll$OCCP1[dataAll$OCCP >= 2000 & dataAll$OCCP <= 2060] <- "CMS"
dataAll$OCCP1[dataAll$OCCP >= 2100 & dataAll$OCCP <= 2160] <- "LGL"
dataAll$OCCP1[dataAll$OCCP >= 2200 & dataAll$OCCP <= 2550] <- "EDU"
dataAll$OCCP1[dataAll$OCCP >= 2600 & dataAll$OCCP <= 2920] <- "ENT"
dataAll$OCCP1[dataAll$OCCP >= 3000 & dataAll$OCCP <= 3540] <- "MED"
dataAll$OCCP1[dataAll$OCCP >= 3600 & dataAll$OCCP <= 3655] <- "HLS"
dataAll$OCCP1[dataAll$OCCP >= 3700 & dataAll$OCCP <= 3955] <- "PRT"
dataAll$OCCP1[dataAll$OCCP >= 4000 & dataAll$OCCP <= 4150] <- "EAT"
dataAll$OCCP1[dataAll$OCCP >= 4200 & dataAll$OCCP <= 4250] <- "CLN"
dataAll$OCCP1[dataAll$OCCP >= 4300 & dataAll$OCCP <= 4650] <- "PRS"
dataAll$OCCP1[dataAll$OCCP >= 4700 & dataAll$OCCP <= 4965] <- "SAL"
dataAll$OCCP1[dataAll$OCCP >= 5000 & dataAll$OCCP <= 5940] <- "OFF"
dataAll$OCCP1[dataAll$OCCP >= 6005 & dataAll$OCCP <= 6130] <- "FFF"
dataAll$OCCP1[dataAll$OCCP >= 6200 & dataAll$OCCP <= 6765] <- "CON"
dataAll$OCCP1[dataAll$OCCP >= 6800 & dataAll$OCCP <= 6940] <- "EXT"
dataAll$OCCP1[dataAll$OCCP >= 7000 & dataAll$OCCP <= 7630] <- "RPR"
dataAll$OCCP1[dataAll$OCCP >= 7700 & dataAll$OCCP <= 8965] <- "PRD"
dataAll$OCCP1[dataAll$OCCP >= 9000 & dataAll$OCCP <= 9750] <- "TRN"
dataAll$OCCP1[dataAll$OCCP >= 9800 & dataAll$OCCP <= 9830] <- "MIL"


# preprocess the data
marriedData <- 
  dataAll %>%
  na.omit() %>%
  filter(MAR %in%c("Married","Widowed","Divorced","Separated"))

# get the dataset that includes people who have gotten married
everDivorcedData <- marriedData[(marriedData$MAR != "Divorced" & marriedData$MARHT > 1) | marriedData$MAR == "Divorced"]

##########
# get the proportion of divorced according to different incomes level
dataSalary <- aggregate(marriedData$PWGTP,by=list(marriedData$WAGP2),FUN=sum)
names(dataSalary)<-c('WAGP','PWGTP')
dataSalary

dataDivorcedSalary <- aggregate(everDivorcedData$PWGTP,by=list(everDivorcedData$WAGP2),FUN=sum)
names(dataDivorcedSalary)<-c('WAGP','PWGTP')
dataSalary <- as.vector(dataSalary)
dataDivorcedSalary <- as.vector(dataDivorcedSalary)
dataDivorcedSalary[,2]
dataDivorcedSalary[,2] / dataSalary[,2]

#########
# get the proportion of divorced according to different ANC level
dataANC <- aggregate(marriedData$PWGTP,by = list(marriedData$ANC),FUN = sum)
names(dataANC)<-c('ANC','PWGTP')

dataDivorcedANC <- aggregate(everDivorcedData$PWGTP,by=list(everDivorcedData$ANC),FUN=sum)
names(dataDivorcedANC)<-c('ANC','PWGTP')

dataANC <- as.vector(dataANC)
dataDivorcedANC <- as.vector(dataDivorcedANC)
dataDivorcedANC[,2]
dataDivorcedANC[,2] / dataANC[,2]


### 
## get the proportion of divorced according to different OCCUPATION level
dataOCC <- aggregate(marriedData$PWGTP, by = list(marriedData$OCCP1),FUN = sum)
names(dataOCC) <- c('OCCP','PWGTP')

dataDivorcedOCC <- aggregate(everDivorcedData$PWGTP, by = list(everDivorcedData$OCCP1),FUN = sum)
names(dataDivorcedOCC) <- c('OCCP','PWGTP')

dataOCC <- as.vector(dataOCC)
dataDivorcedOCC <- as.vector(dataDivorcedOCC)
dataDivorcedOCC[,2] / dataOCC[,2]


###plot stat data
marriedData_total <- 
  marriedData %>%
  group_by(ST) %>%
  summarise(PWGTP=sum(PWGTP))

#now divorced and who onced divorced  
marriedData_divorced <-
  marriedData[(marriedData$MAR != "Divorced" & marriedData$MARHT > 1) | (marriedData$MAR == "Divorced"),] %>%
  group_by(ST) %>%
  summarise(PWGTP=sum(PWGTP))

#read statename and use it to deal the original data
statenames <- fread('statename.csv',select = "name")
statenames<-statenames[- grep("puerto rico", statenames$name),]
marriedData_total$ST <- factor(marriedData_total$ST)
marriedData_divorced$ST <- factor(marriedData_divorced$ST)
levels(marriedData_total$ST) <- statenames$name
levels(marriedData_divorced$ST) <- statenames$name
colnames(statenames)<-c('ST')

#calculate the divorced rate by state
marriedData_divorced<-right_join(marriedData_divorced,statenames,by.x=c('ST'))
marriedData_divorced<-mutate(marriedData_divorced,value=round(marriedData_divorced$PWGTP/marriedData_total$PWGTP,2))
marriedData_for_draw<-marriedData_divorced[,c(1,3)]
colnames(marriedData_for_draw)<-c('region','value')

#draw the plot
library(choroplethrMaps)
library(choroplethr)
state_choropleth(marriedData_for_draw,title='Divorce Rate by State',legend='rate',num_colors = 5)
##########################################################################################################






#get the proportion of divorce people
#getProportion <- function(dataSet)
#{
#  return (((sum(dataSet[dataSet$MAR != "Divorced" & dataSet$MARHT > 1]$PWGTP)) + sum(dataSet[dataSet$MAR == "Divorced"]$PWGTP)) / (sum(dataSet$PWGTP)))
#}

#rm(data1, data2)
#save(dataAll, file = "dataAll.RData")
#load("dataAll.RData")
#dataAll$MAR
