#fixed global variables for ctm analysis
H3K27ac_rpkm_path='coordinates/H3K27ac_rpkm_coord' #path to H3K27ac rpkm data 
#list of tissues and samples that have H3K27ac data
tissue98=c('BLOOD_PrimaryCulture', 'BONE_PrimaryCulture', 'BRAIN_PrimaryCulture', 'BREAST_PrimaryCulture', 'ESC_PrimaryCulture', 'ESC_DERIVED_PrimaryCulture', 'IPSC_PrimaryCulture', 'LUNG_PrimaryCulture', 'MUSCLE_PrimaryCulture', 'SKIN_PrimaryCulture', 'STROMAL_CONNECTIVE_PrimaryCulture', 'VASCULAR_PrimaryCulture', 'BLOOD_Adult', 'BRAIN_Adult', 'FAT_Adult', 'GI_COLON_Adult', 'GI_DUODENUM_Adult', 'GI_ESOPHAGUS_Adult', 'GI_INTESTINE_Adult', 'GI_RECTUM_Adult', 'GI_STOMACH_Adult', 'HEART_Adult', 'LIVER_Adult', 'LUNG_Adult', 'MUSCLE_Adult', 'OVARY_Adult', 'PANCREAS_Adult', 'SPLEEN_Adult', 'THYMUS_Adult', 'VASCULAR_Adult', 'ADRENAL_Fetal', 'GI_INTESTINE_Fetal', 'GI_STOMACH_Fetal', 'MUSCLE_Fetal', 'PLACENTA_Fetal', 'THYMUS_Fetal', 'BLOOD_CellLine', 'CERVIX_CellLine', 'LIVER_CellLine', 'LUNG_CellLine')
sample98=list(c('E116', 'E123'), c('E129'), c('E125'), c('E119'), c('E008', 'E015', 'E014', 'E016', 'E003'), c('E007', 'E013', 'E012', 'E011', 'E004', 'E005', 'E006'), c('E020', 'E019', 'E021', 'E022'), c('E128'), c('E120', 'E121'), c('E055', 'E056', 'E059', 'E061', 'E058', 'E126', 'E127'), c('E026', 'E049'), c('E122'), c('E062', 'E034', 'E045', 'E044', 'E043', 'E039', 'E041', 'E042', 'E040', 'E037', 'E048', 'E038', 'E047', 'E029', 'E050', 'E032', 'E046', 'E124'), c('E071', 'E074', 'E068', 'E069', 'E072', 'E067', 'E073'), c('E063'), c('E076', 'E106', 'E075'), c('E078'), c('E079'), c('E109'), c('E103', 'E101', 'E102'), c('E111', 'E094'), c('E104', 'E095', 'E105'), c('E066'), c('E096'), c('E100', 'E108'), c('E097'), c('E087', 'E098'), c('E113'), c('E112'), c('E065'), c('E080'), c('E085', 'E084'), c('E092'), c('E089', 'E090'), c('E099', 'E091'), c('E093'), c('E115'), c('E117'), c('E118'), c('E017', 'E114'))
sample_list98=unlist(sample98)
#fixed tissue for ctm analysis
select_tissue=c('BRAIN_Adult','BLOOD_Adult','HEART_Adult','GI_INTESTINE_Adult','ESC_PrimaryCulture')
#list of all 127 samples from Roadmap
sample_list127=c("E001","E002","E003","E004","E005","E006" ,"E007","E008","E009","E010","E011","E012","E013","E014","E015" ,"E016","E017","E018","E019","E020","E021","E022","E023","E024" ,"E025","E026","E027","E028","E029","E030","E031","E032","E033" ,"E034","E035","E036","E037","E038","E039","E040","E041","E042" ,"E043","E044","E045","E046","E047","E048","E049","E050","E051" ,"E052","E053","E054","E055","E056","E057","E058","E059","E061" ,"E062","E063","E065","E066","E067","E068","E069","E070","E071" ,"E072","E073","E074","E075","E076","E077","E078","E079","E080" ,"E081","E082","E083","E084","E085","E086","E087","E088","E089" ,"E090","E091","E092","E093","E094","E095","E096","E097","E098","E099","E100","E101","E102","E103","E104","E105","E106","E107","E108","E109","E110","E111","E112","E113","E114","E115","E116" ,"E117","E118","E119","E120","E121","E122","E123","E124","E125" ,"E126","E127","E128","E129")


