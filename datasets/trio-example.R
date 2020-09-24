#---------------------------------------------
# Dataset for use in *Pedigree analysis in R*.
#---------------------------------------------
#
# Dataset: `trio-example`
#
# Files generated:
#  * `trio-example.txt`
#
# Contents:
# This file describes a trio with genotypes for a singe marker. Its purpose is
# to exemplify the ped format used to describe pedigrees in text files.
#

# Data frame in ped format
df = data.frame(ID = c("Fa", "Mo", "Girl"),
                FID = c(0,0,"Fa"),
                MID = c(0,0, "Mo"),
                SEX = c(1,2,2),
                "M.1" = c(0, "a", "c"),
                "M.2" = c(0, "c", "c"), check.names = F)

# Write to file
write.table(df, file = "data/trio-example.txt", quote = F, row.names = F, sep = "\t")
