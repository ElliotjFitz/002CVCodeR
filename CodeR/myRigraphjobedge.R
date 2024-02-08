# myRigraphjobedge.R
#
# script to read in contact data and build graph in Rigraph
#
# run in R with:
# source("myRigraphjobedge.R")
#
# Author: David M. Walker 27/11/2014
# Edited: Elliot J Fitzgerald
# load in the igraph library
library(igraph)

source("map.R")
for(i in 2:299){

# load in the textdata.  

weightpath <- file.path("G:","sampleScripts","New Folder","EPLweights",paste("EPLweights", i, ".txt", sep = ""))


psn <- read.table(paste("psn_",i,".txt",sep=""))
cts <- read.table(weightpath)


wts <- cts[,3]

# build the graph from the contacts
g <- graph.edgelist(as.matrix(cts[,1:2]),directed=FALSE)


#write the WEB.txt files
mypath <- file.path("G:","sampleScripts","New Folder","SEBdata",paste("WEBsebdata_", i, ".txt", sep = ""))
write.table(edge.betweenness(g,weights=wts), file = mypath, sep = "", col.names = NA)


# node betweenness
#nb <- betweenness(g,weight=wts)

#' # Betweenness centrality - number of geodesics (shortest paths) going through a vertex or an edge

}



