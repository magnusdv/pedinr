#---------------------------------------------
# Dataset for use in *Pedigree analysis in R*.
#---------------------------------------------
#
# Dataset: `linkage-example`
#
# Files generated:
#  * `linkage-example.ped`
#  * `linkage-example.map`
#
# Contents: The ped file describes a pedigree with 19 individuals, and
# genotype data for 14 members typed with 248 SNPs on chromosome 1.
# The marker positions are given in the map file.
#
library(ibdsim2)

# Pedigree
x = nuclearPed(4, sex = c(2,1,2,1))
x = addChildren(x, mother=3, nch = 3, sex = c(1,2,1))
x = addDaughter(x, 5)
x = addChildren(x, 6, nch = 1, sex = 1)
x = addChildren(x, 6, nch = 2, sex = c(2,2,2))
x = addSon(x, 10)
x = relabel(x, "asPlot")

# True carrier status
carr = c(2,4,9,12,13,16,18,19)
plot(x, shaded = carr)

# Simulate IBD pattern on Chr 1
chr1 = loadMap(chrom = 1)[[1]]
seed = 22341  # found by trial and error
s = ibdsim(x, map = chr1, verbose = F, seed = seed)[[1]]

# Check match with disease pattern
pattern = list(carriers = carr, noncarriers = (1:19)[-carr])
findPattern(s, pattern)

# Attach SNP markers every 1 Mb on chromosome 1
x = setMarkers(x, lapply(1:248, function(i)
  marker(x, chrom = 1, posMb = i, name = paste0("m", i))))

# Simulate genotypes onto the pattern
y = profileSimIBD(x, s, ids = c(1,3,5,6,9,11:19), seed = 1234)

# Introduce a couple of errors
genotype(y, id = 11, marker = 131) = c(2,2)
genotype(y, id = 5, marker = 167) = c(2,2)
mendelianCheck(y)

# Genetic map
female  = convertPos(Mb = 1:248, map = chr1$female)
male    = convertPos(Mb = 1:248, map = chr1$male)
average = (female + male)/2
map = data.frame(chrom = 1, marker = paste0("m", 1:248), mb = 1:248,
                 cm = average, female = female, male = male)

# Save to files
writePed(y, what = "ped", prefix = "data/linkage-example")
write.table(map, file = "data/linkage-example.map", quote = F,
            row.names = F)

