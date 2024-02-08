# myMaxfinder.R
# this will help me find the maximum values 
#
# script to read in WBC values and find the maximum
#
# run in R with:
# source("myMaxfinder.R")
#
# Author: Elliot J Fitzgerald
# load in the igraph library

maxvals <- 1:298;

for(i in 1:298){

mypathmax <- file.path("D:","sampleScripts","New Folder","wbc data",paste("WBCdata_",i,".txt", sep = ""))


WBCtmp <- read.table(mypathmax,header=TRUE)

maxvals[i] <- max(WBCtmp, na.rm=TRUE)
}

print(max(maxvals,na.rm=TRUE))