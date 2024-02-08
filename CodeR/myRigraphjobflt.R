# myRigraphjob.R
#
# script to read in contact data and build graph in Rigraph
#
# run in R with:
# source("myRigraphjobflt.R")
#
# Author: David M. Walker 27/11/2014
# Edited: Elliot J Fitzgerald
# load in the igraph library
library(igraph)

source("map.R")
for(i in 2:299){

# load in the textdata.  
#psn <- read.table("psn_143.txt")
#cts <- read.table("p02wts143")

weightpath <- file.path("G:","sampleScripts","New Folder","EPLweights","filteredwts",paste("02Dilfilteredwts", i, sep = ""))


psn <- read.table(paste("psn_",i,".txt",sep=""))
cts <- read.table(weightpath)

# we will build a weighted network, with weights being magnitude of contact force
#wts <- sqrt(cts[,3]^2 + cts[,4]^2)

wts <- cts[,3]

# build the graph from the contacts
g <- graph.edgelist(as.matrix(cts[,1:2]),directed=FALSE)


#write the WBC.txt files
mypath <- file.path("G:","sampleScripts","New Folder","filtered",paste("WNBfltdata_", i, ".txt", sep = ""))
write.table(betweenness(g,weights=wts), file = mypath, sep = "", col.names = NA)
}


