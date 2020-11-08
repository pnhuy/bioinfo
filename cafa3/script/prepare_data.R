library(protr)
library(dplyr)
library(tibble)
library(reshape2)

# PREPARE FEATURE TABLE

fasta_file <- "data/CAFA3_training_data/uniprot_sprot_exp.fasta"
fasta <- readFASTA(fasta_file) # Protein Sequences

# Clean data
fasta_1 <- fasta[(sapply(fasta, protcheck))]

# Materials
x1 <- as.data.frame(t(sapply(fasta_1,extractAAC)))
x2 <- as.data.frame(t(sapply(fasta_1,extractDC)))
x3 <- as.data.frame(t(sapply(fasta_1,extractTC))) # Maybe Error: vector memory exhausted (limit reached ?)
x4 <- as.data.frame(t(sapply(fasta_1,extractCTDC)))
x5 <- as.data.frame(t(sapply(fasta_1,extractCTDT)))
x6 <- as.data.frame(t(sapply(fasta_1,extractCTDD)))
x7 <- as.data.frame(t(sapply(fasta_1,extractCTriad)))
feature <- data.frame(x1,x2,x3,x4,x5,x6,x7)
rm(list=c("fasta", "fasta_1", "x1", "x2", "x3", "x4", "x5", "x6", "x7"))
feature[feature == 0] <- NA
feature$id <- rownames(feature)
write.csv(feature, 'feature.csv', row.names=FALSE)


# PREPARE LABEL TABLE
label_file <- "data/CAFA3_training_data/uniprot_sprot_exp.txt"
label <- read.delim(label_file,header = FALSE)
names(label) <- c('id','go','namespace')
label_1 <- distinct(label, id,.keep_all = TRUE)
label <- dcast(label_1, id ~ go)
label[label == 'C'] <- 1
label[label == 'F'] <- 1
label[label == 'P'] <- 1
label[is.na(label)] <- 0
write.csv(label, 'label.csv', row.names=FALSE)

# MERGE DATA
merge_table <- merge(x=feature, y=label, by='id')
write.csv(merge_table, 'final_data.csv', row.names=FALSE)
write.csv(sample_frac(merge_table, size=0.1), 'sample_data.csv', row.names=FALSE)