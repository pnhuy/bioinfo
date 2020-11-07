library(protr)
library(dplyr)
library(tibble)

fasta_file <- "/Users/phungduchuy/BIOINFO/Project/CAFA/CAFA3_training_data/uniprot_sprot_exp.fasta"


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
t <- data.frame(x1,x2,x3,x4,x5,x6,x7)


feature_list <- c(x1,x2,x3,x4,x5,x6,x7) # Temporarily removed x3 variable
name_feature <- colnames(t)
name_protein <- rownames(t)



# Run
t[t == 0] <- NA
protein_name = c()
feature_sequences = c()
for (k in seq(rownames(t))) {
  #pro_name <- c(rownames(x_test)[j])
  protein_name[[k]] <- rownames(t)[k]
  df <- t(t[rownames(t)[k],])
  df[df == 0] <- NA
  df <- na.omit(df)
  feature_sequences[[k]] <- paste(rownames(df), collapse = '')
  feature_table <- data.frame(protein_name,feature_sequences)
}


