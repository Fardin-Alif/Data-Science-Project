# Clustering and Sentiment Analysis of Hotel Reviews Using TF-IDF

## 📌 Project Overview

This project focuses on analyzing customer hotel reviews using Natural Language Processing (NLP) and Unsupervised Machine Learning techniques.

The main goal is to identify patterns in customer feedback and group hotel reviews into three sentiment categories:

- Positive
- Negative
- Neutral

TF-IDF is used to convert text reviews into numerical features, followed by clustering algorithms to discover patterns in customer opinions.

## 🎯 Objectives

- Clean and preprocess customer hotel reviews.
- Extract important words using TF-IDF.
- Identify patterns in customer feedback.
- Apply different clustering algorithms.
- Visualize and compare clustering results.
- Help businesses understand customer satisfaction and improve service quality.

## 🛠️ Technologies Used

- **Programming Language:** R
- **IDE:** RStudio
- **Data Processing:** Text Mining and NLP
- **Feature Extraction:** TF-IDF
- **Dimensionality Reduction:** PCA
- **Visualization:** ggplot2, pheatmap

## 📂 Dataset

The project uses the Hotel Reviews dataset from Kaggle.

Dataset Source: https://www.kaggle.com/datasets/datafiniti/hotelreviews

Important dataset attributes include:
- Hotel Name
- Customer Rating
- Review Text
- Review Title
- Review Date
- Hotel Location

The provided sample CSV contains 100 records and 25 columns.

## ⚙️ Methodology

The project follows these main steps:

1. **Data Collection:** Collect hotel reviews and relevant information.
2. **Data Cleaning:** Remove duplicate records, convert text to lowercase, and clean unnecessary characters.
3. **Text Preprocessing:** Apply lemmatization, spelling correction, emoji handling, and stopword removal.
4. **Feature Extraction:** Convert reviews into numerical vectors using TF-IDF with unigrams and bigrams.
5. **Clustering:** Apply three unsupervised machine learning algorithms.
6. **Dimensionality Reduction:** Use PCA to visualize high-dimensional data in two dimensions.
7. **Result Analysis:** Compare clusters and identify patterns in customer feedback.

## 🤖 Machine Learning Algorithms

Three clustering algorithms were implemented:

**1. K-Means Clustering**
- Divides reviews into three clusters.
- Uses K = 3 to explore positive, negative, and neutral sentiment groups.

**2. Hierarchical Clustering**
- Groups similar reviews using Ward's linkage.
- Uses a dendrogram to examine relationships between reviews.

**3. DBSCAN**
- Groups data based on density.
- Helps identify potential noise and unusual reviews.

## 📊 Results and Findings

- K-Means produced three distinguishable clusters.
- Hierarchical clustering revealed different groups of similar reviews.
- DBSCAN grouped the observations into a single cluster under the selected parameters.
- TF-IDF highlighted important terms related to hotel service, cleanliness, rooms, staff, and customer experience.
- PCA was used to visualize the clustering results.

## 📦 Required R Packages

The project uses the following R packages:

- tm
- SnowballC
- textclean
- textstem
- hunspell
- cluster
- caret
- RWeka
- ggplot2
- stats
- dbscan
- pheatmap

## 🚀 How to Run the Project

1. Install R and RStudio.
2. Download or clone this repository.
3. Install the required R packages.
4. Place the dataset in the project directory.
5. Open the R script in RStudio.
6. Update the dataset file path in the script.
7. Run the script to perform preprocessing, feature extraction, clustering, and visualization.

## 📁 Project Structure

```text
Hotel-Review-Sentiment-Analysis/
│
├── README.md
├── ids_final_project_group_10.R
├── ids_final_dataset_sample_group_10.csv
└── ids_final_project_group_10.pdf
```


## 📚 References

1. Vu, H. Q., Li, G., Law, R., and Zhang, Y. (2018). Exploring Tourist Dining Preferences Based on Restaurant Reviews.
2. Wang, Y., Liu, F., and Li, G. (2024). Clustering Analysis of Hotel Network Reviews Based on Text Mining Method.

---

**Project Domain:** Data Science | Natural Language Processing | Unsupervised Machine Learning

**Institution:** American International University-Bangladesh (AIUB)
