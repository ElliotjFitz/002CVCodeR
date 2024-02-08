# mytop20.R
# this will help me find the maximum values 
#
# script to read in WBC values and find the maximum
#
# run in R with:
# source("mytop20.R")
#
# Author: Elliot J Fitzgerald
# load in the igraph library



mypathtop <- file.path("G:","sampleScripts","New Folder","wbc data",paste("WBCdata_1",".txt", sep = ""))

values <- read.table(mypathtop,header=TRUE)



sortvals <- sort(values[,2], decreasing=TRUE)

cutoff <-floor(0.2*length(sortvals))
print(sortvals[1:cutoff])