#---------------------------------------------
# Dataset for use in *Pedigree analysis in R*.
#---------------------------------------------
#
# Dataset: `segregation-hsp`
#
# Files generated:
#  * `segregation-hsp.ped`
#
# Contents:
# The ped file describes a family with This dataset contains genotypes for two males, S1 and S2. The ped file is
# stripped for pedigree information, but as the code shows, they are actually
# half brothers. However, the random generator seed was chosen (by trial and
# error to make inference difficult.
#
# The markers used are the 15 first markers of the database
# `NorwegianFrequencies`, available in **forrel**.
#
library(pedtools)

x = nuclearPed(6, sex = c(2, 2, 2, 1, 1, 2))
x = addChildren(addChildren(x, mo = 3, nch = 2, sex = 1:0), fa = 10, nch = 2, sex = 1:0)
x = addChildren(x, mo = 4, nch = 2, sex = 0)
x = addChildren(addChildren(x, mo = 5, nch = 1), fa = 19, nch = 2, sex = c(0,2))
x = addChildren(addChildren(x, f = 7, nch = 2, sex = 1:0), fa = 24, nch = 2, sex = 0)
x = relabel(x, "asPlot")
# plot(x)

# Write ped file
writePed(x, prefix = "data/segregation-hsp", header = T)

