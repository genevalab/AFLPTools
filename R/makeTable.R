#' Create AFLP data matrix from raw peak heights
#'
#' This function creates AFLP data matrix from raw peak heights scored using
#' user determined locus and phenotype thresholds.
#' This  function borrows heavily from AFLPscore v1.4 by Raj Whitlock
#' Whitlock et al. 2008 Mol Ecol Res. 8:725-735
#' shef.ac.uk/molecol/software/aflpscore  
#' 
#' @param \code{filename}  filename of matrix containing duplicates 
#' @param \code{duplicates}  integer, the number of duplicate pairs
#' @keywords AFLP, AFLPscore
#' @export
#' @examples
#' makeTable(myRawPeakHeights,binthresh=100,allelethresh=100)



makeTable <- function(filename,binthresh,allelethresh){
  gen<-read.delim(paste(filename),header=TRUE)
  nloci0<-dim(gen)[2]
  gen[is.na(gen)] <- 0
  empty_rows<-as.vector(gen[rowSums(gen)==0,1])
  emptyindex<-as.numeric(rownames(gen[rowSums(gen)==0,]))
  if((length(emptyindex)>0)==T){gen<-gen[-emptyindex,]}
  gen<-as.data.frame(gen)
  nloci<-dim(gen)[2]
  rowss<-as.vector(rowSums(gen,na.rm=TRUE))
  medianintense<-median(rowss)
  intenseweight<-medianintense/rowss
  gen2<-gen*intenseweight
  locusintense2<-apply(gen2,2,FUN=function(x)((sum(x[x>0]))/(length(x[x>0]))))
  locusintense2[is.na(locusintense2)] <- 0
  locusintense2[locusintense2<binthresh]<-0
  locusintense2[locusintense2>=binthresh]<-1
  ret_loci<-locusintense2[locusintense2==1]
  gen3<-gen2[,names(ret_loci)]
  gen3[gen3<allelethresh]<-0
  gen3[gen3>=allelethresh]<-1
  row.names(gen3) <- row.names(gen)
  write.table(gen3, file=paste(filename,"_L",binthresh,"_P",allelethresh,".txt",sep=""), sep="\t", col.names=TRUE, row.names=TRUE, quote=FALSE)
}
