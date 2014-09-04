###########################################
# Error Rate Example Script               
#
# this script creates AFLP scoring matrices
# using a range of locus and phenotype
# thersholds then assesses error rate given
# a set of duplicate samples at the top of
# a phenotype table
###########################################
setwd("./data-raw/")
files <- c("M47_Blue.txt", "M47_Green.txt", "M49_Blue.txt", "M49_Green.txt","M51_Blue.txt", "M51_Green.txt") # list filenames
dups <- c(24,24,24,24,24,24) #number of duplicate pairs per file
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


filter.samples("/Users/ageneva/Dropbox/Non_Dissertation_Research/UR_undergrad_projects/Brev_Dist_AFLP/AJG_reAnalysis/Structure_analyses/PL1/P1_ALL_SAMPLES/project_data","/Users/ageneva/Dropbox/Non_Dissertation_Research/UR_undergrad_projects/Brev_Dist_AFLP/AJG_reAnalysis/Structure_analyses/poor_samples_removed/PL1/P1_ALL_SAMPLES/project_data_test",1)
filter.loci("/Users/ageneva/Dropbox/Non_Dissertation_Research/UR_undergrad_projects/Brev_Dist_AFLP/AJG_reAnalysis/Structure_analyses/poor_samples_removed/PL1/P1_ALL_SAMPLES/project_data_test","/Users/ageneva/Dropbox/Non_Dissertation_Research/UR_undergrad_projects/Brev_Dist_AFLP/AJG_reAnalysis/Structure_analyses/poor_samples_removed/PL1/P1_ALL_SAMPLES/project_data_test")