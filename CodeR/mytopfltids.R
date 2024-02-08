# mytopfltids.R
# this will help me find the maximum values 
#
# script to read in WBC values and find the maximum
#
# run in R with:
# source("mytopfltids.R")
#
# Author: Elliot J Fitzgerald
# load in the igraph library

for(i in 2:299)
{

mypathtop <- file.path("G:","sampleScripts","New Folder","filtered","fltWNBdata",paste("WNBfltdata_", i,".txt", sep = ""))

values <- read.table(mypathtop,header=TRUE)



sortvals <- sort(values[,2], decreasing=TRUE)

cutoff <-floor(0.1*length(sortvals))

nodeids<- which(values[,2] >= sortvals[cutoff])

mypath <- file.path("G:","sampleScripts","New Folder","filtered","filtered top",paste("Top10fltnodedata_", i, ".csv", sep = ""))
#write.table(nodeids, file = mypath, sep = "", col.names = NA)
write.csv(nodeids, file = mypath)
}
