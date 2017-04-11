## README file created by Yu He on March 7, 2017
## Please contact yu.he@wustl.edu with questions or for clarifications.


###############  Part 0: Setup ####################
This folder "Command_Line_EpiCompare" contains the code for running command-line EpiCompare in the server. Download the code, which will create Command_Line_EpiCompare folder under EpiCompare folder.

a. After downloading the code in Command_Line_EpiCompare folder, download datasets at the link http://wangftp.wustl.edu/~yhe/EpiCompare_datasets/dataset.tar.gz. Uncompress the compressed .tar.gz file in Command_Line_EpiCompare folder using command "tar -xzvf dataset.tar.gz". This will generate three folders: H3K27ac_peak_sort, Rdata and coordinates. Folder H3K27ac_peak_sort lists H3K27ac peaks for Roadmap samples. Folder Rdata lists binary data for epigenomic features. Folder coordinates list coordinates corresponding to the binary data for epigenomic features.

b. Dependencies for EpiCompare include BedTools, bash, and R. R packages ggplot2, data.table and parallel packages are required. Please make sure these are installed and working before trying to run EpiCompare.

c. After finishing the setup, simply run "Rscript  run_epicompare.R" to start the analysis. 

Below I will describe the pipeline of command-line EpiCompare tool.
- Part 1 describes how to specify the input variables and files to EpiCompare.
- Part 2 describes how to identify regions using given method and paramters.
- Part 3 describes how to validate identified regions.


###############  Part 1: specify the input variables and files ####################
EpiCompare requires that input variables and files be set in the file run_epicompare.R. The file currently contains an outline of the pipeline, with inputs currently set to identify brain-specific enhancers using 18-state ChromHMM model. The description of the required inputs is described below: 

a. sample names: specify foreground samples and background samples from given Roadmap samples or user-defined samples. The name of user-defined sample is the name of the given file. User-defined samples should be put in a folder, which is specified by a paramter "userdir". See step d for this paramter.

Example (as shown in run_epicompare.R): 
foreData=c('E071', 'E074', 'E068', 'E069', 'E072', 'E067', 'E073') 
backData=c("E116" ,"E123" ,"E129" ,"E125" ,"E119" ,"E008" ,"E015" ,"E014" ,"E016" ,"E003","E007" ,"E013" ,"E012" ,"E011" ,"E004" ,"E005" ,"E006" ,"E020" ,"E019" ,"E021","E022" ,"E128" ,"E120" ,"E121" ,"E055" ,"E056" ,"E059" ,"E061" ,"E058" ,"E126","E127" ,"E026" ,"E049" ,"E122" ,"E062" ,"E034" ,"E045" ,"E044" ,"E043" ,"E039","E041" ,"E042" ,"E040" ,"E037" ,"E048" ,"E038" ,"E047" ,"E029" ,"E050" ,"E032","E046" ,"E124" ,"E063" ,"E076" ,"E106" ,"E075" ,"E078" ,"E079" ,"E109" ,"E103","E101" ,"E102" ,"E111" ,"E094" ,"E104" ,"E095" ,"E105" ,"E066" ,"E096" ,"E100","E108" ,"E097" ,"E087" ,"E098" ,"E113" ,"E112" ,"E065" ,"E080" ,"E085" ,"E084","E092" ,"E089" ,"E090" ,"E099" ,"E091" ,"E093" ,"E115" ,"E117" ,"E118" ,"E017","E114")	

b. feature: specify the epigenomic feature available at the tool ('ChromHMM','H3K4me1','H3K4me3','H3K27ac','H3K27me3'). For the feature ChromHMM, you also need to specify HMM_model and chrom_state.

Example (as shown in run_epicompare.R):
feature='ChromHMM' #select an epigenomic feature from the features given in feature_all above
HMM_model='18_model' #select '15_model' or '18_model' ChromHMM
chrom_state='enhancer' #select 'enhancer' or 'promoter' state from ChromHMM model

c. method: specify the method chosen using 'cutoff', 'fisher' or 'cluster' which represents Frequency cutoff, Fisher's exact test and k-means clustering. Also specify associated paramters.

Example (as shown in run_epicompare.R):
method='cutoff' #select 'cutoff', 'fisher' or 'cluster'
#parameters for frequency cutoff method
foreCutoff=0.8 #foreground cutoff
backCutoff=0.2 #background cutoff
#paramters for fisher's exact test
fisherCutoff=0.01 #q-value cutoff
parallel_core=10 #number of cores to use
#parameters for clustering method
cluster_num=140 #select number of clusters from '140','90','200',or '250'
clusterQuantile=100 #For a selected cluster, the median of feature densities of foreground samples in this cluster are no less than 100% (default) percentile of the feature densities of background samples.
clusterCutoff=0.4 #For a selected cluster, the median of feature densities of foreground samples in this cluster are no less than 0.4 (default).

d. files: specify users' data folder, output folder to store all processed data, file name for identified regions. All these folders and files should be in Command_Line_EpiCompare folder.

Example (as shown in run_epicompare.R):  
user_data='True' #whether users use their own data
userdir='user_data' #specify the directory of userdata
outdir='brain_enh'  #specify the directory where intermediate data and final output are saved 
outfile_name='brain_enhancer_cutoff' #provide file name to save identified regions


###############  Part 2: identify regions ####################
Below is the step of this part:
a. get Roadmap data for selected feature
b. get coordinate file for selected feature
c. change the current working directory to specified output folder
d. If user_data is True, process user's data and combine them with roadmap data
e. identify regions using selected method
f. write final data into specified file name and sort the file


###############  Part 3: Validate identified regions ####################
Below is the step of this part:
a.plot enrichment of H3K27ac peaks for identified regions and save the enrichment values into a file
b.plot ctm distribution on H3K27ac for identified regions and save the enrichment values into a file