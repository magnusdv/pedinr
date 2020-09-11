# Script for generating all datasets
setwd("datasets")

# Remove data folder
unlink("data", recursive = T)
unlink("data.zip")

source("kinship-riddle.R")
source("kinship-riddle-extended.R")
source("mpi-example.R")
source("reconstruct-example.R")
source("reconstruct-trio.R")
source("reconstruct-fathers.R")
source("linkage-example.R")
source("segregation-hsp.R")

# Create zip file
files = list.files("data", full.names = T)
zip(zipfile = "data.zip", files = files)
