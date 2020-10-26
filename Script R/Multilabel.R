# Package : mldr, utiml

library(utiml)
library(mldr)

#file = '/Users/phungduchuy/Flag-dataset-classification-R/dataset/flag.data'
#data = mldr(file)

data1 <- toyml
data2 <- foodtruck


mytoy <- normalize_mldata(data1) # standard normalized

# Split train & test
ds <- create_holdout_partition(mytoy, c(train = 0.7, test = 0.3), 'iterative')
#names(ds) 


# With random forest method
brmodel <- br(ds$train, 'RF', seed = 123)
prediction <- predict(brmodel, ds$test)

# Result
head(as.bipartition(prediction))
head(as.probability(prediction))

# Change threshold
newpred <- rcut_threshold(prediction,3)
head(newpred)

result <- multilabel_evaluate(ds$tes, prediction, "bipartition")
thresres <- multilabel_evaluate(ds$tes, newpred, "bipartition")

round(cbind(Default=result, RCUT=thresres), 3)

result <- multilabel_evaluate(ds$tes, prediction, "bipartition", labels=TRUE)
result$labels

#Pre processing

mdata <- fill_sparse_mldata(toyml) # Fill sparse data
mdata <- remove_unique_attributes(toyml) # Remove unique attributes
mdata <- remove_attributes(toyml, c("iatt8", "iatt9", "ratt10")) # Remove the attributes "iatt8", "iatt9" and "ratt10"
mdata <- remove_skewness_labels(toyml, 10) # Remove labels with less than 10 positive or negative examples
mdata <- remove_labels(toyml, c("y2", "y3")) # Remove the labels "y2" and "y3"
mdata <- remove_unlabeled_instances(toyml) # Remove the examples without any labels
mdata <- replace_nominal_attributes(toyml) # Replace nominal attributes
mdata <- normalize_mldata(mdata) # Normalize the predictive attributes between 0 and 1



# Sampling
# Create a subset of toyml dataset with the even instances and the first five attributes
mdata <- create_subset(toyml, seq(1, 100, 2), 1:5)

# Create a subset of toyml dataset with the ten first instances and all attributes
mdata <- create_subset(toyml, 1:10)

# Create a random subset of toyml dataset with 30 instances and 6 attributes
mdata <- create_random_subset(toyml, 30, 6)

# Create a random subset of toyml dataset with 7 instances and all attributes
mdata <- create_random_subset(toyml, 7)

# Holdout
# Create two equal partitions using the 'iterative' method
toy <- create_holdout_partition(toyml, c(train=0.5, test=0.5), "iterative")
## toy$train and toy$test is a mldr object

# Create three partitions using the 'random' method
toy <- create_holdout_partition(toyml, c(a=0.4, b=0.3, c=0.3))
## Use toy$a, toy$b and toy$c

# Create two partitions using the 'stratified' method
toy <- create_holdout_partition(toyml, c(0.6, 0.4), "stratified")
## Use toy[[1]] and toy[[2]] 

# Kfold
results <- cv(foodtruck, br, base.algorith="SVM", cv.folds=5, 
              cv.sampling="stratified", cv.measures="example-based", 
              cv.seed=123)

round(results, 4)


results <- cv(toyml, "rakel", base.algorith="RF", cv.folds=10, cv.results=TRUE,
              cv.sampling="random", cv.measures="example-based")

#Multi-label results
round(results$multilabel, 4)


#Labels results
round(sapply(results$labels, colMeans), 4)


# Create 3-fold object
kfcv <- create_kfold_partition(toyml, k=3, "iterative")
result <- lapply(1:3, function (k) {
  toy <- partition_fold(kfcv, k)
  model <- br(toy$train, "RF")
  predict(model, toy$test)
})

# Create 5-fold object and use a validation set
kfcv <- create_kfold_partition(toyml, 5, "stratified")
result <- lapply(1:5, function (k) {
  toy <- partition_fold(kfcv, k, has.validation=TRUE)
  model <- br(toy$train, "RF")
  
  list(
    validation = predict(model, toy$validation),
    test = predict(model, toy$test)
  )
})



#Classifier chain with a specific chain
ccmodel <- cc(toyml, "RF", chain = c("y5", "y4", "y3", "y2", "y1"))

# Ensemble with 5 models using 60% of sampling and 75% of attributes
ebrmodel <- ebr(toyml, "C5.0", m = 5, subsample=0.6, attr = 0.75)

# Specific parameters for SVM
brmodel <- br(toyml, "SVM", gamma = 0.1, scale=FALSE)

# Specific parameters for KNN
ccmodel <- cc(toyml, "KNN", c("y5", "y4", "y3", "y2", "y1"), k=5)

# Specific parameters for Random Forest
ebrmodel <- ebr(toyml, "RF", 5, 0.6, 0.75, proximity=TRUE, ntree=100)


model <- mlknn(toyml, k=3)
pred <- predict(model, toyml)

# Running Binary Relevance method using 4 cores
brmodel <- br(toyml, "SVM", cores=4)
prediction <- predict(brmodel, toyml, cores=4)

# Running Binary Relevance method using 4 cores
brmodel <- br(toyml, "SVM", cores=4, seed=1984)
prediction <- predict(brmodel, toyml, seed=1984, cores=4)


results <- cv(toyml, method="ecc", base.algorith="RF", subsample = 0.9, attr.space = 0.9, cv.folds=5, cv.cores=4)




# Use a fixed threshold for all labels 
newpred <- fixed_threshold(prediction, 0.4)

# Use a specific threshold for each label 
newpred <- fixed_threshold(prediction, c(0.4, 0.5, 0.6, 0.7, 0.8))

# Use the MCut approch to define the threshold
newpred <- mcut_threshold(prediction)

# Use the PCut threshold
newpred <- pcut_threshold(prediction, ratio=0.65)

# Use the RCut threshold
newpred <- rcut_threshold(prediction, k=3)

# Choose the best threshold values based on a Mean Squared Error 
thresholds <- scut_threshold(prediction, toyml, cores = 5)
newpred <- fixed_threshold(prediction, thresholds)

#Predict only the labelsets present in the train data
newpred <- subset_correction(prediction, toyml)


toy <- create_holdout_partition(toyml)
brmodel <- br(toy$train, "SVM")
prediction <- predict(brmodel, toy$test)

# Using the test dataset and the prediction
result <- multilabel_evaluate(toy$test, prediction)
print(round(result, 3))


# Build a confusion matrix
confmat <- multilabel_confusion_matrix(toy$test, prediction)
result <- multilabel_evaluate(confmat)
print(confmat)



kfcv <- create_kfold_partition(toyml, k=3)
confmats <- lapply(1:3, function (k) {
  toy <- partition_fold(kfcv, k)
  model <- br(toy$train, "RF")
  multilabel_confusion_matrix(toy$test, predict(model, toy$test))
})
result <- multilabel_evaluate(merge_mlconfmat(confmats))


# Example-based measures
result <- multilabel_evaluate(confmat, "example-based")
print(names(result))

# Subset accuracy, F1 measure and hamming-loss
result <- multilabel_evaluate(confmat, c("subset-accuracy", "F1", "hamming-loss"))
print(names(result))


# Ranking and label-basedd measures
result <- multilabel_evaluate(confmat, c("label-based", "ranking"))
print(names(result))


# To see all the supported measures you can try
multilabel_measures()
