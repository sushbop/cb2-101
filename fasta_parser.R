#!/usr/bin/Rscript

# this will return all the arguments that have been based to the system, take the command line and pass through args
# trailingOnly = T will avoid the program name
args <- commandArgs(trailingOnly = T)
# take the filename from the terminal gitopt standard library in linux, have packages like it in R as well, insteads of hardcoding the filename
id <- read.table(args[1])[,1]
filename <- args[2]
# don't need to uncompress it to read it
fas_file <- file(filename, "r")

# pass ids into vector

# extract all the sequence IDs from the swiss prot file ("uniprot_sprot.fasta.gz")
# read the file line by line so that the computer is not a bottleneck, trying to read the whole file in with read.table() will take a long time

# an elastic match, need to terminate on some condition
pattern <- "^\\>sp\\|(\\S+)\\|" 

# to get the fasta sequence for only those where the ID is matched, we're building a "look ahead" parser
#id <- "Q6GZX3"
inside <- FALSE
buff <- c("")

# print the IDS and the description 
while(length(line <- readLines(fas_file, n=1)) >0) {
  m <- regexec(pattern, line, perl=T)
  if(m[[1]][1] != -1) { # ID line
    s <- regmatches(line, m)
    if(s[[1]][2] %in% id) { #if sequence matches ID of choice
      inside <- TRUE  # switch on flag
      buff <- c(buff, line)  # store line in buffer
    } else{
      if(inside) {
        cat(buff, sep = "\n")
        inside = FALSE #need this with multiple IDs
      } else {}
    }
  } else { #sequence line
    if(inside) {
      buff <- c(buff, line)
    } else{}
  }
}
#for the last sequence where there will not be another ID
if(inside) {
  cat(buff, sep = "\n")
}

close(fas_file)
