#' Filters AFLP matrices to remove poor quality samples
#'
#' This function reads a \code{STRUCTURE}-formatted AFLP dataset and writes a filtered version of that file
#' @param \code{infile}  filename of Structure dataset 
#' @param \code{outfile}  desired filename for filtered Structure dataset 
#' @param \code{cutoff}  number of standard deviations below the mean to use as a threshold
#' @keywords STRUCTURE, AFLP, filtering
#' @export
#' @examples
#' filter.samples(myStructureFile,filteredStructureFile, cutoff)
#' 

filter.samples <- function(infile, outfile,cutoff=1){
  dat <- read.structure(infile)
  m <- mean(rowSums(dat[,2:ncol(dat)]))
  sd <- sd(rowSums(dat[,2:ncol(dat)]))
  list <- row.names(dat[which(rowSums(dat[,2:ncol(dat)])<(m-cutoff*sd)),])
  filtered_dat <- dat[-which(rowSums(dat[,2:ncol(dat)])<(m-cutoff*sd)),]
  cat("Removed the following",length(list),"low quality samples\n", sep=" ")
  for (i in 1:length(list)){
    cat(list[i],"\n")
  }
  write.structure(filtered_dat,outfile)
}