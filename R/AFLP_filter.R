#' Filters AFLP matrices to remove any loci that are absent from included samples
#'
#' This function reads an \code{STRUCTURE} formatted AFLP dataset and writes a filtered version of that file
#' @param \code{infile}  filename of Structure dataset 
#' @param \code{outfile}  desired filename for filtered Structure dataset 
#' @keywords STRUCTURE, AFLP, filtering
#' @export
#' @examples
#' AFLP_filter(myStructureFile,filteredStructureFile)


AFLP_filter <- function(infile,outfile){
  dat <- read.table(skip=1, infile)
  row.names(dat) <- dat[,1]
  dat <- dat[,-1]
  filtered_dat <- dat[,which(colSums(dat)!=0)]
  colnames(filtered_dat)  <- rep(0,ncol(filtered_dat))
  write.table(filtered_dat,outfile, quote=F, sep="\t")
  cat("Removed",(ncol(dat)-ncol(filtered_dat)),"loci\n", sep=" ")
  cat("Final dataset dimensions:\n")
  cat(nrow(filtered_dat),"individuals\n")
  cat((ncol(filtered_dat)-1),"loci\n")
}