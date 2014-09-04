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
  dat <- read.structure(infile)
  filtered_dat <- dat[,which(colSums(dat)!=0)]
  cat("Removed",(ncol(dat)-ncol(filtered_dat)),"loci\n", sep=" ")
  write.structure(filtered_dat, outfile)
}