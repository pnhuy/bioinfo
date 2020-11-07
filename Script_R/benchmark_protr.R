# Load required library
# install.packages("protr")
library(protr)
library(dplyr)
library(randomForest)
library(caret) 
FASTA_FILE <- "/Users/phungduchuy/BIOINFO/Project/CAFA/CAFA3_training_data/uniprot_sprot_exp.fasta"
LABEL_FILE <- "/Users/phungduchuy/BIOINFO/Project/CAFA/CAFA3_training_data/uniprot_sprot_exp.txt"
N_SAMPLE = 500 # Max 66631

# Read FASTA file and label
fasta <- readFASTA(FASTA_FILE)
label <- read.delim(LABEL_FILE,header = FALSE)
names(label) <- c('id','go','namespace')

# Remove duplicated
label_1 <- distinct(label, id,.keep_all = TRUE) #Is this necessary ?

# Length of data
length(fasta) # 66841

# Check the protein sequence and remove the non-standard sequences:
fasta_1 <- fasta[(sapply(fasta, protcheck))]
length(fasta_1) # 66631

# Get features
x <- as.data.frame(t(sapply(fasta_1, extractDC))) # Replace feature function, t : transpose matrix, row: id, columns: based on extraction method
x$id <- rownames(x) #add column ID

# Merge features and labels
fulldf <- merge(x=x, y=label_1, by='id')
fulldf <- head(fulldf, N_SAMPLE)

feature_col <- colnames(fulldf)[2:21]
target_col <- c("go")

feature <- fulldf[feature_col]
target <- fulldf[target_col]


# Train/Test split
set.seed(1001)
tr.idx <- c(
  sample(1:nrow(fulldf), round(nrow(fulldf) * 0.75))
)
te.idx <- setdiff(1:nrow(fulldf), tr.idx)

x.tr <- feature[tr.idx,]
x.te <- feature[te.idx,]
y.tr <- droplevels(target$go[tr.idx])
y.te <- droplevels(target$go[te.idx])


# Random Forest
rf.fit <- randomForest(x.tr, y.tr, cv.fold = 5)
y.pred <- predict(rf.fit, newdata = x.te)

# y.pred <- factor(y.pred, levels = levels(target))
y.te <- factor(y.te, levels = levels(y.pred))

results <- table(y.pred, y.te)
cm <- confusionMatrix(results)
print(cm$overall)

