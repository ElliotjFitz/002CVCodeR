# myRigraphjob.R
#
# script to read in contact data and build graph in Rigraph
#
# run in R with:
# source("02dilflowbet.R")
#
# Author: David M. Walker 27/11/2014
# Edited: Elliot J Fitzgerald
# load in the igraph library
#library(igraph)
#library(statnet)

source("map.R")
for(i in 75:110){

weightpath <- file.path("G:","sampleScripts","New Folder","EPLweights",paste("EPLweights", i, ".txt", sep = ""))


psn <- read.table(paste("psn_",i,".txt",sep=""))
cts <- read.table(weightpath)

# we will build a weighted network, with weights being magnitude of contact force
#wts <- sqrt(cts[,3]^2 + cts[,4]^2)

wts <- cts[,3]

# build the graph from the contacts
g <- graph.edgelist(as.matrix(cts[,1:2]),directed=FALSE)
E(g)$weight <- wts


adj<- graph.adjacency(g)
mypath <- file.path("G:","flowbet",paste("flowbetdata_", i, ".txt", sep = ""))
write.table(flowbet(adj), file = mypath, sep = "", col.names = NA)



}


