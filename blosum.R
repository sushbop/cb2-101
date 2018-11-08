# Using `wget` download BLOSUM62 matrix from NCBI FTP server (ftp://ftp.ncbi.nih.gov/blast/matrices/BLOSUM62). Process it in anyway you can and read it in R as a matrix, a dataframe, or a list. You should store the data such a way that you can call the score given two amino acids as key as a fast lookup table. Read the accompanied `ex_align.fas` file and calculate the score of the given alignment. Consider each indel has score 0. The alignment file is in aligned fasta format.

#!/usr/bin/Rscript
# install.packages("seqinr")
library(seqinr)

args <- commandArgs(trailingOnly = T)
blosum <- read.table("~/local_drive/BLOSUM62")
fas_file <- read.fasta(args[1], seqtype = "AA")
#fas_file <- read.fasta("~/local_drive/05-Problemset_2/ex_align.fas", seqtype = "AA")
seq1 <- fas_file[["P1"]]
seq2 <- fas_file[["P2"]]

scores <- c()

for(i in 1:length(seq1)){
  a <- seq1[i]
  b <- seq2[i]
  c <- blosum[a,b]
#  cat(a, b, c, "\n")
  scores <- c(scores, c)
}

d = sum(scores)

cat("similarity score = ", d, "\n")

