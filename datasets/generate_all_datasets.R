# Script for generating all datasets
setwd("datasets")

source("riddle-pairwise.R")
source("riddle-extended.R")
source("mpi-example.R")
source("reconstruct-example.R")
source("reconstruct-trio.R")
source("reconstruct-fathers.R")
source("linkage-example.R")

# Create zip file
files = list.files("data", full.names = T)
zip(zipfile = "data.zip", files = files)