#get roadmap data 
get_roadmap_data=function(feature){
    if (feature=='ChromHMM'){
        if (HMM_model=='15 model'){
            load('Rdata/ChromHMM15_logic.Rdata')
            if (chrom_state=="enhancer"){
                sample_logic=enhancer_logic_15
            }else{
                sample_logic=promoter_logic_15 
            }
        }else{
            load('Rdata/ChromHMM18_logic.Rdata')
            if (chrom_state=="enhancer"){
                sample_logic=enhancer_logic_18 
            }else{
                sample_logic=promoter_logic_18 
            }
        }
    }else if (feature=='H3K27ac'){
        load('Rdata/H3K27ac_logic.Rdata')
        sample_logic=H3K27ac_logic
    }else if (feature=='H3K4me1'){
        load('Rdata/H3K4me1_logic.Rdata')
        sample_logic=H3K4me1_logic
    }else if (feature=='H3K4me3'){
        load('Rdata/H3K4me3_logic.Rdata')
        sample_logic=H3K4me3_logic
    }else {
        load('Rdata/H3K27me3_logic.Rdata')
        sample_logic=H3K27me3_logic
    }
    return(sample_logic)  
}


#get coordinate file for processing user data
get_coord=function(feature){
    if (feature=='ChromHMM'){
        if (HMM_model=='15 model'){
            if (chrom_state=="enhancer"){
                coord='coordinates/enhancer_logic_15_coord'
            }else{
                coord='coordinates/promoter_logic_15_coord' 
            }
        }else{
            if (chrom_state=="enhancer"){
                coord='coordinates/enhancer_logic_18_coord'   
            }else{
                coord='coordinates/promoter_logic_18_coord' 
            }
        }
        }else if (feature=='H3K27ac'){
            coord='coordinates/H3K27ac_logic_coord'
        }else if (feature=='H3K4me1'){
            coord='coordinates/H3K4me1_logic_coord'
        }else if (feature=='H3K4me3'){
            coord='coordinates/H3K4me3_logic_coord'
        }else {
            coord='coordinates/H3K27me3_logic_coord'
        }
        return(coord)  
}


#process user's data
process_user_data=function(coord_file,main_path,userdir){
    userdir_path=file.path(main_path,userdir)
    file_list=list.files(userdir_path)
    for (i in 1:length(file_list)){
        file_path=file.path(userdir_path,file_list[i])
        file_sort=paste(file_list[i],'.sort',sep='')
        file_inter=paste(file_list[i],'.inter',sep='')
        cmd_sort=paste('sort -k1,1 -k2,2n ',file_path,'>',file_sort,sep=' ')
        system(cmd_sort)
        cmd_inter=paste('bedtools','intersect','-a', coord_file, '-b', file_sort,'-sorted', '-c', '>',file_inter, sep=' ')
        system(cmd_inter)
        if(exists('temp_data')){
            data_read=read.table(file_inter,header=F)
            data_read_last=data_read[,4]
            data_read_last[data_read_last>1]=1
            temp_data=cbind(temp_data,data_read_last)
        }else{
            data_read=read.table(file_inter,header=F)
            data_read_last=data_read[,4]
            data_read_last[data_read_last>1]=1
            temp_data=data_read_last
        }
    }
    colnames(temp_data)=file_list
    return(temp_data)
}


