library(dplyr)
library(tibble)
library(reshape2)

label_file <- "/Users/phungduchuy/BIOINFO/Project/CAFA/CAFA3_training_data/uniprot_sprot_exp.txt"
label <- read.delim(label_file,header = FALSE)

names(label) <- c('id','go','namespace')
label_1 <- distinct(label, id,.keep_all = TRUE)
 


label_tf <- dcast(label_1, id ~ go)
label_tf[label_tf == 'C'] <- 1
label_tf[label_tf == 'F'] <- 1
label_tf[label_tf == 'P'] <- 1
label_tf[is.na(label_tf)] <- 0



