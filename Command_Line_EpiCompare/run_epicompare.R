#################Start parameters selection###################
#select paramters
#select samples
#sample_list127=c("E001","E002","E003","E004","E005","E006" ,"E007","E008","E009","E010","E011","E012","E013","E014","E015" ,"E016","E017","E018","E019","E020","E021","E022","E023","E024" ,"E025","E026","E027","E028","E029","E030","E031","E032","E033" ,"E034","E035","E036","E037","E038","E039","E040","E041","E042" ,"E043","E044","E045","E046","E047","E048","E049","E050","E051" ,"E052","E053","E054","E055","E056","E057","E058","E059","E061" ,"E062","E063","E065","E066","E067","E068","E069","E070","E071" ,"E072","E073","E074","E075","E076","E077","E078","E079","E080" ,"E081","E082","E083","E084","E085","E086","E087","E088","E089" ,"E090","E091","E092","E093","E094","E095","E096","E097","E098","E099","E100","E101","E102","E103","E104","E105","E106","E107","E108","E109","E110","E111","E112","E113","E114","E115","E116" ,"E117","E118","E119","E120","E121","E122","E123","E124","E125" ,"E126","E127","E128","E129")
#select forgeround samples from 127 samples given in sample_list127 or filenames from users' data
#foreData=c('E071', 'E074', 'E068', 'E069', 'E072', 'E067', 'E073') 
foreData=c('test11', 'test22', 'test33', 'test44', 'test55','E074')
#select background samples from 127 samples given in sample_list127 or filenames from users' data
backData=c("E116" ,"E123" ,"E129" ,"E125" ,"E119" ,"E008" ,"E015" ,"E014" ,"E016" ,"E003","E007" ,"E013" ,"E012" ,"E011" ,"E004" ,"E005" ,"E006" ,"E020" ,"E019" ,"E021","E022" ,"E128" ,"E120" ,"E121" ,"E055" ,"E056" ,"E059" ,"E061" ,"E058" ,"E126","E127" ,"E026" ,"E049" ,"E122" ,"E062" ,"E034" ,"E045" ,"E044" ,"E043" ,"E039","E041" ,"E042" ,"E040" ,"E037" ,"E048" ,"E038" ,"E047" ,"E029" ,"E050" ,"E032","E046" ,"E124" ,"E063" ,"E076" ,"E106" ,"E075" ,"E078" ,"E079" ,"E109" ,"E103","E101" ,"E102" ,"E111" ,"E094" ,"E104" ,"E095" ,"E105" ,"E066" ,"E096" ,"E100","E108" ,"E097" ,"E087" ,"E098" ,"E113" ,"E112" ,"E065" ,"E080" ,"E085" ,"E084","E092" ,"E089" ,"E090" ,"E099" ,"E091" ,"E093" ,"E115" ,"E117" ,"E118" ,"E017","E114")	

#select a feature
#feature_all=c('ChromHMM','H3K4me1','H3K4me3','H3K27ac','H3K27me3')
feature='ChromHMM' #select epigenomic features from the features given in feature_all above
HMM_model='18_model' #select '15_model' or '18_model' ChromHMM
chrom_state='enhancer' #select 'enhancer' or 'promoter' state from ChromHMM model

#select a method and associated parameters
method='cutoff' #select 'cutoff', 'fisher' or 'cluster'
#parameters for frequency cutoff method
foreCutoff=0.8
backCutoff=0.2
#paramters for fisher's exact test
fisherCutoff=0.01
parallel_core=10 #number of cores to use
#parameters for clustering method
cluster_num='c140' #select number of clusters from 'c140','c90','c200',or 'c250'
clusterQuantile=100
clusterCutoff=0.4

#other parameters
user_data='True' #wether user uses their own data
outfile_name='brain_enhancer_cutoff' #provide file name to save identified regions
userdir='user_data'
outdir='brain_enh'

#check paramters
if(length(foreData)==0){
	cat('Error: foreground samples cannot be empty.','\n')
	q('no')
}
if(method=='fisher' & length(backData)==0){
	cat('Error: For Fisher\'s exact method, background samples cannot be empty.','\n')
	q('no')
}
#################End of parameters selection###################





#################Start identify regions###################
library(ggplot2)
require(data.table)
source('functions.R')

#get Roadmap data for selected feature
sample_logic=get_roadmap_data(feature,HMM_model,chrom_state)

#get coordinate file for processing user data
main_path=getwd()
coord=get_coord(feature,HMM_model,chrom_state)
coord_path=file.path(main_path,coord)

#check if ourdir exists. If not, create it.
if (file.exists(outdir)){
    setwd(file.path(main_path, outdir))
} else {
    dir.create(file.path(main_path, outdir))
    setwd(file.path(main_path, outdir))
}

#process user's data and combine them with roadmap data
if(user_data=='True'){
    user_logic=process_user_data(coord_path,main_path,userdir)
    sample_logic=cbind(sample_logic,user_logic)
    print(sample_logic[1:2,])
}

# #get the list of samples existing in Roadmap data for selected feature
# sample_list=get_sample_list(feature,HMM_model,sample_list127,sample_list98)



#identify regions using selected method
final_data=identify_regions()


#check the size of final data
if(nrow(final_data)==0){
	cat('No regions are identified for given paramters.','\n')
	q('no')
}

#write final data into file and sort the file
write.table(final_data, outfile_name, row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')
outfile_sort=paste(outfile_name,'.sort',sep='')
cmd_sort=paste('sort -k1,1 -k2,2n ',outfile_name,'>',outfile_sort,sep=' ')
system(cmd_sort)
#################End of identifying regions###################





#################Start of validation for identified regions###################
#plot enrichment for H3K27ac peaks
enrich_data=cal_enrichment(outfile_sort,foreData,backData,main_path)
write.table(enrich_data, 'H3K27ac_peaks_enrichment.txt', row.names=FALSE,col.names=TRUE,quote=FALSE,sep='\t')

#plot ctm distribution on H3K27ac
fore_sam_k27=c()
for (x in foreData){
    if (is.element(x, sample_list98)){
        fore_sam_k27=c(fore_sam_k27,x)
    }
}
if(length(fore_sam_k27)==0){
	cat('All foreground samples do not have H3K27ac data for the analysis. No CTM analysis is performed','\n')
	q('no')
}
load(paste(main_path,'/Rdata/H3K27ac_RPKM.Rdata',sep=''))

back_sam_k27=c()
for (x in backData){
    if (is.element(x, sample_list98)){
        back_sam_k27=c(back_sam_k27,x)
    }
}

H3K27ac_rpkm_path=paste(main_path,H3K27ac_rpkm_path,sep='/')
cmd_inter=paste('bedtools','intersect','-a',H3K27ac_rpkm_path,'-b',outfile_sort,'-c','-sorted','>H3K27ac_rpkm_coord_intersect_output.txt')
system(cmd_inter)
intersect_mark=as.data.frame(fread('H3K27ac_rpkm_coord_intersect_output.txt',header=F))
H3K27ac_RPKM_intersect=H3K27ac_RPKM[intersect_mark[,4]==1,]
if(dim(H3K27ac_RPKM_intersect)[1] == 0){
	cat('No ctm for identified regions. No CTM analysis is performed','\n')
	q('no')
}
ctm_enrich=intersect_plot(H3K27ac_RPKM_intersect,fore_sam_k27,back_sam_k27,'H3K27ac_ctm.png')
write.table(ctm_enrich, 'H3K27ac_ctm.txt', row.names=FALSE,col.names=TRUE,quote=FALSE,sep='\t')
#################End of validation for identified regions###################