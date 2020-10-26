library(protr)
library(dplyr)

fasta_file <- "/Users/phungduchuy/BIOINFO/Project/CAFA/CAFA3_training_data/uniprot_sprot_exp.fasta"
label_file <- "/Users/phungduchuy/BIOINFO/Project/CAFA/CAFA3_training_data/uniprot_sprot_exp.txt"

fasta <- readFASTA(fasta_file) # Protein Sequences
label <- read.delim(label_file,header = FALSE)
names(label) <- c('id','go','namespace')

# Clean data
label_1 <- distinct(label, id,.keep_all = TRUE)
fasta_1 <- fasta[(sapply(fasta, protcheck))]

# Extract DC Table
x <- as.data.frame(t(sapply(fasta_1, extractDC)))
name_feature <- (colnames(x))
name_protein <- (rownames(x))
# Extract AAC table 


# Write function
# Clean feature function


# Test
# Don't run
x1 <- t(x['A0A060X6Z0',])
x1[x1 == 0] <- NA
x1 <- na.omit(x1)
length(rownames(x1))
abc <- 'A0A060X6Z0'
abc1 <- paste(rownames(x1), collapse = '')
abc2 <- data.frame(abc,abc1)

x_test <- head(x)
x_test[x_test == 0] <- NA
lst <- c()
lst_1 <- c()
for (j in seq(rownames(x_test))) {
  #pro_name <- c(rownames(x_test)[j])
  lst[[j]] <- rownames(x_test)[j]
  df_test <- t(x_test[rownames(x_test)[j],])
  df_test[df_test == 0] <- NA
  df_test <- na.omit(df_test)
  lst_1[[j]] <- paste(rownames(df_test), collapse = '')
  df <- data.frame(lst,lst_1)
}

# Final
# Run
protein_name = c()
feature_sequences = c()
for (k in seq(rownames(x))) {
  #pro_name <- c(rownames(x_test)[j])
  protein_name[[k]] <- rownames(x)[k]
  df <- t(x[rownames(x)[k],])
  df[df == 0] <- NA
  df <- na.omit(df)
  feature_sequences[[k]] <- paste(rownames(df), collapse = '')
  feature_table <- data.frame(protein_name,feature_sequences)
}


