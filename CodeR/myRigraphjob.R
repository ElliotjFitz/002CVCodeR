# myRigraphjob.R
#
# script to read in contact data and build graph in Rigraph
#
# run in R with:
# source("myRigraphjob.R")
#
# Author: David M. Walker 27/11/2014
# Edited: Elliot J Fitzgerald
# load in the igraph library
library(igraph)

source("map.R")
for(i in 2:299){

# load in the textdata.  

weightpath <- file.path("G:","0.02cv","0.02cv","EPL weights",paste("EPLweightsCV", i, ".txt", sep = ""))
psnpath <- file.path("G:","0.02cv","0.02cv","psn",paste("psn_", i, ".txt", sep = ""))


psn <- read.table(psnpath)
cts <- read.table(weightpath)


wts <- cts[,3]

# build the graph from the contacts
g <- graph.edgelist(as.matrix(cts[,1:2]),directed=FALSE)


#write the WBC.txt files
mypath <- file.path("G:","0.02cv","0.02cv","WNBdata",paste("WNBdata_", i, ".txt", sep = ""))
write.table(betweenness(g,weights=wts), file = mypath, sep = "", col.names = NA)


#' # Betweenness centrality - number of geodesics (shortest paths) going through a vertex or an edge
}



