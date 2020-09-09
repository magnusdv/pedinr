#---------------------------------------------
# Dataset for use in *Pedigree analysis in R*.
#---------------------------------------------
#
# Dataset: `reconstruct-example`
#
# Files generated:
#  * `reconstruct-example.ped`
#
# Contents: Genotypes for 4 individuals typed with 500 equifrequent SNPs.
#
library(forrel)

# Create pedigree
x = addDaughter(nuclearPed(2), 4)

# Simulate 500 SNPs
x = markerSim(x, 500, seed = 1729)

# Extract data for 4 members
df = as.data.frame(x)[c(2,3,6,4), , drop = F]

# Mask pedigree info
df$id = 1:4
df$fid = df$mid = 0

# Write to file
write.table(df, file = "data/reconstruct-example.ped", quote = F, row.names = F)

