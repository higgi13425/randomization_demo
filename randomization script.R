# Randomization Demo with Blockrand

library(blockrand)
library(tidyverse)

# randomize to two treatments and two strata
# start with the first stratum (non-cirrhotic)
nc <- blockrand(n = 80, 
                  num.levels = 2, # three treatments
                  levels = c("Stretching", "Control"), # arm names
                  stratum = "Non-Cirrhotic", # stratum name
                  id.prefix = "NC.", # stratum abbrev
                  block.sizes = c(1,2, 4), # times arms = 3,6,9
                  block.prefix = "NC_block.") # stratum abbrev
nc

# continue with the second stratum (cirrhotic)
c <- blockrand(n = 80, 
                num.levels = 2, # three treatments
                levels = c("Stretching", "Control"), # arm names
                stratum = "Cirrhotic", # stratum name
                id.prefix = "C.", # stratum abbrev
                block.sizes = c(1,2, 4), # times arms = 3,6,9
                block.prefix = "C_block.") # stratum abbrev
c

stretching_study <- bind_rows(nc, c) # bind together the strata into one dataframe

blockrand::plotblockrand(stretching_study, # input dataframe
                         file = "stretching_study.pdf", # output pdf
                         # top hidden text with assignment
      top=list(text=c('ET Stretching Study','Patient: %ID%','Treatment: %TREAT%'),
      col=c('black','black','red'),font=c(1,1,4)),
      # middle text to show through window of # 10 envelope 
  middle=list(text=c("ET Stretching Study","Stratum: %STRAT%","Patient: %ID%"),
      col=c('black','blue','black'),font=c(1,2,3)),
     # bottom text- any instructions to study coordinator
      bottom="Email Dr. Elliot Tapper to report patient entry",
      cut.marks=TRUE) # add cut marks - 4 per page