#enrichment analysis 
cal_enrichment<-function(target_file,foredata,backdata,main_path){

    hg19_num_nucleotide <- as.numeric(2897310462)

    #permuate foredata and backdata
    foredata=sample(foredata, length(foredata), replace = FALSE)
    backdata=sample(backdata, length(backdata), replace = FALSE)

    #calculate num of bp in a file
    cal_bp=function(filepath){
        a=fread(filepath)
        return (sum(a[,3,with=FALSE]-a[,2,with=FALSE]))
    }

    #target
    target_path=normalizePath(target_file)
    targe_bp=cal_bp(target_path)

    #fore
    fore_sam=c()
    fore_enr=c()
    fore_type=c()
    count=0
    for (x in foredata){
        if (is.element(x, sample_list127)){
            if (count>=10){
                break
            }
            fore_sam=c(fore_sam,x)
            fore_type=c(fore_type,'Foreground_samples')
            if (is.element(x, sample_list98)){
                f_path=paste(main_path,'/H3K27ac_peak_sort/',x,'-H3K27ac.narrowPeak_sort',sep='')
            }else{
                f_path=paste(main_path,'/H3K27ac_peak_sort/',x,'-H3K27ac.imputed.narrowPeak.bed.nPk_sort',sep='')
            }
            cmd=paste('bedtools','intersect','-a',target_path,'-b',f_path,'-sorted','>enrich_intersect.txt')
            #print(cmd)
            system(cmd)
            #check if the intersection file is empty. Otherwise return and stop analysis.
            info = file.info('enrich_intersect.txt')
            if (info$size==0){
                return (data.frame())
            }
            enr=cal_bp('enrich_intersect.txt')/targe_bp *(hg19_num_nucleotide/cal_bp(f_path)) #cal enrichment
            fore_enr=c(fore_enr,enr)
            count=count+1
        }
    }

    #back
    back_sam=c()
    back_enr=c()
    back_type=c()
    count=0
    for (x in backdata){
        if (is.element(x, sample_list127)){
            if (count>=10){
                break
            }
            back_sam=c(back_sam,x)
            back_type=c(back_type,'Background_samples')
            if (is.element(x, sample_list98)){
                f_path=paste(main_path,'/H3K27ac_peak_sort/',x,'-H3K27ac.narrowPeak_sort',sep='')
            }else{
                f_path=paste(main_path,'/H3K27ac_peak_sort/',x,'-H3K27ac.imputed.narrowPeak.bed.nPk_sort',sep='')
            }
            cmd=paste('bedtools','intersect','-a',target_path,'-b',f_path,'-sorted','>enrich_intersect.txt')
            system(cmd)
            enr=cal_bp('enrich_intersect.txt')/targe_bp *(hg19_num_nucleotide/cal_bp(f_path)) #cal enrichment
            back_enr=c(back_enr,enr)
            count=count+1
        }
    }

    #data frame
    sam=c(fore_sam,back_sam)
    enrichment=c(fore_enr,back_enr)
    type=c(fore_type,back_type)
    data=data.frame(sam,enrichment,type)       

    #plot
    data$sam <- factor(data$sam, levels = sam)
    data$type <- factor(data$type, levels = type)
    png('H3K27ac_peaks_enrichment.png',width=800, height=400)
    p <- ggplot(data=data, aes(x=sam, y=enrichment, fill=type))+
    geom_bar(position = 'dodge', stat='identity')+xlab('Samples')+ylab('Enrichment fold')+
    scale_fill_manual(values=c('blue','red'))
    print(p)
    dev.off()
    return(data)
}#end of cal_enrichment


