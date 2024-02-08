# myRigraph.R
#
# script to read in contact data and build graph in Rigraph
#
# run in R with:
# source("myRigraph.R")
#
# Author: David M. Walker 27/11/2014
# Edited: Elliot J Fitzgerald
# load in the igraph library
library(igraph)

source("map.R")

# load in the textdata.  Stage 112 info previously save as text file from matlab 
#psn <- read.table("p02psn112.txt");
#cts <- read.table("p02cts112.txt");

weightpath <- file.path("G:","sampleScripts","New Folder","EPLweights",paste("EPLweights", 2, ".txt", sep = ""))



psn <- read.table("psn_2.txt")
cts <- read.table(weightpath)

# we will build a weighted network, with weights being magnitude of contact force
#wts <- sqrt(cts[,3]^2 + cts[,4]^2)

wts <- cts[,3]

# build the graph from the contacts
g <- graph.edgelist(as.matrix(cts[,1:2]),directed=FALSE)

# plot the network
dev.new();
#plot(g,layout=as.matrix(psn[,1:2]),vertex.size=0.01,vertex.label=NA,edge.width=map(wts/mean(wts),c(1,7)),edge.color="steelblue")

# calculate weighted netork edge betweenness
#ebw <- edge.betweenness(g,weights=wts)


# node betweenness
#nb <- betweenness(g,weight=wts)

#' # Betweenness centrality - number of geodesics (shortest paths) going through a vertex or an edge

plot(g, layout=as.matrix(psn[,1:2]),
vertex.size=map(betweenness(g,weights=wts),c(1,15)),
edge.width=map(edge.betweenness(g,weights=wts), c(1,10)),vertex.label=NA)


# plot the network using betweenness values
#w <- nb #(ebw+1)/(mean(ebw+1)) # translate to avoid zero weights
#dev.new();
#plot(g,layout=as.matrix(psn[,1:2]),vertex.size=5,vertex.label=NA,vertex.color=w;

#plot(g,layout=as.matrix(psn[,2:3]),vertex.size=0.01,vertex.label=NA,edge.color="magenta",edge.width=w);

# write.table(betweenness(g,weights=wts), file = "btwnessP01.csv", sep = ",", col.names = NA)
