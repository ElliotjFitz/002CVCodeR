# RwithMatlabFile.R
#
# use igraph with a pre-built adjacency matrix constructed in matlab
#
# execute in R using: source("RwithMatlabFile.R")
#
# Author: David M. Walker 27/11/2014

# load in the libraries needed to read in mat files and use igraph
library(R.matlab)
library(igraph)

# read in the adjacency matrix, saved as p02X.mat
# p02X.mat is initial contact network of the 0.02 DIL system
A <- readMat("p02X.mat")
# convert this to the igraph adjacency matrix format
G <- graph.adjacency(A$X,"undirected")

# calculate some network properties
# nearest neighbour degree
nn <- graph.knn(G)

# google page rank
pr <- page.rank(G)

# save output data to a mat file for processing in matlab
# writeMat("p02initialStats.mat",nn=nn,pr=pr)

