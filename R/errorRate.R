#' Calculates mismatch error rate for AFLP dataset
#'
#' This function reads an \code{STRUCTURE} formatted AFLP dataset and writes a filtered version of that file
#' @param \code{filename}  filename of matrix containing duplicates 
#' @param \code{duplicates}  integer, the number of duplicate pairs
#' @keywords STRUCTURE, AFLP, error
#' @export
#' @examples
#' errorRate(myAflpMatrix,duplicates=10)


errorRate <- function(filename, duplicates){
  dat <- read.table(filename, header=T)
  set <- matrix(ncol=ncol(dat), nrow=nrow(dat))
  i <- 3
  set <- dat[1,]+dat[2,]  
  while(i<((2*duplicates)+1))
  {
    x <- dat[i,]+dat[(i+1),]  
    set <- rbind(set,x)  
    i <- i + 2  
  }
  error <- sum(set[,]==1)/(ncol(dat)*duplicates)
  return(error)
}
