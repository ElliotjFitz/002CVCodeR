# mytop10ids.R
# this will help me find the maximum values 
#
# script to read in WBC values and find the maximum
#
# run in R with:
# source("mytop10ids.R")
#
# Author: Elliot J Fitzgerald
# load in the igraph library

for(i in 2:299)
{

mypathtop <- file.path("G:","0.02cv","0.02cv","WNBdata",paste("WNBdata_", i, ".txt", sep = ""))

values <- read.table(mypathtop,header=TRUE)



sortvals <- sort(values[,2], decreasing=TRUE)

cutoff <-floor(0.1*length(sortvals))

nodeids<- which(values[,2] >= sortvals[cutoff])

mypath <- file.path("G:","0.02cv","0.02cv","Top 10",paste("Top10nodedata_", i, ".txt", sep = ""))
write.table(nodeids, file = mypath, sep = "", col.names = NA)
}
