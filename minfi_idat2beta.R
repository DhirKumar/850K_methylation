library(minfi)
## Process internal samples
## Change path to your repository
## Download shample_sheet.csv before running
 
path <- "C:/Users/dhire/Downloads/GL_Task/internal_dataset_with_metadata"
sample_sheet <- read.metharray.sheet(path)
rgSet <- read.metharray.exp(targets = sample_sheet)
mset <- preprocessRaw(rgSet)
## extract beta values as dataframe
beta_df <- as.data.frame(getBeta(mset))
colnames(beta_df) <- paste0("internal_", colnames(beta_df))
## extract m-values as dataframe
m_val_df <- as.data.frame(getM(mset))
colnames(m_val_df) <- paste0("internal_", colnames(m_val_df))


## Process public samples
## Change path to your repository
## Download shample_sheet.csv before running
pub_path <- "C:/Users/dhire/Downloads/GL_Task/public_datasets_with_metadata"
p_sample_sheet <- read.metharray.sheet(pub_path)
p_rgSet <- read.metharray.exp(targets = p_sample_sheet,force=TRUE)
p_mset <- preprocessRaw(p_rgSet)
## extract beta values as dataframe
p_beta_df <- as.data.frame(getBeta(p_mset))
colnames(p_beta_df) <- paste0("public_", colnames(p_beta_df))
## extract m-values as dataframe
p_m_val_df <- as.data.frame(getM(p_mset))
colnames(p_m_val_df) <- paste0("internal_", colnames(p_m_val_df))

# merge and export beta values from internal and test datasets 
beta_df$probeID<-rownames(beta_df)
p_beta_df$probeID<-rownames(p_beta_df)
merged_beta<-merge(beta_df,p_beta_df,by="probeID",all=TRUE)
write.csv(merged_beta, file = "merged_beta.csv", row.names = FALSE)

# merge and export m-values from internal and test datasets 
m_val_df$probeID<-rownames(m_val_df)
p_m_val_df$probeID<-rownames(p_m_val_df)
merged_mvals<-merge(m_val_df,p_m_val_df,by="probeID",all=TRUE)
write.csv(merged_mvals, file = "merged_mvalues.csv", row.names = FALSE)


     