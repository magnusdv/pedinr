#---------------------------------------------
# Dataset for use in *Pedigree analysis in R*.
#---------------------------------------------
#
# Dataset: `riddle-pairwise`
#
# Files generated:
#  * `riddle-pairwise.ped`
#
# Contents:
# This dataset contains genotypes for two males, S1 and S2. The ped file is
# stripped for pedigree information, but as the code shows, they are actually
# half brothers. However, the random generator seed was chosen (by trial and
# error to make inference difficult.
#
# The markers used are the 15 first markers of the database
# `NorwegianFrequencies`, available in **forrel**.
#

library(forrel)

# Pedigree
ids = c("S1", "S2")
hs = ped(id = c(1:3, ids), fid = c(0,0,0,1,1),
         mid = c(0,0,0,2,3), sex = c(1,2,2,1,1))

# Attach 15 empty markers with Norwegian frequencies
hs = setMarkers(hs, locusAttributes = NorwegianFrequencies[1:15])

# Simulate one profile
hs = profileSim(hs, N = 1, ids = ids, seed = 42, numCores = 1)[[1]]

# Extract as singletons (i.e., remove pedigree info)
x = list(subset(hs, "S1"), subset(hs, "S2"))

# Write ped file
writePed(x, prefix = "data/riddle-pairwise", header = T)
