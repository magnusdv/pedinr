#---------------------------------------------
# Dataset for use in *Pedigree analysis in R*.
#---------------------------------------------
#
# Dataset: `mpi-example`
#
# Files generated:
#  * `mpi-example.ped`
#  * `mpi-example.freq`
#
# Contents:
# The ped file describes a pedigree with 6 individuals typed with 20 STR
# markers. The freq file contains allele frequencies for each marker.
#

library(forrel)

set.seed(42)

# Reference pedigree
ref = nuclearPed(3, sex = c(1,2,1))
ref = addChildren(ref, father = 5, ids = "MP", sex = 2, verbose = F)

# Attach 20 markers with Norwegian allele frequencies
loci = NorwegianFrequencies[1:20]
ref = setMarkers(ref, locusAttributes = loci)

# Simulate reference data
ids = 2:4 # ref indivs
ref = profileSim(ref, N = 1, ids = ids, numCores = 1)[[1]]

# POI.1: Unrelated
poi1 = setMarkers(singleton("POI1"), locusAttributes = loci)
poi1 = profileSim(poi1, N = 1, numCores = 1)[[1]]

# POI.2: True MP
poi2 = profileSim(ref, N = 1, ids = "MP", numCores = 1)[[1]]
poi2 = subset(poi2, "MP")
poi2 = relabel(poi2, "POI2")

# Collect pedigrees in list
peds = list(Reference = ref, POI1 = poi1, POI2 = poi2)

# Write ped file
writePed(peds, prefix = "data/mpi-example", what = c("ped", "freq"), header = T)
