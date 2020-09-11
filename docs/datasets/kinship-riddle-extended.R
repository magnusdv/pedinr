#---------------------------------------------
# Dataset for use in *Pedigree analysis in R*.
#---------------------------------------------
#
# Dataset: `kinship-riddle-extended`
#
# Files generated:
#  * `kinship-riddle-extended.ped`
#
# Contents:
# This dataset extends the `kinship-riddle` dataset by adding three female
# relatives. The genotypes of the three new individuals are simulated
# conditional on the original pairwise data.
#
library(forrel)
seed = 42

### Step 1: Create `hs` as in `kinship-riddle.R`

# Pedigree
ids = c("S1", "S2")
hs = ped(id = c(1:3, ids), fid = c(0,0,0,1,1),
         mid = c(0,0,0,2,3), sex = c(1,2,2,1,1))

# Attach 15 empty markers with Norwegian frequencies
hs = setMarkers(hs, locusAttributes = NorwegianFrequencies[1:15])

# Simulate one profile
hs = profileSim(hs, N = 1, ids = ids, seed = seed, numCores = 1)[[1]]

### Step 2: Extend

# Add female relatives S3,S4,S5
x = relabel(hs, old = "2", new = "S3")
x = addChildren(x, fa = 1, mo = 3, nch = 2, sex = 2, id = c("S4", "S5"))
plot(x)

# Simulate S3,S4,S5 conditional on S1 and S2
x = profileSim(x, N = 1, ids = c("S3", "S4", "S5"), seed = seed, numCores = 1)[[1]]

### Step 3: Remove pedigree info and save to file

# Extract as singletons
y = lapply(paste0("S", 1:5), function(s) subset(x, s))

# Write ped file
writePed(y, prefix = "data/kinship-riddle-extended", header = T)

