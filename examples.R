P1 <- read.structure("/Users/ageneva/Dropbox/Non_Dissertation_Research/UR_undergrad_projects/Brev_Dist_AFLP/AJG_reAnalysis/Structure_analyses/PL1/P1_ALL_SAMPLES/project_data")
m <- mean(rowSums(P1[,2:ncol(P1)]))
sd <- sd(rowSums(P1[,2:ncol(P1)]))
row.names(P1[which(rowSums(P1[,2:ncol(P1)])<(m-sd)),])
filtered_P1 <- P1[-which(rowSums(P1[,2:ncol(P1)])<(m-sd)),]

write.structure(filtered_P1,"/Users/ageneva/Dropbox/Non_Dissertation_Research/UR_undergrad_projects/Brev_Dist_AFLP/AJG_reAnalysis/Structure_analyses/poor_samples_removed/PL1/P1_ALL_SAMPLES/project_data")


P2 <- read.structure("/Users/ageneva/Dropbox/Non_Dissertation_Research/UR_undergrad_projects/Brev_Dist_AFLP/AJG_reAnalysis/Structure_analyses/PL2/P2_ALL_SAMPLES/project_data")
m <- mean(rowSums(P2[,2:ncol(P2)]))
sd <- sd(rowSums(P2[,2:ncol(P2)]))
row.names(P2[which(rowSums(P2[,2:ncol(P2)])<(m-sd)),])
filtered_P2 <- P2[-which(rowSums(P2[,2:ncol(P2)])<(m-sd)),]

write.structure(filtered_P2,"/Users/ageneva/Dropbox/Non_Dissertation_Research/UR_undergrad_projects/Brev_Dist_AFLP/AJG_reAnalysis/Structure_analyses/poor_samples_removed/PL2/P2_ALL_SAMPLES/project_data")


filter.samples("/Users/ageneva/Dropbox/Non_Dissertation_Research/UR_undergrad_projects/Brev_Dist_AFLP/AJG_reAnalysis/Structure_analyses/PL1/P1_ALL_SAMPLES/project_data","/Users/ageneva/Dropbox/Non_Dissertation_Research/UR_undergrad_projects/Brev_Dist_AFLP/AJG_reAnalysis/Structure_analyses/poor_samples_removed/PL1/P1_ALL_SAMPLES/project_data_test",1)
