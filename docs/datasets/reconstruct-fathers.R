#
# This file generates the dataset `reconstruct-fathers`
# used in the book *Pedigree analysis in R*.
#
# Files:
#  * `reconstruct-fathers.ped`
#  * `reconstruct-fathers.freq`
#
# Contents: The files contains STR data for two sisters and their (in total)
# three children.
#
library(forrel)

# Pedigree
x = nuclearPed(2, sex = 2)
x = addChildren(x, father = 5, mother = 3, nch = 2)
x = addChildren(x, father = 5, mother = 4, nch = 1)
x = relabel(x, new = c(6,7,2,1,8,4,5,3))
plot(x)

# Set frequencies
db = readRDS(url("https://familias.name/norbisRelatedness/AustraliaFreqs.rds"))
db = lapply(db, function(a) a[c("alleles", "afreq", "name")])
x = setMarkers(x, locusAttributes = db)

# Simulate 1 profile
s = profileSim(x, N = 1, ids = 1:5, seed = 100, numCores = 1)[[1]]

# Extract 1-5 without ped info
df = as.data.frame(s)[internalID(s, 1:5), ]
df$fid = df$mid = 0
df = cbind(famid = 1:5, df)

# Write ped & freq files
write.table(df, "data/reconstruct-fathers.ped", quote = F, row.names = F)
writeFreqDatabase(s, "data/reconstruct-fathers.freq")

