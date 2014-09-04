#' Read a standard STRUCTURE dataset
#'
<<<<<<< HEAD
#' This function reads a \code{STRUCTURE}-formatted AFLP dataset and returns a row labelled dataframe
=======
#' This function reads an \code{STRUCTURE} formatted AFLP dataset and returns a row labelled dataframe
>>>>>>> ee23773d54dca35e89bb729790c869295ae2f907
#' @param \code{infile}  filename of Structure dataset 

#' @keywords STRUCTURE, AFLP, read
#' @export
#' @examples
#' read.structure(myStructureFile)

read.structure <- function(infile){
  dat <- read.table(skip=1, infile)
  row.names(dat) <- dat[,1]
  dat <- dat[,-1]
  dat
}