#start analysis of ctm index distribution in different tissues/cells
norm_vec <- function(x) sqrt(sum(x^2))
spm_vec<-function(x) as.numeric(x/norm_vec(x))
#calcualte spm
calculate_spm=function(data){
    norm_data=apply(data,1,norm_vec)
    spm_m=data/norm_data
    return(spm_m)
}
#calcualte ctm
calculate_ctm=function(spm_m,sam){
    if (length(sam)==1){
        return(spm_m[,sam])
    }else{
        return(apply(spm_m[,sam],1,norm_vec))
    }
}
#calcualte ctm index distribution
hist_density<-function(data,numNo){
    a=hist(data,breaks=seq(0, 1, 0.05),right=FALSE,plot=FALSE)
    b=a$counts
    b[1]=b[1]+numNo
    return(round(b/sum(b),4))
}
#plot ctm index distribution
plot_multiple_lines=function(data,numNo,figure_name){
    numCol=dim(data)[2]
    x=seq(0, 0.95, 0.05)
    outdata=x 
    for(i in c(1:numCol)){
          a1=hist_density(data[,i],numNo)
          outdata=cbind(outdata,a1)
    }
    colnames(outdata)=c('bins',colnames(data))

    #plot using ggplot2
    num_x=dim(outdata)[1]
    num_y=dim(outdata)[2]

    mytable=matrix(,nrow=num_x*(num_y-1),ncol=3)
    mytable=as.data.frame(mytable)
    colnames(mytable)=c('supp','dose','len')
    supp_types=colnames(outdata)[2:num_y]
    dose_types=outdata[,1]

    a=0
    for (i in c(2:num_y)){
        for (j in c(1:num_x)){
            subdata=outdata[j,i]
            a=a+1
            mytable[a,1]=supp_types[i-1]
            mytable[a,2]=dose_types[j]
            mytable[a,3]=subdata
        }
    }

    mytable <- within(mytable,supp <- factor(supp,levels=supp))
    pd <- position_dodge(0)
    png(figure_name)
    p <- ggplot(mytable, aes(x=dose, y=len, colour=supp, group=supp)) + 
        geom_line(position=pd) +
        geom_point(position=pd, size=2) + 
        xlab("CTM") +
        ylab("Frequency") +
        scale_color_manual(name="Tissues",values = c('red','green','blue','black','brown','orange','gray'),labels=supp_types,breaks=supp_types) +
        ylim(0, 0.5)+theme_bw() 

    print(p)
    dev.off()
    #done
    return(outdata)
}
#calculate ctm for several tissues
cal_ctm_several_tis<-function(data,target_sam,back_sam){
    for (tis in select_tissue){
        sam=unlist(sample98[tissue98==tis])
        if (length(sam)>=7){
            sam=sample(sam, 7, replace = FALSE)
        }
        if (exists('comb_ctm')){
            comb_ctm=cbind(comb_ctm,calculate_ctm(data,sam))
        }else{
            comb_ctm=calculate_ctm(data,sam)
        }            
    }
    colnames(comb_ctm)=c('brain_adult','blood_adult','heart_adult','intestine_adult','ESC_cell')

    #back
    if (length(back_sam)>0){ #back exists
        if (length(back_sam)>=7){
            back_sam=back_sam[1:7]
        }
        comb_ctm=cbind(calculate_ctm(data,back_sam),comb_ctm)
        colnames(comb_ctm)=c('background_samples','brain_adult','blood_adult','heart_adult','intestine_adult','ESC_cell')             

        #fore 
        if (length(target_sam)>=7){
            target_sam=target_sam[1:7]
        }
        comb_ctm=cbind(calculate_ctm(data,target_sam),comb_ctm)
        colnames(comb_ctm)=c('foreground_samples','background_samples','brain_adult','blood_adult','heart_adult','intestine_adult','ESC_cell')             
        
    }else { #back non-existing
        if (length(target_sam)>=7){
            target_sam=target_sam[1:7]
        }
        comb_ctm=cbind(calculate_ctm(data,target_sam),comb_ctm)
        colnames(comb_ctm)=c('foreground_samples','brain_adult','blood_adult','heart_adult','intestine_adult','ESC_cell')             
    }

    #fore
    return(comb_ctm)
}
#main function to plot ctm index distribution in different tissues
intersect_plot<-function(data,target_sam,back_sam,figure_name){
    num_noInter=0
    spm_data=calculate_spm(data)
    comb_ctm=cal_ctm_several_tis(spm_data,target_sam,back_sam)
    outdata=plot_multiple_lines(comb_ctm,num_noInter,figure_name)
    return(outdata) 
}
#end of analysis of ctm index distribution in different tissues/cells


#calculate p-value for Fisher's exact test
myfun<-function(x) {
    a=fisher.test(matrix(x,nrow=2), alternative = "greater")
    return (a$p.value)
}


#identification of tissue-specific clusters from clustering result
#get quantile
cal_qunatile=function(x,per){
    return(quantile(x,c(per)))
}           
#function to get cluster from cluster density 
get_cluster=function(foreSam,backSam,density_mat,clusterQuantile,clusterCutoff){ #the final column of density_mat is cluster number 
    #for_den
    if (length(foreSam)==1){
        for_den=density_mat[,foreSam]
    }else{
        for_den=apply(density_mat[,foreSam],1,median)
    }
    #back_den
    if (length(backSam)>0){
        if (length(backSam)==1){
            back_den=density_mat[,backSam]
        }else{
            back_den=apply(density_mat[,backSam],1,cal_qunatile,per=clusterQuantile)
        }
    }else{
        back_den=0
    }
              
    cluster_Name=density_mat[for_den>=back_den & for_den>=clusterCutoff,dim(density_mat)[2]]
    return(cluster_Name)
}
#function to get regions for specific clusters 
get_regions=function(column_cluster,cluster_Name){ # column_cluster is the cluster name for all data
    #get final data
    if (length(cluster_Name)==1){
        logic= column_cluster==cluster_Name[1]
    }else{
        base='column_cluster=='
        exp='column_cluster==cluster_Name[1]'
        for (x in cluster_Name[c(2:length(cluster_Name))]){
            exp=paste(exp,'|',base,x,sep='')
        }
        logic=eval(parse(text = exp))
    }
    return(logic)
}
#calculate feature density
cal_density=function(data,numClu){
    for (num in 1:numClu){
        len=dim(data)[2]
        logic=data[,len]==num
        oneData=apply(data[logic,],2,mean)
        if (!exists("allData")){
            allData=oneData
        }else{
            allData=rbind(allData,oneData)
        }
    }
    return (allData)
}
#end of identification of tissue-specific clusters from clustering result


