###########################################
# AFLP Step by Step script
# Anthony J Geneva
# 2 December 2014
#
# This script is distributed with a 
# directory "data-raw" which contains a 
# PeakScanner combined table as well as 
# output from RawGeno_import()
###########################################

# this line only has to be ever run once
install.packages("devtools") 

#install and load AFLPTools library
install_github("geneva/AFLPTools")
library(AFLPTools)

###########################################
# To start load all samples and duplicates
# for a given selective primer into 
# PeakScanner. Select the appropriate size
# standard and analysis method, then click
# analyze.
#
# Once analyzed go to Export > 
# Export Combined Table. Give the file a 
# meaningful names
###########################################


library(RawGeno)
RawGeno()


###########################################
# The command above will load the RawGeno
# GUI. Go to Files>Electroph.>PeakScanner
# to the import your combined table. If you
# multiplexed using different flourescent
# tags you will need to do 1 import per tag.
# At this stage do not filter just click
# Quit and Skip Filtering. Now go to 
# Scoring>Scoring. Set Maximum bin width to
# 2. Set the scoring range to start at 50
# and click Start. That's it for RawGeno.
# Go to the R terminal and run the function
# RawGeno_import, giving a meaningful outfile
# name. The script will find the most recent
# RawGeno dataset and convert it to a usable 
# Format.
###########################################


RawGeno_import("example_outfile.txt")

###########################################
# Now comes a short manual bit. Open the
# file created by the RawGeno_import
# using a text editor and sort them so that
# the duplicated samples are all at the top
# of the file. See the M47_blue.txt for an
# example
###########################################


###########################################
# Error Rate Calculation             
#
# this script creates AFLP scoring matrices
# for each locus and phenotype threshold 
# combination then assesses error rate given
# a set of duplicate samples at the top of
# a phenotype table. It then writes a csv
# table of error rates for each file
###########################################

setwd("./data-raw/")

#create list of files to input files
files <- c("M47_Blue.txt", "M47_Green.txt") # list filenames

#number of duplicate pairs per file - count each pair as 1
dups <- c(24,24) 

# this is the set of locus and phenotype thresholds you want to evaluate
# these have been pretty resonable for us but feel free to modify
locus_list <- c(100,250,500,750)
phenotype_list <- c(100,250,500,750,1000)

write.table("Error Rates", file="error_Tables.csv", col.names=FALSE, row.names=FALSE, quote=FALSE, sep=",")
write.table("\n", file="error_Tables.csv", append=T,col.names=FALSE, row.names=FALSE, sep=",", quote=F)

for (i in 1:length(files)){
  err <- matrix(ncol=length(locus_list), nrow=length(phenotype_list)+1)
  colnames(err) <- locus_list
  row.names(err) <- c(phenotype_list,"loci")
  for (j in 1:length(locus_list)){
    for (k in 1:length(phenotype_list)){
      try(makeTable(files[i],locus_list[j],phenotype_list[k]))
      try(err[k,j] <- errorRate(paste(files[i],"_L",locus_list[j],"_P",phenotype_list[k],".txt",sep=""),dups[i]))
    }    
    try(err[nrow(err),j] <- ncol(read.table(paste(files[i],"_L",locus_list[j],"_P",phenotype_list[k],".txt",sep=""), header=T)))
  }  
  write.table(paste(files[i]), file="error_Tables.csv", append=T,col.names=FALSE, row.names=FALSE, sep=",", quote=F)
  write.table(err, file="error_Tables.csv", quote=FALSE, append=T, sep=",")
  write.table("\n", file="error_Tables.csv", append=T,col.names=FALSE, row.names=FALSE, sep=",", quote=F)
}

###########################################
# Open the error_rate.csv file and determine
# the best scoring parameters for your data
# note that increasing the locus threshold
# reduces the total number of loci retained
#
#
# Select and error rates use the filter
# functions to remove low quality samples 
# and loci
###########################################

# Filter samples removed individuals with too few loci
# By default samples with mean- 1SD loci are removed

filter.samples(infile,outfile,1)

#Filter loci removes any loci that are fixed among remaining samples 
filter.loci(infile,outfile)

