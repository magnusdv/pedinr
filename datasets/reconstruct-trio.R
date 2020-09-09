#---------------------------------------------
# Dataset for use in *Pedigree analysis in R*.
#---------------------------------------------
#
# Dataset: `reconstruct-trio`
#
# Files generated:
#  * `reconstruct-trio.ped`
#
# Contents: Genotypes for three individuals typed with 400 SNPs.
#
library(forrel)

# Pedigree
x = linearPed(2, sex = 2:1)
plot(x)

# Simulate
x = markerSim(x, N = 400, seed = 1729)

# Extract grandpa-mother-son and remove ped info
df = as.data.frame(x)[c(4,5,1), ]
df$id = 1:3; df$fid = df$mid = 0
df = cbind(famid = 1:3, df)

# Write ped file
write.table(df, "data/reconstruct-trio.ped", quote = F, row.names = F)