#identify regions 
identify_regions=function(){
#preprocess data for frequency cutoff and Fisher's exact test method and load clustering data for k-means clustering method
#calcualte foreground sample and background sample sum
len_fore=length(foreData)
len_back=length(backData)
       if (method=="cutoff" |method=="fisher"){ #cutoff or fisher
            if (len_fore==1){
                foreSum=sample_logic[,foreData]
            }else{
                foreSum=rowSums(sample_logic[,foreData])
            } 

            if (len_back>0){
                if (len_back==1){
                        backSum=sample_logic[,backData]
                    }else{
                        backSum=rowSums(sample_logic[,backData])
                    }
            }
        }else { #cluster
            if (feature=='ChromHMM'){
                if (HMM_model=='15 model'){                   
                    if (chrom_state=="enhancer"){
                        load('Rdata/enh15_cluster_data.Rdata')
                        if (cluster_num==140){
                            cluster_last=enh15_140cluster_lastColumn
                            cluster_density=enh15_140cluster_density                    
                        }else if(cluster_num==90){
                            cluster_last=enh15_90cluster_lastColumn
                            cluster_density=enh15_90cluster_density
                        }else if(cluster_num==200){
                            cluster_last=enh15_200cluster_lastColumn
                            cluster_density=enh15_200cluster_density
                        }else {
                            cluster_last=enh15_250cluster_lastColumn
                            cluster_density=enh15_250cluster_density
                        }
                    }else{
                        load('Rdata/tss15_cluster_data.Rdata')
                        if (cluster_num==140){
                            cluster_last=tss15_140cluster_lastColumn
                            cluster_density=tss15_140cluster_density                    
                        }else if(cluster_num==90){
                            cluster_last=tss15_90cluster_lastColumn
                            cluster_density=tss15_90cluster_density
                        }else if(cluster_num==200){
                            cluster_last=tss15_200cluster_lastColumn
                            cluster_density=tss15_200cluster_density
                        }else {
                            cluster_last=tss15_250cluster_lastColumn
                            cluster_density=tss15_250cluster_density
                        }
                    }
                    
                }else{
                    if (chrom_state=="enhancer"){
                        load('Rdata/enh18_cluster_data.Rdata')                      
                        if (cluster_num==140){
                            cluster_last=enh18_140cluster_lastColumn
                            cluster_density=enh18_140cluster_density                    
                        }else if(cluster_num==90){
                            cluster_last=enh18_90cluster_lastColumn
                            cluster_density=enh18_90cluster_density
                        }else if(cluster_num==200){
                            cluster_last=enh18_200cluster_lastColumn
                            cluster_density=enh18_200cluster_density
                        }else {
                            cluster_last=enh18_250cluster_lastColumn
                            cluster_density=enh18_250cluster_density
                        }

                    }else{
                        load('Rdata/tss18_cluster_data.Rdata') 
                        if (cluster_num==140){
                            cluster_last=tss18_140cluster_lastColumn
                            cluster_density=tss18_140cluster_density                    
                        }else if(cluster_num==90){
                            cluster_last=tss18_90cluster_lastColumn
                            cluster_density=tss18_90cluster_density
                        }else if(cluster_num==200){
                            cluster_last=tss18_200cluster_lastColumn
                            cluster_density=tss18_200cluster_density
                        }else {
                            cluster_last=tss18_250cluster_lastColumn
                            cluster_density=tss18_250cluster_density
                        }
                    }
                }

            }else if (feature=='H3K27ac'){
                load('Rdata/H3K27ac_cluster_data.Rdata')
                if (cluster_num==140){
                    cluster_last=H3K27ac_140cluster_lastColumn
                    cluster_density=H3K27ac_140cluster_density                  
                }else if(cluster_num==90){
                    cluster_last=H3K27ac_90cluster_lastColumn
                    cluster_density=H3K27ac_90cluster_density
                }else if(cluster_num==200){
                    cluster_last=H3K27ac_200cluster_lastColumn
                    cluster_density=H3K27ac_200cluster_density
                }else {
                    cluster_last=H3K27ac_250cluster_lastColumn
                    cluster_density=H3K27ac_250cluster_density
                }

            }else if (feature=='H3K4me1'){
                load('Rdata/H3K4me1_cluster_data.Rdata')
                if (cluster_num==140){
                    cluster_last=H3K4me1_140cluster_lastColumn
                    cluster_density=H3K4me1_140cluster_density                  
                }else if(cluster_num==90){
                    cluster_last=H3K4me1_90cluster_lastColumn
                    cluster_density=H3K4me1_90cluster_density
                }else if(cluster_num==200){
                    cluster_last=H3K4me1_200cluster_lastColumn
                    cluster_density=H3K4me1_200cluster_density
                }else {
                    cluster_last=H3K4me1_250cluster_lastColumn
                    cluster_density=H3K4me1_250cluster_density
                }

            }else if (feature=='H3K4me3'){
                load('Rdata/H3K4me3_cluster_data.Rdata')
                if (cluster_num==140){
                    cluster_last=H3K4me3_140cluster_lastColumn
                    cluster_density=H3K4me3_140cluster_density                  
                }else if(cluster_num==90){
                    cluster_last=H3K4me3_90cluster_lastColumn
                    cluster_density=H3K4me3_90cluster_density
                }else if(cluster_num==200){
                    cluster_last=H3K4me3_200cluster_lastColumn
                    cluster_density=H3K4me3_200cluster_density
                }else {
                    cluster_last=H3K4me3_250cluster_lastColumn
                    cluster_density=H3K4me3_250cluster_density
                }

            }else{
                load('Rdata/H3K27me3_cluster_data.Rdata')
                if (cluster_num==140){
                    cluster_last=H3K27me3_140cluster_lastColumn
                    cluster_density=H3K27me3_140cluster_density                 
                }else if(cluster_num==90){
                    cluster_last=H3K27me3_90cluster_lastColumn
                    cluster_density=H3K27me3_90cluster_density
                }else if(cluster_num==200){
                    cluster_last=H3K27me3_200cluster_lastColumn
                    cluster_density=H3K27me3_200cluster_density
                }else {
                    cluster_last=H3K27me3_250cluster_lastColumn
                    cluster_density=H3K27me3_250cluster_density
                }

            } 
        }


       #cutoff method
        if (method=="cutoff"){
            forePer=foreSum/len_fore
            if (len_back>0){
                backPer=backSum/len_back
                diff=round(forePer-backPer,3)
                logic=forePer>=foreCutoff & backPer<= backCutoff 
            }else{
                diff=round(forePer,3)
                logic=forePer>=foreCutoff 
            }
            final_data=cbind(sample_logic[logic,1:3],diff[logic])
            len_final=dim(final_data)[2]
            final_data=final_data[order(-final_data[,len_final]),]
            names(final_data)[len_final]="rank"
       
        #fisher method
        }else if (method=="fisher"){
            fore_zeroN=len_fore-foreSum
            back_zeroN=len_back-backSum
            combine=cbind(foreSum,fore_zeroN,backSum,back_zeroN)
            combine=combine[foreSum>0,]
            #parallel computing
            library(parallel)
            cl <- makeCluster(parallel_core)
            p_value=parApply(cl,combine,1,myfun)
            stopCluster(cl)
            q_value=p.adjust(p_value,"BH")
            final_data=cbind(sample_logic[foreSum>0,][q_value<fisherCutoff,1:3],q_value[q_value<fisherCutoff])
            len_final=dim(final_data)[2]
            final_data=final_data[order(final_data[,len_final]),]
            names(final_data)[len_final]="rank"

        #cluster method
        }else {
            final_data=data.frame(chr=character(),start=character(),end=character())        
            cluster_Name=get_cluster(foreData,backData,cluster_density,clusterQuantile/100,clusterCutoff)
            if (length(cluster_Name)>0){
                logic=get_regions(cluster_last,cluster_Name)
                final_data=sample_logic[logic,c(1:3)]
            }

        } #end of all methods
        return(final_data)
}

