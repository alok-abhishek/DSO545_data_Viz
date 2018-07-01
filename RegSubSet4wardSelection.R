library(dplyr)
library(leaps)


setwd("C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/")

#App_Exprt_DF =readRDS("expert variables")
#Train_App_Exprt_DF =readRDS("train.rds")
#Test_App_Exprt_DF =readRDS("test.rds")
#OOT_App_Exprt_DF =readRDS("oot.rds")

#write.csv(App_Exprt_DF, file = "Application_data_with_expert_variables.csv")
#write.csv(Train_App_Exprt_DF, file = "Train_App_data_with_xprt_var.csv")
#write.csv(Test_App_Exprt_DF, file = "Test_App_data_with_xprt_var.csv")
#write.csv(OOT_App_Exprt_DF, file = "OOT_App_data_with_xprt_var.csv")

#summary(App_Exprt_DF)
""

#View(App_Exprt_DF)
#names(App_Exprt_DF)

Train_App_Exprt_DF =read.csv("App_Exprt_DF_Train_KS.csv")



leaps_lm.App_Exprt_frwd = regsubsets(fraud ~ ., data = Train_App_Exprt_DF,nbest=1,nvmax=45,really.big=T,method="forward")
summary(leaps_lm.App_Exprt_frwd)
leaps_lm.App_Exprt_frwd_summary = summary(leaps_lm.App_Exprt_frwd)
plot(leaps_lm.App_Exprt_frwd_summary$adjr2, xlab="Number of Variables", ylab="Adjusted RSq",main="FRWD Subset Selection", type="b")
plot(leaps_lm.App_Exprt_frwd_summary,scale="adjr2",main="FRWD Subset Selection")

leaps_lm.App_Exprt_bkwd = regsubsets(fraud ~ ., data = Train_App_Exprt_DF,nbest=1,nvmax=45,really.big=T,method="backward")
summary(leaps_lm.App_Exprt_bkwd)
leaps_lm.App_Exprt_bkwd_summary = summary(leaps_lm.App_Exprt_bkwd)
plot(leaps_lm.App_Exprt_bkwd_summary$adjr2, xlab="Number of Variables", ylab="Adjusted RSq",main="BKWRD Subset Selection", type="b")
plot(leaps_lm.App_Exprt_bkwd_summary,scale="adjr2",main="BKWRD Subset Selection")

#leaps_lm.App_Exprt_seqrep = regsubsets(fraud ~ ., data = Train_App_Exprt_DF,nbest=1,nvmax=45,really.big=T,method="seqrep")
#summary(leaps_lm.App_Exprt_seqrep)
#leaps_lm.App_Exprt_seqrep_summary = summary(leaps_lm.App_Exprt_seqrep)
#plot(leaps_lm.App_Exprt_seqrep_summary$adjr2, xlab="Number of Variables", ylab="Adjusted RSq",main="seqrep Subset Selection", type="b")
#plot(leaps_lm.App_Exprt_seqrep_summary,scale="adjr2",main="seqrep Subset Selection")

leaps_lm.App_Exprt_exhst = regsubsets(fraud ~ ., data = Train_App_Exprt_DF,nbest=1,nvmax=41,really.big=T)
summary(leaps_lm.App_Exprt_exhst)
leaps_lm.App_Exprt_exhst_summary = summary(leaps_lm.App_Exprt_exhst)
plot(leaps_lm.App_Exprt_exhst_summary$adjr2, xlab="Number of Variables", ylab="Adjusted RSq",main="Exhaustv Subset Selection", type="b")
plot(leaps_lm.App_Exprt_exhst_summary,scale="adjr2",main="Exhaustv Subset Selection")

which.max(leaps_lm.App_Exprt_exhst_summary$adjr2)
points (21, leaps_lm.App_Exprt_exhst_summary$adjr2[21], col ="red",cex =2, pch =20)

plot(leaps_lm.App_Exprt_exhst_summary$bic, xlab="Number of Variables", ylab="bic",main="Exhaustv Subset Selection", type="b")
which.min(leaps_lm.App_Exprt_exhst_summary$bic)
points (9, leaps_lm.App_Exprt_exhst_summary$bic[9], col ="red",cex =2, pch =20)

plot(leaps_lm.App_Exprt_exhst_summary$cp, xlab="Number of Variables", ylab="Cp",main="Exhaustv Subset Selection", type="b")
which.min(leaps_lm.App_Exprt_exhst_summary$cp)
points (14, leaps_lm.App_Exprt_exhst_summary$cp[14], col ="red",cex =2, pch =20)

plot(leaps_lm.App_Exprt_exhst_summary$rsq, xlab="Number of Variables", ylab="RSq",main="Exhaustv Subset Selection", type="b")
which.max(leaps_lm.App_Exprt_exhst_summary$rsq)
points (34, leaps_lm.App_Exprt_exhst_summary$rsq[34], col ="red",cex =2, pch =20)

coef(leaps_lm.App_Exprt_exhst,21)




