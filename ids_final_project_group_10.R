library(tm)
library(SnowballC)
library(textclean)   
library(textstem)  
library(hunspell) 
library(cluster)
library(caret)      
library(RWeka)      
library(ggplot2)
library(stats)
library(dbscan)


df <- read.csv("E:\\AIUB\\Summer 2024-2025\\Data Science\\Final Term\\Project\\Datafiniti_Hotel_Reviews.csv", stringsAsFactors = FALSE)


df <- df[!duplicated(df$reviews.text), ]


clean_text <- function(x) {
  x <- tolower(x)                          
  x <- replace_contraction(x)             
  x <- gsub("[^a-z\\s]", " ", x)            
  x <- stripWhitespace(x)                  
  return(x)
}
df$clean <- sapply(df$reviews.text, clean_text)



df$lemmatized <- lemmatize_strings(df$clean)
df$lemmatized <- replace_emoji(df$lemmatized)


df$lemmatized <- sapply(df$lemmatized, function(x) {
  words <- unlist(strsplit(x, " "))
  checked <- sapply(words, function(w) {
    if (!hunspell_check(w)) {
      suggestions <- hunspell_suggest(w)[[1]]
      if (length(suggestions) > 0) return(suggestions[1]) else return(w)
    } else {
      return(w)
    }
  })
  paste(checked, collapse = " ")
})


sw <- stopwords("english")
keep_words <- c("no", "not", "nor", "never", "none", "without", "nothing", "neither", "yes")
custom_sw <- setdiff(sw, keep_words)

remove_stopwords <- function(text) {
  words <- unlist(strsplit(text, " "))
  words <- words[!words %in% custom_sw]
  paste(words, collapse = " ")
}
df$final_text <- sapply(df$lemmatized, remove_stopwords)


BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 2))
dtm <- DocumentTermMatrix(
  VCorpus(VectorSource(df$final_text)),
  control = list(weighting = weightTfIdf,
                 tokenize = BigramTokenizer,
                 bounds = list(global = c(5, Inf)))
)
tfidf_matrix <- as.matrix(dtm)
scaled_tfidf <- scale(tfidf_matrix)


final_df <- df[, c("name", "reviews.rating", "final_text")]
write.csv(final_df, "E:\\AIUB\\Summer 2024-2025\\Data Science\\Final Term\\Project\\processed_reviews.csv", row.names = FALSE)


word_importance <- colSums(as.matrix(dtm))
important_words <- sort(word_importance, decreasing = TRUE)
head(important_words, 20)





set.seed(123)
k <- 3
kmeans_result <- kmeans(scaled_tfidf, centers = k, nstart = 25)
final_df$kmeans_cluster <- kmeans_result$cluster

pca <- prcomp(scaled_tfidf, center = TRUE, scale. = TRUE)
pca_df <- data.frame(pca$x[, 1:2], Cluster = factor(final_df$kmeans_cluster))

ggplot(pca_df, aes(x = PC1, y = PC2, color = Cluster)) +
  geom_point(alpha = 0.6, size = 3) +
  labs(title = "K-Means Clustering Visualization (PCA)") +
  theme_minimal()





dist_matrix <- dist(scaled_tfidf, method = "euclidean")
hc <- hclust(dist_matrix, method = "ward.D2")
final_df$hclust_cluster <- cutree(hc, k = 3)

library(pheatmap)
pheatmap(scaled_tfidf[1:50, 1:50],
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         show_rownames = FALSE,
         show_colnames = FALSE,
         main = "Hierarchical Clustering Heatmap")

pca <- prcomp(scaled_tfidf)
pca_df <- data.frame(
  PC1 = pca$x[,1],
  PC2 = pca$x[,2]
)
pca_df$HCluster <- factor(final_df$hclust_cluster)

library(ggplot2)
ggplot(pca_df, aes(x = PC1, y = PC2, color = HCluster)) +
  geom_point(alpha = 0.6, size = 3) +
  labs(title = "Hierarchical Clustering Visualization (PCA)") +
  theme_minimal()





kNNdistplot(scaled_tfidf, k = 4) 
abline(h = 1.5, col = "red", lty = 2)
set.seed(123)
db <- dbscan(scaled_tfidf, eps = 1.5, minPts = 4)  

final_df$dbscan_cluster <- db$cluster
pca <- prcomp(scaled_tfidf)
pca_df <- data.frame(
  PC1 = pca$x[,1],
  PC2 = pca$x[,2],
  DBSCAN = factor(db$cluster)
)

ggplot(pca_df, aes(x = PC1, y = PC2, color = DBSCAN)) +
  geom_point(size = 2) +
  labs(title = "DBSCAN Clustering of Hotel Reviews (PCA Projection)",
       color = "Cluster") +
  theme_minimal()


