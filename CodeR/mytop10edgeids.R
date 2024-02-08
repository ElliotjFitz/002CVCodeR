# mytop10ids.R
# this will help me find the maximum values 
#
# script to read in WBC values and find the maximum
#
# run in R with:
# source("mytop10edgeids.R")
#
# Author: Elliot J Fitzgerald
# load in the igraph library

for(i in 2:299)
{

mypathtop <- file.path("G:","sampleScripts","New Folder","SEBdata",paste("WEBsebdata_", i,".txt", sep = ""))

values <- read.table(mypathtop,header=TRUE)



sortvals <- sort(values[,2], decreasing=TRUE)

cutoff <-floor(0.1*length(sortvals))

edgeids<- which(values[,2] >= sortvals[cutoff])

mypath <- file.path("G:","sampleScripts","New Folder","Top20edges",paste("Top10edgedata_", i, ".txt", sep = ""))
write.table(edgeids, file = mypath, sep = "", col.names = NA)
}
