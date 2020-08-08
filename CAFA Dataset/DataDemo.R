#install.packages('seqinr')

prepare_data <- function(txt_file,fasta_file){
  library('seqinr')
  # For class
  file_class <- read.delim(txt_file,header = FALSE)
  names(file_class) = c('Accession Number','Go Term','Namespace')
  
  # For sequence
  file_seq <- read.fasta(fasta_file)
  split_file_seq <- data.frame(Fragments = names(file_seq),
                               Seqs = unlist(getSequence(file_seq, as.string = T)))
  names(split_file_seq) <- c('Accession Number','Protein Sequences')
  split_file_seq$'Protein Sequences' <- toupper(split_file_seq$'Protein Sequences')
  
  # Final Table
  final_table <- merge(file_class[,],split_file_seq[,])
  return(final_table)
}

data_final = prepare_data('/Users/phungduchuy/BIOINFO/Project/CAFA/CAFA3_training_data/uniprot_sprot_exp.txt',
                          '/Users/phungduchuy/BIOINFO/Project/CAFA/CAFA3_training_data/uniprot_sprot_exp.fasta')

