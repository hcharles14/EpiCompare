library(shiny)
library(ggplot2)
require(data.table)
source('help.R')
options(shiny.maxRequestSize=1000*1024^2)

server<-function(input, output,session) {  
	#select all button for chromHMM15
    observe({
        if (input$selectAll > 0) {
            if (input$selectAll %% 2 == 1){
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E054","E053","E125"))
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E028","E119"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c("E002","E008","E001","E015","E014","E016","E003","E024"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E009","E010","E013","E012","E011","E004","E005","E006"))
				updateCheckboxGroupInput(session=session, inputId="Fat_Culture", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c("E025","E023"))
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E018","E021","E022"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E052","E120","E121"))
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E057","E058","E126","E127"))
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E035","E051","E050","E036","E032","E046","E030","E124"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))
				updateCheckboxGroupInput(session=session, inputId="Breast_Adult", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c("E027"))
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c("E078","E077"))
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c("E111","E110","E094"))
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult", choices=list("E066 Liver" ="E066"), selected= c("E066"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult", choices=list("E096 Lung" ="E096"), selected= c("E096"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c("E100","E108","E107"))
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult", choices=list("E097 Ovary" ="E097"), selected= c("E097"))
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult", choices=list("E113 Spleen" ="E113"), selected= c("E113"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult", choices=list("E112 Thymus" ="E112"), selected= c("E112"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult", choices=list("E065 Aorta" ="E065"), selected= c("E065"))
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))
				updateCheckboxGroupInput(session=session, inputId="Blood_Fetal", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c("E033","E031"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Fetal", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c("E070","E082","E081"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))
				updateCheckboxGroupInput(session=session, inputId="Heart_Fetal", choices=list("E083 Fetal Heart" ="E083"), selected= c("E083"))
				updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal", choices=list("E086 Fetal Kidney" ="E086"), selected= c("E086"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Fetal", choices=list("E088 Fetal Lung" ="E088"), selected= c("E088"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))                                                                          
			}
			else {
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Fat_Culture", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Breast_Adult", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult", choices=list("E063 Adipose Nuclei" ="E063"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult", choices=list("E079 Esophagus" ="E079"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult", choices=list("E109 Small Intestine" ="E109"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult", choices=list("E066 Liver" ="E066"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult", choices=list("E096 Lung" ="E096"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult", choices=list("E097 Ovary" ="E097"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult", choices=list("E113 Spleen" ="E113"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult", choices=list("E112 Thymus" ="E112"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult", choices=list("E065 Aorta" ="E065"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_Fetal", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Fetal", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal", choices=list("E092 Fetal Stomach" ="E092"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Heart_Fetal", choices=list("E083 Fetal Heart" ="E083"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal", choices=list("E086 Fetal Kidney" ="E086"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Fetal", choices=list("E088 Fetal Lung" ="E088"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal", choices=list("E093 Fetal Thymus" ="E093"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c())                                         
			}
		}
	})


	#select all button for each tissue for ChromHMM15
    observe({ 
        if (input$select_Blood_Culture > 0) { 
          if (input$select_Blood_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Culture", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Culture", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c()) }} })
    observe({ 
        if (input$select_Bone_Culture > 0) { 
          if (input$select_Bone_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Bone_Culture", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Bone_Culture", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Culture > 0) { 
          if (input$select_Brain_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Culture", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E054","E053","E125"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Culture", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c()) }} })
    observe({ 
        if (input$select_Breast_Culture > 0) { 
          if (input$select_Breast_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Breast_Culture", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E028","E119"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Breast_Culture", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Culture > 0) { 
          if (input$select_ESC_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Culture", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c("E002","E008","E001","E015","E014","E016","E003","E024"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Culture", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Derived_Culture > 0) { 
          if (input$select_ESC_Derived_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E009","E010","E013","E012","E011","E004","E005","E006"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c()) }} })
    observe({ 
        if (input$select_Fat_Culture > 0) { 
          if (input$select_Fat_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Fat_Culture", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c("E025","E023"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Fat_Culture", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c()) }} })
    observe({ 
        if (input$select_IPSC_Culture > 0) { 
          if (input$select_IPSC_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="IPSC_Culture", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E018","E021","E022"))} 
          else { updateCheckboxGroupInput(session=session, inputId="IPSC_Culture", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Culture > 0) { 
          if (input$select_Lung_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Culture", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Culture", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Culture > 0) { 
          if (input$select_Muscle_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Culture", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E052","E120","E121"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Culture", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c()) }} })
    observe({ 
        if (input$select_Skin_Culture > 0) { 
          if (input$select_Skin_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Skin_Culture", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E057","E058","E126","E127"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Skin_Culture", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c()) }} })
    observe({ 
        if (input$select_Stromal_Connective_Culture > 0) { 
          if (input$select_Stromal_Connective_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Culture > 0) { 
          if (input$select_Vascular_Culture %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Culture", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Culture", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_Adult > 0) { 
          if (input$select_Blood_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Adult", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E035","E051","E050","E036","E032","E046","E030","E124"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Adult", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Adult > 0) { 
          if (input$select_Brain_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Adult", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Adult", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c()) }} })
    observe({ 
        if (input$select_Breast_Adult > 0) { 
          if (input$select_Breast_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Breast_Adult", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c("E027"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Breast_Adult", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c()) }} })
    observe({ 
        if (input$select_Fat_Adult > 0) { 
          if (input$select_Fat_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Fat_Adult", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Fat_Adult", choices=list("E063 Adipose Nuclei" ="E063"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Colon_Adult > 0) { 
          if (input$select_GI_Colon_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Duodenum_Adult > 0) { 
          if (input$select_GI_Duodenum_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c("E078","E077"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Esophagus_Adult > 0) { 
          if (input$select_GI_Esophagus_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult", choices=list("E079 Esophagus" ="E079"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Adult > 0) { 
          if (input$select_GI_Intestine_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult", choices=list("E109 Small Intestine" ="E109"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Rectum_Adult > 0) { 
          if (input$select_GI_Rectum_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Adult > 0) { 
          if (input$select_GI_Stomach_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c("E111","E110","E094"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c()) }} })
    observe({ 
        if (input$select_Heart_Adult > 0) { 
          if (input$select_Heart_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Heart_Adult", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Heart_Adult", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_Adult > 0) { 
          if (input$select_Liver_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_Adult", choices=list("E066 Liver" ="E066"), selected= c("E066"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_Adult", choices=list("E066 Liver" ="E066"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Adult > 0) { 
          if (input$select_Lung_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Adult", choices=list("E096 Lung" ="E096"), selected= c("E096"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Adult", choices=list("E096 Lung" ="E096"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Adult > 0) { 
          if (input$select_Muscle_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Adult", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c("E100","E108","E107"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Adult", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c()) }} })
    observe({ 
        if (input$select_Ovary_Adult > 0) { 
          if (input$select_Ovary_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Ovary_Adult", choices=list("E097 Ovary" ="E097"), selected= c("E097"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Ovary_Adult", choices=list("E097 Ovary" ="E097"), selected= c()) }} })
    observe({ 
        if (input$select_Pancreas_Adult > 0) { 
          if (input$select_Pancreas_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c()) }} })
    observe({ 
        if (input$select_Spleen_Adult > 0) { 
          if (input$select_Spleen_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Spleen_Adult", choices=list("E113 Spleen" ="E113"), selected= c("E113"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Spleen_Adult", choices=list("E113 Spleen" ="E113"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Adult > 0) { 
          if (input$select_Thymus_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Adult", choices=list("E112 Thymus" ="E112"), selected= c("E112"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Adult", choices=list("E112 Thymus" ="E112"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Adult > 0) { 
          if (input$select_Vascular_Adult %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Adult", choices=list("E065 Aorta" ="E065"), selected= c("E065"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Adult", choices=list("E065 Aorta" ="E065"), selected= c()) }} })
    observe({ 
        if (input$select_Adrenal_Fetal > 0) { 
          if (input$select_Adrenal_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_Fetal > 0) { 
          if (input$select_Blood_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Fetal", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c("E033","E031"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Fetal", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Fetal > 0) { 
          if (input$select_Brain_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Fetal", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c("E070","E082","E081"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Fetal", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Fetal > 0) { 
          if (input$select_GI_Intestine_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Fetal > 0) { 
          if (input$select_GI_Stomach_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal", choices=list("E092 Fetal Stomach" ="E092"), selected= c()) }} })
    observe({ 
        if (input$select_Heart_Fetal > 0) { 
          if (input$select_Heart_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Heart_Fetal", choices=list("E083 Fetal Heart" ="E083"), selected= c("E083"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Heart_Fetal", choices=list("E083 Fetal Heart" ="E083"), selected= c()) }} })
    observe({ 
        if (input$select_Kidney_Fetal > 0) { 
          if (input$select_Kidney_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal", choices=list("E086 Fetal Kidney" ="E086"), selected= c("E086"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal", choices=list("E086 Fetal Kidney" ="E086"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Fetal > 0) { 
          if (input$select_Lung_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Fetal", choices=list("E088 Fetal Lung" ="E088"), selected= c("E088"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Fetal", choices=list("E088 Fetal Lung" ="E088"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Fetal > 0) { 
          if (input$select_Muscle_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c()) }} })
    observe({ 
        if (input$select_Placenta_Fetal > 0) { 
          if (input$select_Placenta_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Fetal > 0) { 
          if (input$select_Thymus_Fetal %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal", choices=list("E093 Fetal Thymus" ="E093"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_CellLine > 0) { 
          if (input$select_Blood_CellLine %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_CellLine", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_CellLine", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c()) }} })
    observe({ 
        if (input$select_Cervix_CellLine > 0) { 
          if (input$select_Cervix_CellLine %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_CellLine > 0) { 
          if (input$select_Liver_CellLine %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_CellLine", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_CellLine", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_CellLine > 0) { 
          if (input$select_Lung_CellLine %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_CellLine", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_CellLine", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c()) }} })


	#update all selection for chromHMM18 model
    observe({
        if (input$selectAll_18 > 0) {
          	if (input$selectAll_18 %% 2 == 1){
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture_18", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture_18", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture_18", choices=list("E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E125"))
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture_18", choices=list("E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E119"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture_18", choices=list("E008 H9 Cells" ="E008","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003"), selected= c("E008","E015","E014","E016","E003"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_18", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E013","E012","E011","E004","E005","E006"))
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_18", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E021","E022"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture_18", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_18", choices=list("E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E120","E121"))
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture_18", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E058","E126","E127"))
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_18", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_18", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult_18", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E050","E032","E046","E124"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult_18", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult_18", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_18", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_18", choices=list("E078 Duodenum Smooth Muscle" ="E078"), selected= c("E078"))
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_18", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_18", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_18", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_18", choices=list("E111 Stomach Smooth Muscle" ="E111","E094 Gastric" ="E094"), selected= c("E111","E094"))
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult_18", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult_18", choices=list("E066 Liver" ="E066"), selected= c("E066"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult_18", choices=list("E096 Lung" ="E096"), selected= c("E096"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_18", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108"), selected= c("E100","E108"))
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_18", choices=list("E097 Ovary" ="E097"), selected= c("E097"))
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_18", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_18", choices=list("E113 Spleen" ="E113"), selected= c("E113"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_18", choices=list("E112 Thymus" ="E112"), selected= c("E112"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_18", choices=list("E065 Aorta" ="E065"), selected= c("E065"))
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_18", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_18", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c("E070","E082","E081"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_18", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_18", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_18", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_18", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_18", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_18", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_18", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_18", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_18", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))                                                                          
			}
			else {
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture_18", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture_18", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture_18", choices=list("E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture_18", choices=list("E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture_18", choices=list("E008 H9 Cells" ="E008","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_18", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_18", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture_18", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_18", choices=list("E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture_18", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_18", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_18", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult_18", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult_18", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult_18", choices=list("E063 Adipose Nuclei" ="E063"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_18", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_18", choices=list("E078 Duodenum Smooth Muscle" ="E078"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_18", choices=list("E079 Esophagus" ="E079"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_18", choices=list("E109 Small Intestine" ="E109"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_18", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_18", choices=list("E111 Stomach Smooth Muscle" ="E111","E094 Gastric" ="E094"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult_18", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult_18", choices=list("E066 Liver" ="E066"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult_18", choices=list("E096 Lung" ="E096"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_18", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_18", choices=list("E097 Ovary" ="E097"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_18", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_18", choices=list("E113 Spleen" ="E113"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_18", choices=list("E112 Thymus" ="E112"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_18", choices=list("E065 Aorta" ="E065"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_18", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_18", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_18", choices=list("E092 Fetal Stomach" ="E092"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_18", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_18", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_18", choices=list("E093 Fetal Thymus" ="E093"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_18", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_18", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_18", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_18", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c())                                         
            }
        }
    })


    #select all button for each tissue for ChromHMM18
    observe({ 
        if (input$select_Blood_Culture_18 > 0) { 
          if (input$select_Blood_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Culture_18", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Culture_18", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c()) }} })
    observe({ 
        if (input$select_Bone_Culture_18 > 0) { 
          if (input$select_Bone_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Bone_Culture_18", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Bone_Culture_18", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Culture_18 > 0) { 
          if (input$select_Brain_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Culture_18", choices=list("E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E125"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Culture_18", choices=list("E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c()) }} })
    observe({ 
        if (input$select_Breast_Culture_18 > 0) { 
          if (input$select_Breast_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Breast_Culture_18", choices=list("E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E119"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Breast_Culture_18", choices=list("E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Culture_18 > 0) { 
          if (input$select_ESC_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Culture_18", choices=list("E008 H9 Cells" ="E008","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003"), selected= c("E008","E015","E014","E016","E003"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Culture_18", choices=list("E008 H9 Cells" ="E008","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Derived_Culture_18 > 0) { 
          if (input$select_ESC_Derived_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_18", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E013","E012","E011","E004","E005","E006"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_18", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c()) }} })
    observe({ 
        if (input$select_IPSC_Culture_18 > 0) { 
          if (input$select_IPSC_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_18", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E021","E022"))} 
          else { updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_18", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Culture_18 > 0) { 
          if (input$select_Lung_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Culture_18", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Culture_18", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Culture_18 > 0) { 
          if (input$select_Muscle_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_18", choices=list("E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E120","E121"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_18", choices=list("E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c()) }} })
    observe({ 
        if (input$select_Skin_Culture_18 > 0) { 
          if (input$select_Skin_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Skin_Culture_18", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E058","E126","E127"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Skin_Culture_18", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c()) }} })
    observe({ 
        if (input$select_Stromal_Connective_Culture_18 > 0) { 
          if (input$select_Stromal_Connective_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_18", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_18", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Culture_18 > 0) { 
          if (input$select_Vascular_Culture_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_18", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_18", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_Adult_18 > 0) { 
          if (input$select_Blood_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Adult_18", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E050","E032","E046","E124"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Adult_18", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Adult_18 > 0) { 
          if (input$select_Brain_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Adult_18", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Adult_18", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c()) }} })
    observe({ 
        if (input$select_Fat_Adult_18 > 0) { 
          if (input$select_Fat_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Fat_Adult_18", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Fat_Adult_18", choices=list("E063 Adipose Nuclei" ="E063"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Colon_Adult_18 > 0) { 
          if (input$select_GI_Colon_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_18", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_18", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Duodenum_Adult_18 > 0) { 
          if (input$select_GI_Duodenum_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_18", choices=list("E078 Duodenum Smooth Muscle" ="E078"), selected= c("E078"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_18", choices=list("E078 Duodenum Smooth Muscle" ="E078"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Esophagus_Adult_18 > 0) { 
          if (input$select_GI_Esophagus_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_18", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_18", choices=list("E079 Esophagus" ="E079"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Adult_18 > 0) { 
          if (input$select_GI_Intestine_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_18", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_18", choices=list("E109 Small Intestine" ="E109"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Rectum_Adult_18 > 0) { 
          if (input$select_GI_Rectum_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_18", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_18", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Adult_18 > 0) { 
          if (input$select_GI_Stomach_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_18", choices=list("E111 Stomach Smooth Muscle" ="E111","E094 Gastric" ="E094"), selected= c("E111","E094"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_18", choices=list("E111 Stomach Smooth Muscle" ="E111","E094 Gastric" ="E094"), selected= c()) }} })
    observe({ 
        if (input$select_Heart_Adult_18 > 0) { 
          if (input$select_Heart_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Heart_Adult_18", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Heart_Adult_18", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_Adult_18 > 0) { 
          if (input$select_Liver_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_Adult_18", choices=list("E066 Liver" ="E066"), selected= c("E066"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_Adult_18", choices=list("E066 Liver" ="E066"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Adult_18 > 0) { 
          if (input$select_Lung_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Adult_18", choices=list("E096 Lung" ="E096"), selected= c("E096"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Adult_18", choices=list("E096 Lung" ="E096"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Adult_18 > 0) { 
          if (input$select_Muscle_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_18", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108"), selected= c("E100","E108"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_18", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108"), selected= c()) }} })
    observe({ 
        if (input$select_Ovary_Adult_18 > 0) { 
          if (input$select_Ovary_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_18", choices=list("E097 Ovary" ="E097"), selected= c("E097"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_18", choices=list("E097 Ovary" ="E097"), selected= c()) }} })
    observe({ 
        if (input$select_Pancreas_Adult_18 > 0) { 
          if (input$select_Pancreas_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_18", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_18", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c()) }} })
    observe({ 
        if (input$select_Spleen_Adult_18 > 0) { 
          if (input$select_Spleen_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_18", choices=list("E113 Spleen" ="E113"), selected= c("E113"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_18", choices=list("E113 Spleen" ="E113"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Adult_18 > 0) { 
          if (input$select_Thymus_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_18", choices=list("E112 Thymus" ="E112"), selected= c("E112"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_18", choices=list("E112 Thymus" ="E112"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Adult_18 > 0) { 
          if (input$select_Vascular_Adult_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_18", choices=list("E065 Aorta" ="E065"), selected= c("E065"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_18", choices=list("E065 Aorta" ="E065"), selected= c()) }} })
    observe({ 
        if (input$select_Adrenal_Fetal_18 > 0) { 
          if (input$select_Adrenal_Fetal_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_18", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_18", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Fetal_18 > 0) { 
          if (input$select_GI_Intestine_Fetal_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_18", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_18", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Fetal_18 > 0) { 
          if (input$select_GI_Stomach_Fetal_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_18", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_18", choices=list("E092 Fetal Stomach" ="E092"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Fetal_18 > 0) { 
          if (input$select_Muscle_Fetal_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_18", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_18", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c()) }} })
    observe({ 
        if (input$select_Placenta_Fetal_18 > 0) { 
          if (input$select_Placenta_Fetal_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_18", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_18", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Fetal_18 > 0) { 
          if (input$select_Thymus_Fetal_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_18", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_18", choices=list("E093 Fetal Thymus" ="E093"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_CellLine_18 > 0) { 
          if (input$select_Blood_CellLine_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_18", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_18", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c()) }} })
    observe({ 
        if (input$select_Cervix_CellLine_18 > 0) { 
          if (input$select_Cervix_CellLine_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_18", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_18", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_CellLine_18 > 0) { 
          if (input$select_Liver_CellLine_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_18", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_18", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_CellLine_18 > 0) { 
          if (input$select_Lung_CellLine_18 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_18", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_18", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c()) }} })


	#update all selection for H3K27ac feature
    observe({
        if (input$selectAll_H3K27ac > 0) {
          	if (input$selectAll_H3K27ac %% 2 == 1){
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K27ac", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K27ac", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K27ac", choices=list("E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E125"))
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K27ac", choices=list("E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E119"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K27ac", choices=list("E008 H9 Cells" ="E008","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003"), selected= c("E008","E015","E014","E016","E003"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K27ac", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E013","E012","E011","E004","E005","E006"))
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K27ac", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E021","E022"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K27ac", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K27ac", choices=list("E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E120","E121"))
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K27ac", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E058","E126","E127"))
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K27ac", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K27ac", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K27ac", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E050","E032","E046","E124"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K27ac", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K27ac", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K27ac", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K27ac", choices=list("E078 Duodenum Smooth Muscle" ="E078"), selected= c("E078"))
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K27ac", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K27ac", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K27ac", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K27ac", choices=list("E111 Stomach Smooth Muscle" ="E111","E094 Gastric" ="E094"), selected= c("E111","E094"))
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K27ac", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K27ac", choices=list("E066 Liver" ="E066"), selected= c("E066"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K27ac", choices=list("E096 Lung" ="E096"), selected= c("E096"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K27ac", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108"), selected= c("E100","E108"))
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K27ac", choices=list("E097 Ovary" ="E097"), selected= c("E097"))
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K27ac", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K27ac", choices=list("E113 Spleen" ="E113"), selected= c("E113"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K27ac", choices=list("E112 Thymus" ="E112"), selected= c("E112"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K27ac", choices=list("E065 Aorta" ="E065"), selected= c("E065"))
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K27ac", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K27ac", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c("E070","E082","E081"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K27ac", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K27ac", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K27ac", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K27ac", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K27ac", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K27ac", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K27ac", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K27ac", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K27ac", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))                                                                          
			}
			else {
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K27ac", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K27ac", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K27ac", choices=list("E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K27ac", choices=list("E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K27ac", choices=list("E008 H9 Cells" ="E008","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K27ac", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K27ac", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K27ac", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K27ac", choices=list("E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K27ac", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K27ac", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K27ac", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K27ac", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K27ac", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K27ac", choices=list("E063 Adipose Nuclei" ="E063"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K27ac", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K27ac", choices=list("E078 Duodenum Smooth Muscle" ="E078"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K27ac", choices=list("E079 Esophagus" ="E079"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K27ac", choices=list("E109 Small Intestine" ="E109"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K27ac", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K27ac", choices=list("E111 Stomach Smooth Muscle" ="E111","E094 Gastric" ="E094"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K27ac", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K27ac", choices=list("E066 Liver" ="E066"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K27ac", choices=list("E096 Lung" ="E096"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K27ac", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K27ac", choices=list("E097 Ovary" ="E097"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K27ac", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K27ac", choices=list("E113 Spleen" ="E113"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K27ac", choices=list("E112 Thymus" ="E112"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K27ac", choices=list("E065 Aorta" ="E065"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K27ac", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K27ac", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K27ac", choices=list("E092 Fetal Stomach" ="E092"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K27ac", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K27ac", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K27ac", choices=list("E093 Fetal Thymus" ="E093"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K27ac", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K27ac", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K27ac", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K27ac", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c())                                         
			}
		}
	})


	#select all button for each tissue for H3k27ac feature
    observe({ 
        if (input$select_Blood_Culture_H3K27ac > 0) { 
          if (input$select_Blood_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K27ac", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K27ac", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c()) }} })
    observe({ 
        if (input$select_Bone_Culture_H3K27ac > 0) { 
          if (input$select_Bone_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K27ac", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K27ac", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Culture_H3K27ac > 0) { 
          if (input$select_Brain_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K27ac", choices=list("E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E125"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K27ac", choices=list("E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c()) }} })
    observe({ 
        if (input$select_Breast_Culture_H3K27ac > 0) { 
          if (input$select_Breast_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K27ac", choices=list("E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E119"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K27ac", choices=list("E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Culture_H3K27ac > 0) { 
          if (input$select_ESC_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K27ac", choices=list("E008 H9 Cells" ="E008","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003"), selected= c("E008","E015","E014","E016","E003"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K27ac", choices=list("E008 H9 Cells" ="E008","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Derived_Culture_H3K27ac > 0) { 
          if (input$select_ESC_Derived_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K27ac", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E013","E012","E011","E004","E005","E006"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K27ac", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c()) }} })
    observe({ 
        if (input$select_IPSC_Culture_H3K27ac > 0) { 
          if (input$select_IPSC_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K27ac", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E021","E022"))} 
          else { updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K27ac", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Culture_H3K27ac > 0) { 
          if (input$select_Lung_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K27ac", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K27ac", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Culture_H3K27ac > 0) { 
          if (input$select_Muscle_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K27ac", choices=list("E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E120","E121"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K27ac", choices=list("E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c()) }} })
    observe({ 
        if (input$select_Skin_Culture_H3K27ac > 0) { 
          if (input$select_Skin_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K27ac", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E058","E126","E127"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K27ac", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c()) }} })
    observe({ 
        if (input$select_Stromal_Connective_Culture_H3K27ac > 0) { 
          if (input$select_Stromal_Connective_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K27ac", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K27ac", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Culture_H3K27ac > 0) { 
          if (input$select_Vascular_Culture_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K27ac", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K27ac", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_Adult_H3K27ac > 0) { 
          if (input$select_Blood_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K27ac", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E050","E032","E046","E124"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K27ac", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Adult_H3K27ac > 0) { 
          if (input$select_Brain_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K27ac", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K27ac", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c()) }} })
    observe({ 
        if (input$select_Fat_Adult_H3K27ac > 0) { 
          if (input$select_Fat_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K27ac", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K27ac", choices=list("E063 Adipose Nuclei" ="E063"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Colon_Adult_H3K27ac > 0) { 
          if (input$select_GI_Colon_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K27ac", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K27ac", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Duodenum_Adult_H3K27ac > 0) { 
          if (input$select_GI_Duodenum_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K27ac", choices=list("E078 Duodenum Smooth Muscle" ="E078"), selected= c("E078"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K27ac", choices=list("E078 Duodenum Smooth Muscle" ="E078"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Esophagus_Adult_H3K27ac > 0) { 
          if (input$select_GI_Esophagus_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K27ac", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K27ac", choices=list("E079 Esophagus" ="E079"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Adult_H3K27ac > 0) { 
          if (input$select_GI_Intestine_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K27ac", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K27ac", choices=list("E109 Small Intestine" ="E109"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Rectum_Adult_H3K27ac > 0) { 
          if (input$select_GI_Rectum_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K27ac", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K27ac", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Adult_H3K27ac > 0) { 
          if (input$select_GI_Stomach_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K27ac", choices=list("E111 Stomach Smooth Muscle" ="E111","E094 Gastric" ="E094"), selected= c("E111","E094"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K27ac", choices=list("E111 Stomach Smooth Muscle" ="E111","E094 Gastric" ="E094"), selected= c()) }} })
    observe({ 
        if (input$select_Heart_Adult_H3K27ac > 0) { 
          if (input$select_Heart_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K27ac", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K27ac", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_Adult_H3K27ac > 0) { 
          if (input$select_Liver_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K27ac", choices=list("E066 Liver" ="E066"), selected= c("E066"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K27ac", choices=list("E066 Liver" ="E066"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Adult_H3K27ac > 0) { 
          if (input$select_Lung_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K27ac", choices=list("E096 Lung" ="E096"), selected= c("E096"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K27ac", choices=list("E096 Lung" ="E096"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Adult_H3K27ac > 0) { 
          if (input$select_Muscle_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K27ac", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108"), selected= c("E100","E108"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K27ac", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108"), selected= c()) }} })
    observe({ 
        if (input$select_Ovary_Adult_H3K27ac > 0) { 
          if (input$select_Ovary_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K27ac", choices=list("E097 Ovary" ="E097"), selected= c("E097"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K27ac", choices=list("E097 Ovary" ="E097"), selected= c()) }} })
    observe({ 
        if (input$select_Pancreas_Adult_H3K27ac > 0) { 
          if (input$select_Pancreas_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K27ac", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K27ac", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c()) }} })
    observe({ 
        if (input$select_Spleen_Adult_H3K27ac > 0) { 
          if (input$select_Spleen_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K27ac", choices=list("E113 Spleen" ="E113"), selected= c("E113"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K27ac", choices=list("E113 Spleen" ="E113"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Adult_H3K27ac > 0) { 
          if (input$select_Thymus_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K27ac", choices=list("E112 Thymus" ="E112"), selected= c("E112"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K27ac", choices=list("E112 Thymus" ="E112"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Adult_H3K27ac > 0) { 
          if (input$select_Vascular_Adult_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K27ac", choices=list("E065 Aorta" ="E065"), selected= c("E065"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K27ac", choices=list("E065 Aorta" ="E065"), selected= c()) }} })
    observe({ 
        if (input$select_Adrenal_Fetal_H3K27ac > 0) { 
          if (input$select_Adrenal_Fetal_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K27ac", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K27ac", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Fetal_H3K27ac > 0) { 
          if (input$select_GI_Intestine_Fetal_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K27ac", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K27ac", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Fetal_H3K27ac > 0) { 
          if (input$select_GI_Stomach_Fetal_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K27ac", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K27ac", choices=list("E092 Fetal Stomach" ="E092"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Fetal_H3K27ac > 0) { 
          if (input$select_Muscle_Fetal_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K27ac", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K27ac", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c()) }} })
    observe({ 
        if (input$select_Placenta_Fetal_H3K27ac > 0) { 
          if (input$select_Placenta_Fetal_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K27ac", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K27ac", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Fetal_H3K27ac > 0) { 
          if (input$select_Thymus_Fetal_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K27ac", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K27ac", choices=list("E093 Fetal Thymus" ="E093"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_CellLine_H3K27ac > 0) { 
          if (input$select_Blood_CellLine_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K27ac", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K27ac", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c()) }} })
    observe({ 
        if (input$select_Cervix_CellLine_H3K27ac > 0) { 
          if (input$select_Cervix_CellLine_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K27ac", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K27ac", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_CellLine_H3K27ac > 0) { 
          if (input$select_Liver_CellLine_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K27ac", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K27ac", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_CellLine_H3K27ac > 0) { 
          if (input$select_Lung_CellLine_H3K27ac %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K27ac", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K27ac", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c()) }} })


	#select all button for H3K4me1
    observe({
        if (input$selectAll_H3K4me1 > 0) {
          	if (input$selectAll_H3K4me1 %% 2 == 1){
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K4me1", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K4me1", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K4me1", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E054","E053","E125"))
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K4me1", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E028","E119"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K4me1", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c("E002","E008","E001","E015","E014","E016","E003","E024"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K4me1", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E009","E010","E013","E012","E011","E004","E005","E006"))
				updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K4me1", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c("E025","E023"))
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K4me1", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E018","E021","E022"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K4me1", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K4me1", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E052","E120","E121"))
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K4me1", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E057","E058","E126","E127"))
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K4me1", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K4me1", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K4me1", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E035","E051","E050","E036","E032","E046","E030","E124"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K4me1", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))
				updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K4me1", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c("E027"))
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K4me1", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K4me1", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K4me1", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c("E078","E077"))
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K4me1", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K4me1", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K4me1", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K4me1", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c("E111","E110","E094"))
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K4me1", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K4me1", choices=list("E066 Liver" ="E066"), selected= c("E066"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K4me1", choices=list("E096 Lung" ="E096"), selected= c("E096"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K4me1", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c("E100","E108","E107"))
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K4me1", choices=list("E097 Ovary" ="E097"), selected= c("E097"))
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K4me1", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K4me1", choices=list("E113 Spleen" ="E113"), selected= c("E113"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K4me1", choices=list("E112 Thymus" ="E112"), selected= c("E112"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K4me1", choices=list("E065 Aorta" ="E065"), selected= c("E065"))
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K4me1", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))
				updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K4me1", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c("E033","E031"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K4me1", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c("E070","E082","E081"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K4me1", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K4me1", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))
				updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K4me1", choices=list("E083 Fetal Heart" ="E083"), selected= c("E083"))
				updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K4me1", choices=list("E086 Fetal Kidney" ="E086"), selected= c("E086"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K4me1", choices=list("E088 Fetal Lung" ="E088"), selected= c("E088"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K4me1", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K4me1", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K4me1", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K4me1", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K4me1", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K4me1", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K4me1", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))                                                                          
			}
			else {
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K4me1", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K4me1", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K4me1", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K4me1", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K4me1", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K4me1", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K4me1", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K4me1", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K4me1", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K4me1", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K4me1", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K4me1", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K4me1", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K4me1", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K4me1", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K4me1", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K4me1", choices=list("E063 Adipose Nuclei" ="E063"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K4me1", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K4me1", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K4me1", choices=list("E079 Esophagus" ="E079"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K4me1", choices=list("E109 Small Intestine" ="E109"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K4me1", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K4me1", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K4me1", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K4me1", choices=list("E066 Liver" ="E066"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K4me1", choices=list("E096 Lung" ="E096"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K4me1", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K4me1", choices=list("E097 Ovary" ="E097"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K4me1", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K4me1", choices=list("E113 Spleen" ="E113"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K4me1", choices=list("E112 Thymus" ="E112"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K4me1", choices=list("E065 Aorta" ="E065"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K4me1", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K4me1", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K4me1", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K4me1", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K4me1", choices=list("E092 Fetal Stomach" ="E092"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K4me1", choices=list("E083 Fetal Heart" ="E083"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K4me1", choices=list("E086 Fetal Kidney" ="E086"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K4me1", choices=list("E088 Fetal Lung" ="E088"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K4me1", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K4me1", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K4me1", choices=list("E093 Fetal Thymus" ="E093"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K4me1", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K4me1", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K4me1", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K4me1", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c())                                         
			}
		}
	})


	#select all button for each tissue for H3K4me1
    observe({ 
        if (input$select_Blood_Culture_H3K4me1 > 0) { 
          if (input$select_Blood_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K4me1", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K4me1", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c()) }} })
    observe({ 
        if (input$select_Bone_Culture_H3K4me1 > 0) { 
          if (input$select_Bone_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K4me1", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K4me1", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Culture_H3K4me1 > 0) { 
          if (input$select_Brain_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K4me1", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E054","E053","E125"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K4me1", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c()) }} })
    observe({ 
        if (input$select_Breast_Culture_H3K4me1 > 0) { 
          if (input$select_Breast_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K4me1", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E028","E119"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K4me1", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Culture_H3K4me1 > 0) { 
          if (input$select_ESC_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K4me1", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c("E002","E008","E001","E015","E014","E016","E003","E024"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K4me1", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Derived_Culture_H3K4me1 > 0) { 
          if (input$select_ESC_Derived_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K4me1", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E009","E010","E013","E012","E011","E004","E005","E006"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K4me1", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c()) }} })
    observe({ 
        if (input$select_Fat_Culture_H3K4me1 > 0) { 
          if (input$select_Fat_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K4me1", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c("E025","E023"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K4me1", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c()) }} })
    observe({ 
        if (input$select_IPSC_Culture_H3K4me1 > 0) { 
          if (input$select_IPSC_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K4me1", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E018","E021","E022"))} 
          else { updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K4me1", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Culture_H3K4me1 > 0) { 
          if (input$select_Lung_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K4me1", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K4me1", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Culture_H3K4me1 > 0) { 
          if (input$select_Muscle_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K4me1", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E052","E120","E121"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K4me1", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c()) }} })
    observe({ 
        if (input$select_Skin_Culture_H3K4me1 > 0) { 
          if (input$select_Skin_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K4me1", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E057","E058","E126","E127"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K4me1", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c()) }} })
    observe({ 
        if (input$select_Stromal_Connective_Culture_H3K4me1 > 0) { 
          if (input$select_Stromal_Connective_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K4me1", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K4me1", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Culture_H3K4me1 > 0) { 
          if (input$select_Vascular_Culture_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K4me1", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K4me1", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_Adult_H3K4me1 > 0) { 
          if (input$select_Blood_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K4me1", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E035","E051","E050","E036","E032","E046","E030","E124"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K4me1", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Adult_H3K4me1 > 0) { 
          if (input$select_Brain_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K4me1", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K4me1", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c()) }} })
    observe({ 
        if (input$select_Breast_Adult_H3K4me1 > 0) { 
          if (input$select_Breast_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K4me1", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c("E027"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K4me1", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c()) }} })
    observe({ 
        if (input$select_Fat_Adult_H3K4me1 > 0) { 
          if (input$select_Fat_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K4me1", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K4me1", choices=list("E063 Adipose Nuclei" ="E063"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Colon_Adult_H3K4me1 > 0) { 
          if (input$select_GI_Colon_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K4me1", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K4me1", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Duodenum_Adult_H3K4me1 > 0) { 
          if (input$select_GI_Duodenum_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K4me1", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c("E078","E077"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K4me1", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Esophagus_Adult_H3K4me1 > 0) { 
          if (input$select_GI_Esophagus_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K4me1", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K4me1", choices=list("E079 Esophagus" ="E079"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Adult_H3K4me1 > 0) { 
          if (input$select_GI_Intestine_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K4me1", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K4me1", choices=list("E109 Small Intestine" ="E109"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Rectum_Adult_H3K4me1 > 0) { 
          if (input$select_GI_Rectum_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K4me1", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K4me1", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Adult_H3K4me1 > 0) { 
          if (input$select_GI_Stomach_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K4me1", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c("E111","E110","E094"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K4me1", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c()) }} })
    observe({ 
        if (input$select_Heart_Adult_H3K4me1 > 0) { 
          if (input$select_Heart_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K4me1", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K4me1", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_Adult_H3K4me1 > 0) { 
          if (input$select_Liver_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K4me1", choices=list("E066 Liver" ="E066"), selected= c("E066"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K4me1", choices=list("E066 Liver" ="E066"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Adult_H3K4me1 > 0) { 
          if (input$select_Lung_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K4me1", choices=list("E096 Lung" ="E096"), selected= c("E096"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K4me1", choices=list("E096 Lung" ="E096"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Adult_H3K4me1 > 0) { 
          if (input$select_Muscle_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K4me1", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c("E100","E108","E107"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K4me1", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c()) }} })
    observe({ 
        if (input$select_Ovary_Adult_H3K4me1 > 0) { 
          if (input$select_Ovary_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K4me1", choices=list("E097 Ovary" ="E097"), selected= c("E097"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K4me1", choices=list("E097 Ovary" ="E097"), selected= c()) }} })
    observe({ 
        if (input$select_Pancreas_Adult_H3K4me1 > 0) { 
          if (input$select_Pancreas_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K4me1", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K4me1", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c()) }} })
    observe({ 
        if (input$select_Spleen_Adult_H3K4me1 > 0) { 
          if (input$select_Spleen_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K4me1", choices=list("E113 Spleen" ="E113"), selected= c("E113"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K4me1", choices=list("E113 Spleen" ="E113"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Adult_H3K4me1 > 0) { 
          if (input$select_Thymus_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K4me1", choices=list("E112 Thymus" ="E112"), selected= c("E112"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K4me1", choices=list("E112 Thymus" ="E112"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Adult_H3K4me1 > 0) { 
          if (input$select_Vascular_Adult_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K4me1", choices=list("E065 Aorta" ="E065"), selected= c("E065"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K4me1", choices=list("E065 Aorta" ="E065"), selected= c()) }} })
    observe({ 
        if (input$select_Adrenal_Fetal_H3K4me1 > 0) { 
          if (input$select_Adrenal_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K4me1", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K4me1", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_Fetal_H3K4me1 > 0) { 
          if (input$select_Blood_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K4me1", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c("E033","E031"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K4me1", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Fetal_H3K4me1 > 0) { 
          if (input$select_Brain_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K4me1", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c("E070","E082","E081"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K4me1", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Fetal_H3K4me1 > 0) { 
          if (input$select_GI_Intestine_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K4me1", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K4me1", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Fetal_H3K4me1 > 0) { 
          if (input$select_GI_Stomach_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K4me1", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K4me1", choices=list("E092 Fetal Stomach" ="E092"), selected= c()) }} })
    observe({ 
        if (input$select_Heart_Fetal_H3K4me1 > 0) { 
          if (input$select_Heart_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K4me1", choices=list("E083 Fetal Heart" ="E083"), selected= c("E083"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K4me1", choices=list("E083 Fetal Heart" ="E083"), selected= c()) }} })
    observe({ 
        if (input$select_Kidney_Fetal_H3K4me1 > 0) { 
          if (input$select_Kidney_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K4me1", choices=list("E086 Fetal Kidney" ="E086"), selected= c("E086"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K4me1", choices=list("E086 Fetal Kidney" ="E086"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Fetal_H3K4me1 > 0) { 
          if (input$select_Lung_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K4me1", choices=list("E088 Fetal Lung" ="E088"), selected= c("E088"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K4me1", choices=list("E088 Fetal Lung" ="E088"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Fetal_H3K4me1 > 0) { 
          if (input$select_Muscle_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K4me1", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K4me1", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c()) }} })
    observe({ 
        if (input$select_Placenta_Fetal_H3K4me1 > 0) { 
          if (input$select_Placenta_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K4me1", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K4me1", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Fetal_H3K4me1 > 0) { 
          if (input$select_Thymus_Fetal_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K4me1", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K4me1", choices=list("E093 Fetal Thymus" ="E093"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_CellLine_H3K4me1 > 0) { 
          if (input$select_Blood_CellLine_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K4me1", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K4me1", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c()) }} })
    observe({ 
        if (input$select_Cervix_CellLine_H3K4me1 > 0) { 
          if (input$select_Cervix_CellLine_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K4me1", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K4me1", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_CellLine_H3K4me1 > 0) { 
          if (input$select_Liver_CellLine_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K4me1", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K4me1", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_CellLine_H3K4me1 > 0) { 
          if (input$select_Lung_CellLine_H3K4me1 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K4me1", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K4me1", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c()) }} })


	#select all button for H3K4me3
    observe({
        if (input$selectAll_H3K4me3 > 0) {
          	if (input$selectAll_H3K4me3 %% 2 == 1){
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K4me3", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K4me3", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K4me3", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E054","E053","E125"))
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K4me3", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E028","E119"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K4me3", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c("E002","E008","E001","E015","E014","E016","E003","E024"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K4me3", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E009","E010","E013","E012","E011","E004","E005","E006"))
				updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K4me3", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c("E025","E023"))
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K4me3", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E018","E021","E022"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K4me3", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K4me3", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E052","E120","E121"))
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K4me3", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E057","E058","E126","E127"))
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K4me3", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K4me3", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K4me3", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E035","E051","E050","E036","E032","E046","E030","E124"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K4me3", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))
				updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K4me3", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c("E027"))
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K4me3", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K4me3", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K4me3", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c("E078","E077"))
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K4me3", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K4me3", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K4me3", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K4me3", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c("E111","E110","E094"))
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K4me3", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K4me3", choices=list("E066 Liver" ="E066"), selected= c("E066"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K4me3", choices=list("E096 Lung" ="E096"), selected= c("E096"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K4me3", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c("E100","E108","E107"))
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K4me3", choices=list("E097 Ovary" ="E097"), selected= c("E097"))
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K4me3", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K4me3", choices=list("E113 Spleen" ="E113"), selected= c("E113"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K4me3", choices=list("E112 Thymus" ="E112"), selected= c("E112"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K4me3", choices=list("E065 Aorta" ="E065"), selected= c("E065"))
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K4me3", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))
				updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K4me3", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c("E033","E031"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K4me3", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c("E070","E082","E081"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K4me3", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K4me3", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))
				updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K4me3", choices=list("E083 Fetal Heart" ="E083"), selected= c("E083"))
				updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K4me3", choices=list("E086 Fetal Kidney" ="E086"), selected= c("E086"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K4me3", choices=list("E088 Fetal Lung" ="E088"), selected= c("E088"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K4me3", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K4me3", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K4me3", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K4me3", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K4me3", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K4me3", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K4me3", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))                                                                          
			}
			else {
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K4me3", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K4me3", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K4me3", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K4me3", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K4me3", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K4me3", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K4me3", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K4me3", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K4me3", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K4me3", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K4me3", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K4me3", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K4me3", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K4me3", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K4me3", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K4me3", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K4me3", choices=list("E063 Adipose Nuclei" ="E063"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K4me3", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K4me3", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K4me3", choices=list("E079 Esophagus" ="E079"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K4me3", choices=list("E109 Small Intestine" ="E109"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K4me3", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K4me3", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K4me3", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K4me3", choices=list("E066 Liver" ="E066"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K4me3", choices=list("E096 Lung" ="E096"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K4me3", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K4me3", choices=list("E097 Ovary" ="E097"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K4me3", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K4me3", choices=list("E113 Spleen" ="E113"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K4me3", choices=list("E112 Thymus" ="E112"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K4me3", choices=list("E065 Aorta" ="E065"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K4me3", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K4me3", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K4me3", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K4me3", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K4me3", choices=list("E092 Fetal Stomach" ="E092"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K4me3", choices=list("E083 Fetal Heart" ="E083"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K4me3", choices=list("E086 Fetal Kidney" ="E086"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K4me3", choices=list("E088 Fetal Lung" ="E088"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K4me3", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K4me3", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K4me3", choices=list("E093 Fetal Thymus" ="E093"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K4me3", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K4me3", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K4me3", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K4me3", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c())                                         
			}
		}
	})


	#select all button for each tissue for H3K4me3
    observe({ 
        if (input$select_Blood_Culture_H3K4me3 > 0) { 
          if (input$select_Blood_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K4me3", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K4me3", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c()) }} })
    observe({ 
        if (input$select_Bone_Culture_H3K4me3 > 0) { 
          if (input$select_Bone_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K4me3", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K4me3", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Culture_H3K4me3 > 0) { 
          if (input$select_Brain_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K4me3", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E054","E053","E125"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K4me3", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c()) }} })
    observe({ 
        if (input$select_Breast_Culture_H3K4me3 > 0) { 
          if (input$select_Breast_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K4me3", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E028","E119"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K4me3", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Culture_H3K4me3 > 0) { 
          if (input$select_ESC_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K4me3", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c("E002","E008","E001","E015","E014","E016","E003","E024"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K4me3", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Derived_Culture_H3K4me3 > 0) { 
          if (input$select_ESC_Derived_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K4me3", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E009","E010","E013","E012","E011","E004","E005","E006"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K4me3", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c()) }} })
    observe({ 
        if (input$select_Fat_Culture_H3K4me3 > 0) { 
          if (input$select_Fat_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K4me3", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c("E025","E023"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K4me3", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c()) }} })
    observe({ 
        if (input$select_IPSC_Culture_H3K4me3 > 0) { 
          if (input$select_IPSC_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K4me3", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E018","E021","E022"))} 
          else { updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K4me3", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Culture_H3K4me3 > 0) { 
          if (input$select_Lung_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K4me3", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K4me3", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Culture_H3K4me3 > 0) { 
          if (input$select_Muscle_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K4me3", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E052","E120","E121"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K4me3", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c()) }} })
    observe({ 
        if (input$select_Skin_Culture_H3K4me3 > 0) { 
          if (input$select_Skin_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K4me3", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E057","E058","E126","E127"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K4me3", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c()) }} })
    observe({ 
        if (input$select_Stromal_Connective_Culture_H3K4me3 > 0) { 
          if (input$select_Stromal_Connective_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K4me3", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K4me3", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Culture_H3K4me3 > 0) { 
          if (input$select_Vascular_Culture_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K4me3", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K4me3", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_Adult_H3K4me3 > 0) { 
          if (input$select_Blood_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K4me3", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E035","E051","E050","E036","E032","E046","E030","E124"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K4me3", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Adult_H3K4me3 > 0) { 
          if (input$select_Brain_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K4me3", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K4me3", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c()) }} })
    observe({ 
        if (input$select_Breast_Adult_H3K4me3 > 0) { 
          if (input$select_Breast_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K4me3", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c("E027"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K4me3", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c()) }} })
    observe({ 
        if (input$select_Fat_Adult_H3K4me3 > 0) { 
          if (input$select_Fat_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K4me3", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K4me3", choices=list("E063 Adipose Nuclei" ="E063"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Colon_Adult_H3K4me3 > 0) { 
          if (input$select_GI_Colon_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K4me3", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K4me3", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Duodenum_Adult_H3K4me3 > 0) { 
          if (input$select_GI_Duodenum_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K4me3", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c("E078","E077"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K4me3", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Esophagus_Adult_H3K4me3 > 0) { 
          if (input$select_GI_Esophagus_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K4me3", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K4me3", choices=list("E079 Esophagus" ="E079"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Adult_H3K4me3 > 0) { 
          if (input$select_GI_Intestine_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K4me3", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K4me3", choices=list("E109 Small Intestine" ="E109"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Rectum_Adult_H3K4me3 > 0) { 
          if (input$select_GI_Rectum_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K4me3", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K4me3", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Adult_H3K4me3 > 0) { 
          if (input$select_GI_Stomach_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K4me3", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c("E111","E110","E094"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K4me3", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c()) }} })
    observe({ 
        if (input$select_Heart_Adult_H3K4me3 > 0) { 
          if (input$select_Heart_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K4me3", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K4me3", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_Adult_H3K4me3 > 0) { 
          if (input$select_Liver_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K4me3", choices=list("E066 Liver" ="E066"), selected= c("E066"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K4me3", choices=list("E066 Liver" ="E066"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Adult_H3K4me3 > 0) { 
          if (input$select_Lung_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K4me3", choices=list("E096 Lung" ="E096"), selected= c("E096"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K4me3", choices=list("E096 Lung" ="E096"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Adult_H3K4me3 > 0) { 
          if (input$select_Muscle_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K4me3", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c("E100","E108","E107"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K4me3", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c()) }} })
    observe({ 
        if (input$select_Ovary_Adult_H3K4me3 > 0) { 
          if (input$select_Ovary_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K4me3", choices=list("E097 Ovary" ="E097"), selected= c("E097"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K4me3", choices=list("E097 Ovary" ="E097"), selected= c()) }} })
    observe({ 
        if (input$select_Pancreas_Adult_H3K4me3 > 0) { 
          if (input$select_Pancreas_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K4me3", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K4me3", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c()) }} })
    observe({ 
        if (input$select_Spleen_Adult_H3K4me3 > 0) { 
          if (input$select_Spleen_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K4me3", choices=list("E113 Spleen" ="E113"), selected= c("E113"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K4me3", choices=list("E113 Spleen" ="E113"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Adult_H3K4me3 > 0) { 
          if (input$select_Thymus_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K4me3", choices=list("E112 Thymus" ="E112"), selected= c("E112"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K4me3", choices=list("E112 Thymus" ="E112"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Adult_H3K4me3 > 0) { 
          if (input$select_Vascular_Adult_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K4me3", choices=list("E065 Aorta" ="E065"), selected= c("E065"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K4me3", choices=list("E065 Aorta" ="E065"), selected= c()) }} })
    observe({ 
        if (input$select_Adrenal_Fetal_H3K4me3 > 0) { 
          if (input$select_Adrenal_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K4me3", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K4me3", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_Fetal_H3K4me3 > 0) { 
          if (input$select_Blood_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K4me3", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c("E033","E031"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K4me3", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Fetal_H3K4me3 > 0) { 
          if (input$select_Brain_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K4me3", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c("E070","E082","E081"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K4me3", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Fetal_H3K4me3 > 0) { 
          if (input$select_GI_Intestine_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K4me3", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K4me3", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Fetal_H3K4me3 > 0) { 
          if (input$select_GI_Stomach_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K4me3", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K4me3", choices=list("E092 Fetal Stomach" ="E092"), selected= c()) }} })
    observe({ 
        if (input$select_Heart_Fetal_H3K4me3 > 0) { 
          if (input$select_Heart_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K4me3", choices=list("E083 Fetal Heart" ="E083"), selected= c("E083"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K4me3", choices=list("E083 Fetal Heart" ="E083"), selected= c()) }} })
    observe({ 
        if (input$select_Kidney_Fetal_H3K4me3 > 0) { 
          if (input$select_Kidney_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K4me3", choices=list("E086 Fetal Kidney" ="E086"), selected= c("E086"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K4me3", choices=list("E086 Fetal Kidney" ="E086"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Fetal_H3K4me3 > 0) { 
          if (input$select_Lung_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K4me3", choices=list("E088 Fetal Lung" ="E088"), selected= c("E088"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K4me3", choices=list("E088 Fetal Lung" ="E088"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Fetal_H3K4me3 > 0) { 
          if (input$select_Muscle_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K4me3", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K4me3", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c()) }} })
    observe({ 
        if (input$select_Placenta_Fetal_H3K4me3 > 0) { 
          if (input$select_Placenta_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K4me3", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K4me3", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Fetal_H3K4me3 > 0) { 
          if (input$select_Thymus_Fetal_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K4me3", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K4me3", choices=list("E093 Fetal Thymus" ="E093"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_CellLine_H3K4me3 > 0) { 
          if (input$select_Blood_CellLine_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K4me3", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K4me3", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c()) }} })
    observe({ 
        if (input$select_Cervix_CellLine_H3K4me3 > 0) { 
          if (input$select_Cervix_CellLine_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K4me3", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K4me3", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_CellLine_H3K4me3 > 0) { 
          if (input$select_Liver_CellLine_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K4me3", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K4me3", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_CellLine_H3K4me3 > 0) { 
          if (input$select_Lung_CellLine_H3K4me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K4me3", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K4me3", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c()) }} })


	#select all button for H3K27me3
    observe({
        if (input$selectAll_H3K27me3 > 0) {
          	if (input$selectAll_H3K27me3 %% 2 == 1){
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K27me3", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K27me3", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K27me3", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E054","E053","E125"))
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K27me3", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E028","E119"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K27me3", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c("E002","E008","E001","E015","E014","E016","E003","E024"))
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K27me3", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E009","E010","E013","E012","E011","E004","E005","E006"))
				updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K27me3", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c("E025","E023"))
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K27me3", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E018","E021","E022"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K27me3", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K27me3", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E052","E120","E121"))
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K27me3", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E057","E058","E126","E127"))
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K27me3", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K27me3", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K27me3", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E035","E051","E050","E036","E032","E046","E030","E124"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K27me3", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))
				updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K27me3", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c("E027"))
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K27me3", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K27me3", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K27me3", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c("E078","E077"))
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K27me3", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K27me3", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K27me3", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K27me3", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c("E111","E110","E094"))
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K27me3", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K27me3", choices=list("E066 Liver" ="E066"), selected= c("E066"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K27me3", choices=list("E096 Lung" ="E096"), selected= c("E096"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K27me3", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c("E100","E108","E107"))
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K27me3", choices=list("E097 Ovary" ="E097"), selected= c("E097"))
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K27me3", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K27me3", choices=list("E113 Spleen" ="E113"), selected= c("E113"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K27me3", choices=list("E112 Thymus" ="E112"), selected= c("E112"))
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K27me3", choices=list("E065 Aorta" ="E065"), selected= c("E065"))
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K27me3", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))
				updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K27me3", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c("E033","E031"))
				updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K27me3", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c("E070","E082","E081"))
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K27me3", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K27me3", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))
				updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K27me3", choices=list("E083 Fetal Heart" ="E083"), selected= c("E083"))
				updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K27me3", choices=list("E086 Fetal Kidney" ="E086"), selected= c("E086"))
				updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K27me3", choices=list("E088 Fetal Lung" ="E088"), selected= c("E088"))
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K27me3", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K27me3", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K27me3", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K27me3", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K27me3", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K27me3", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K27me3", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))                                                                          
			}
			else {
				updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K27me3", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K27me3", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K27me3", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K27me3", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K27me3", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K27me3", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K27me3", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K27me3", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K27me3", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K27me3", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K27me3", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K27me3", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K27me3", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K27me3", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K27me3", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K27me3", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K27me3", choices=list("E063 Adipose Nuclei" ="E063"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K27me3", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K27me3", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K27me3", choices=list("E079 Esophagus" ="E079"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K27me3", choices=list("E109 Small Intestine" ="E109"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K27me3", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K27me3", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K27me3", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K27me3", choices=list("E066 Liver" ="E066"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K27me3", choices=list("E096 Lung" ="E096"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K27me3", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K27me3", choices=list("E097 Ovary" ="E097"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K27me3", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K27me3", choices=list("E113 Spleen" ="E113"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K27me3", choices=list("E112 Thymus" ="E112"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K27me3", choices=list("E065 Aorta" ="E065"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K27me3", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K27me3", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K27me3", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K27me3", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K27me3", choices=list("E092 Fetal Stomach" ="E092"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K27me3", choices=list("E083 Fetal Heart" ="E083"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K27me3", choices=list("E086 Fetal Kidney" ="E086"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K27me3", choices=list("E088 Fetal Lung" ="E088"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K27me3", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K27me3", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K27me3", choices=list("E093 Fetal Thymus" ="E093"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K27me3", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K27me3", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K27me3", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c())
				updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K27me3", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c())                                         
			}
		}
	})


	#select all button for each tissue for H3K27me3
    observe({ 
        if (input$select_Blood_Culture_H3K27me3 > 0) { 
          if (input$select_Blood_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K27me3", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c("E116","E123"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Culture_H3K27me3", choices=list("E116 GM12878 Lymphoblastoid Cells" ="E116","E123 K562 Leukemia Cells" ="E123"), selected= c()) }} })
    observe({ 
        if (input$select_Bone_Culture_H3K27me3 > 0) { 
          if (input$select_Bone_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K27me3", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c("E129"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Bone_Culture_H3K27me3", choices=list("E129 Osteoblast Primary Cells" ="E129"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Culture_H3K27me3 > 0) { 
          if (input$select_Brain_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K27me3", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c("E054","E053","E125"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Culture_H3K27me3", choices=list("E054 Ganglion Eminence derived primary cultured neurospheres" ="E054","E053 Cortex derived primary cultured neurospheres" ="E053","E125 NH-A Astrocytes Primary Cells" ="E125"), selected= c()) }} })
    observe({ 
        if (input$select_Breast_Culture_H3K27me3 > 0) { 
          if (input$select_Breast_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K27me3", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c("E028","E119"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Breast_Culture_H3K27me3", choices=list("E028 Breast variant Human Mammary Epithelial Cells (vHMEC)" ="E028","E119 HMEC Mammary Epithelial Primary Cells" ="E119"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Culture_H3K27me3 > 0) { 
          if (input$select_ESC_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K27me3", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c("E002","E008","E001","E015","E014","E016","E003","E024"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Culture_H3K27me3", choices=list("E002 ES-WA7 Cells" ="E002","E008 H9 Cells" ="E008","E001 ES-I3 Cells" ="E001","E015 HUES6 Cells" ="E015","E014 HUES48 Cells" ="E014","E016 HUES64 Cells" ="E016","E003 H1 Cells" ="E003","E024 ES-UCSF4  Cells" ="E024"), selected= c()) }} })
    observe({ 
        if (input$select_ESC_Derived_Culture_H3K27me3 > 0) { 
          if (input$select_ESC_Derived_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K27me3", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c("E007","E009","E010","E013","E012","E011","E004","E005","E006"))} 
          else { updateCheckboxGroupInput(session=session, inputId="ESC_Derived_Culture_H3K27me3", choices=list("E007 H1 Derived Neuronal Progenitor Cultured Cells" ="E007","E009 H9 Derived Neuronal Progenitor Cultured Cells" ="E009","E010 H9 Derived Neuron Cultured Cells" ="E010","E013 hESC Derived CD56+ Mesoderm Cultured Cells" ="E013","E012 hESC Derived CD56+ Ectoderm Cultured Cells" ="E012","E011 hESC Derived CD184+ Endoderm Cultured Cells" ="E011","E004 H1 BMP4 Derived Mesendoderm Cultured Cells" ="E004","E005 H1 BMP4 Derived Trophoblast Cultured Cells" ="E005","E006 H1 Derived Mesenchymal Stem Cells" ="E006"), selected= c()) }} })
    observe({ 
        if (input$select_Fat_Culture_H3K27me3 > 0) { 
          if (input$select_Fat_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K27me3", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c("E025","E023"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Fat_Culture_H3K27me3", choices=list("E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells" ="E025","E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells" ="E023"), selected= c()) }} })
    observe({ 
        if (input$select_IPSC_Culture_H3K27me3 > 0) { 
          if (input$select_IPSC_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K27me3", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c("E020","E019","E018","E021","E022"))} 
          else { updateCheckboxGroupInput(session=session, inputId="IPSC_Culture_H3K27me3", choices=list("E020 iPS-20b Cells" ="E020","E019 iPS-18 Cells" ="E019","E018 iPS-15b Cells" ="E018","E021 iPS DF 6.9 Cells" ="E021","E022 iPS DF 19.11 Cells" ="E022"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Culture_H3K27me3 > 0) { 
          if (input$select_Lung_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K27me3", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c("E128"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Culture_H3K27me3", choices=list("E128 NHLF Lung Fibroblast Primary Cells" ="E128"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Culture_H3K27me3 > 0) { 
          if (input$select_Muscle_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K27me3", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c("E052","E120","E121"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Culture_H3K27me3", choices=list("E052 Muscle Satellite Cultured Cells" ="E052","E120 HSMM Skeletal Muscle Myoblasts Cells" ="E120","E121 HSMM cell derived Skeletal Muscle Myotubes Cells" ="E121"), selected= c()) }} })
    observe({ 
        if (input$select_Skin_Culture_H3K27me3 > 0) { 
          if (input$select_Skin_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K27me3", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c("E055","E056","E059","E061","E057","E058","E126","E127"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Skin_Culture_H3K27me3", choices=list("E055 Foreskin Fibroblast Primary Cells skin01" ="E055","E056 Foreskin Fibroblast Primary Cells skin02" ="E056","E059 Foreskin Melanocyte Primary Cells skin01" ="E059","E061 Foreskin Melanocyte Primary Cells skin03" ="E061","E057 Foreskin Keratinocyte Primary Cells skin02" ="E057","E058 Foreskin Keratinocyte Primary Cells skin03" ="E058","E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells" ="E126","E127 NHEK-Epidermal Keratinocyte Primary Cells" ="E127"), selected= c()) }} })
    observe({ 
        if (input$select_Stromal_Connective_Culture_H3K27me3 > 0) { 
          if (input$select_Stromal_Connective_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K27me3", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c("E026","E049"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Stromal_Connective_Culture_H3K27me3", choices=list("E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells" ="E026","E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells" ="E049"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Culture_H3K27me3 > 0) { 
          if (input$select_Vascular_Culture_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K27me3", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c("E122"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Culture_H3K27me3", choices=list("E122 HUVEC Umbilical Vein Endothelial Primary Cells" ="E122"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_Adult_H3K27me3 > 0) { 
          if (input$select_Blood_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K27me3", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c("E062","E034","E045","E044","E043","E039","E041","E042","E040","E037","E048","E038","E047","E029","E035","E051","E050","E036","E032","E046","E030","E124"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Adult_H3K27me3", choices=list("E062 Primary mononuclear cells from peripheral blood" ="E062","E034 Primary T cells from peripheral blood" ="E034","E045 Primary T cells effector/memory enriched from peripheral blood" ="E045","E044 Primary T regulatory cells from peripheral blood" ="E044","E043 Primary T helper cells from peripheral blood" ="E043","E039 Primary T helper naive cells from peripheral blood" ="E039","E041 Primary T helper cells PMA-I stimulated" ="E041","E042 Primary T helper 17 cells PMA-I stimulated" ="E042","E040 Primary T helper memory cells from peripheral blood 1" ="E040","E037 Primary T helper memory cells from peripheral blood 2" ="E037","E048 Primary T CD8+ memory cells from peripheral blood" ="E048","E038 Primary T helper naive cells from peripheral blood" ="E038","E047 Primary T CD8+ naive cells from peripheral blood" ="E047","E029 Primary monocytes from peripheral blood" ="E029","E035 Primary hematopoietic stem cells" ="E035","E051 Primary hematopoietic stem cells G-CSF-mobilized Male" ="E051","E050 Primary hematopoietic stem cells G-CSF-mobilized Female" ="E050","E036 Primary hematopoietic stem cells short term culture" ="E036","E032 Primary B cells from peripheral blood" ="E032","E046 Primary Natural Killer cells from peripheral blood" ="E046","E030 Primary neutrophils from peripheral blood" ="E030","E124 Monocytes-CD14+ RO01746 Primary Cells" ="E124"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Adult_H3K27me3 > 0) { 
          if (input$select_Brain_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K27me3", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c("E071","E074","E068","E069","E072","E067","E073"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Adult_H3K27me3", choices=list("E071 Brain Hippocampus Middle" ="E071","E074 Brain Substantia Nigra" ="E074","E068 Brain Anterior Caudate" ="E068","E069 Brain Cingulate Gyrus" ="E069","E072 Brain Inferior Temporal Lobe" ="E072","E067 Brain Angular Gyrus" ="E067","E073 Brain_Dorsolateral_Prefrontal_Cortex" ="E073"), selected= c()) }} })
    observe({ 
        if (input$select_Breast_Adult_H3K27me3 > 0) { 
          if (input$select_Breast_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K27me3", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c("E027"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Breast_Adult_H3K27me3", choices=list("E027 Breast Myoepithelial Primary Cells" ="E027"), selected= c()) }} })
    observe({ 
        if (input$select_Fat_Adult_H3K27me3 > 0) { 
          if (input$select_Fat_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K27me3", choices=list("E063 Adipose Nuclei" ="E063"), selected= c("E063"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Fat_Adult_H3K27me3", choices=list("E063 Adipose Nuclei" ="E063"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Colon_Adult_H3K27me3 > 0) { 
          if (input$select_GI_Colon_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K27me3", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c("E076","E106","E075"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Colon_Adult_H3K27me3", choices=list("E076 Colon Smooth Muscle" ="E076","E106 Sigmoid Colon" ="E106","E075 Colonic Mucosa" ="E075"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Duodenum_Adult_H3K27me3 > 0) { 
          if (input$select_GI_Duodenum_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K27me3", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c("E078","E077"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Duodenum_Adult_H3K27me3", choices=list("E078 Duodenum Smooth Muscle" ="E078","E077 Duodenum Mucosa" ="E077"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Esophagus_Adult_H3K27me3 > 0) { 
          if (input$select_GI_Esophagus_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K27me3", choices=list("E079 Esophagus" ="E079"), selected= c("E079"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Esophagus_Adult_H3K27me3", choices=list("E079 Esophagus" ="E079"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Adult_H3K27me3 > 0) { 
          if (input$select_GI_Intestine_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K27me3", choices=list("E109 Small Intestine" ="E109"), selected= c("E109"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Adult_H3K27me3", choices=list("E109 Small Intestine" ="E109"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Rectum_Adult_H3K27me3 > 0) { 
          if (input$select_GI_Rectum_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K27me3", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c("E103","E101","E102"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Rectum_Adult_H3K27me3", choices=list("E103 Rectal Smooth Muscle" ="E103","E101 Rectal Mucosa Donor 29" ="E101","E102 Rectal Mucosa Donor 31" ="E102"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Adult_H3K27me3 > 0) { 
          if (input$select_GI_Stomach_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K27me3", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c("E111","E110","E094"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Adult_H3K27me3", choices=list("E111 Stomach Smooth Muscle" ="E111","E110 Stomach Mucosa" ="E110","E094 Gastric" ="E094"), selected= c()) }} })
    observe({ 
        if (input$select_Heart_Adult_H3K27me3 > 0) { 
          if (input$select_Heart_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K27me3", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c("E104","E095","E105"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Heart_Adult_H3K27me3", choices=list("E104 Right Atrium" ="E104","E095 Left Ventricle" ="E095","E105 Right Ventricle" ="E105"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_Adult_H3K27me3 > 0) { 
          if (input$select_Liver_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K27me3", choices=list("E066 Liver" ="E066"), selected= c("E066"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_Adult_H3K27me3", choices=list("E066 Liver" ="E066"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Adult_H3K27me3 > 0) { 
          if (input$select_Lung_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K27me3", choices=list("E096 Lung" ="E096"), selected= c("E096"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Adult_H3K27me3", choices=list("E096 Lung" ="E096"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Adult_H3K27me3 > 0) { 
          if (input$select_Muscle_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K27me3", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c("E100","E108","E107"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Adult_H3K27me3", choices=list("E100 Psoas Muscle" ="E100","E108 Skeletal Muscle Female" ="E108","E107 Skeletal Muscle Male" ="E107"), selected= c()) }} })
    observe({ 
        if (input$select_Ovary_Adult_H3K27me3 > 0) { 
          if (input$select_Ovary_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K27me3", choices=list("E097 Ovary" ="E097"), selected= c("E097"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Ovary_Adult_H3K27me3", choices=list("E097 Ovary" ="E097"), selected= c()) }} })
    observe({ 
        if (input$select_Pancreas_Adult_H3K27me3 > 0) { 
          if (input$select_Pancreas_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K27me3", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c("E087","E098"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Pancreas_Adult_H3K27me3", choices=list("E087 Pancreatic Islets" ="E087","E098 Pancreas" ="E098"), selected= c()) }} })
    observe({ 
        if (input$select_Spleen_Adult_H3K27me3 > 0) { 
          if (input$select_Spleen_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K27me3", choices=list("E113 Spleen" ="E113"), selected= c("E113"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Spleen_Adult_H3K27me3", choices=list("E113 Spleen" ="E113"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Adult_H3K27me3 > 0) { 
          if (input$select_Thymus_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K27me3", choices=list("E112 Thymus" ="E112"), selected= c("E112"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Adult_H3K27me3", choices=list("E112 Thymus" ="E112"), selected= c()) }} })
    observe({ 
        if (input$select_Vascular_Adult_H3K27me3 > 0) { 
          if (input$select_Vascular_Adult_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K27me3", choices=list("E065 Aorta" ="E065"), selected= c("E065"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Vascular_Adult_H3K27me3", choices=list("E065 Aorta" ="E065"), selected= c()) }} })
    observe({ 
        if (input$select_Adrenal_Fetal_H3K27me3 > 0) { 
          if (input$select_Adrenal_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K27me3", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c("E080"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Adrenal_Fetal_H3K27me3", choices=list("E080 Fetal Adrenal Gland" ="E080"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_Fetal_H3K27me3 > 0) { 
          if (input$select_Blood_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K27me3", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c("E033","E031"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_Fetal_H3K27me3", choices=list("E033 Primary T cells from cord blood" ="E033","E031 Primary B cells from cord blood" ="E031"), selected= c()) }} })
    observe({ 
        if (input$select_Brain_Fetal_H3K27me3 > 0) { 
          if (input$select_Brain_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K27me3", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c("E070","E082","E081"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Brain_Fetal_H3K27me3", choices=list("E070 Brain Germinal Matrix" ="E070","E082 Fetal Brain Female" ="E082","E081 Fetal Brain Male" ="E081"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Intestine_Fetal_H3K27me3 > 0) { 
          if (input$select_GI_Intestine_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K27me3", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c("E085","E084"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Intestine_Fetal_H3K27me3", choices=list("E085 Fetal Intestine Small" ="E085","E084 Fetal Intestine Large" ="E084"), selected= c()) }} })
    observe({ 
        if (input$select_GI_Stomach_Fetal_H3K27me3 > 0) { 
          if (input$select_GI_Stomach_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K27me3", choices=list("E092 Fetal Stomach" ="E092"), selected= c("E092"))} 
          else { updateCheckboxGroupInput(session=session, inputId="GI_Stomach_Fetal_H3K27me3", choices=list("E092 Fetal Stomach" ="E092"), selected= c()) }} })
    observe({ 
        if (input$select_Heart_Fetal_H3K27me3 > 0) { 
          if (input$select_Heart_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K27me3", choices=list("E083 Fetal Heart" ="E083"), selected= c("E083"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Heart_Fetal_H3K27me3", choices=list("E083 Fetal Heart" ="E083"), selected= c()) }} })
    observe({ 
        if (input$select_Kidney_Fetal_H3K27me3 > 0) { 
          if (input$select_Kidney_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K27me3", choices=list("E086 Fetal Kidney" ="E086"), selected= c("E086"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Kidney_Fetal_H3K27me3", choices=list("E086 Fetal Kidney" ="E086"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_Fetal_H3K27me3 > 0) { 
          if (input$select_Lung_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K27me3", choices=list("E088 Fetal Lung" ="E088"), selected= c("E088"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_Fetal_H3K27me3", choices=list("E088 Fetal Lung" ="E088"), selected= c()) }} })
    observe({ 
        if (input$select_Muscle_Fetal_H3K27me3 > 0) { 
          if (input$select_Muscle_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K27me3", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c("E089","E090"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Muscle_Fetal_H3K27me3", choices=list("E089 Fetal Muscle Trunk" ="E089","E090 Fetal Muscle Leg" ="E090"), selected= c()) }} })
    observe({ 
        if (input$select_Placenta_Fetal_H3K27me3 > 0) { 
          if (input$select_Placenta_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K27me3", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c("E099","E091"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Placenta_Fetal_H3K27me3", choices=list("E099 Placenta Amnion" ="E099","E091 Placenta" ="E091"), selected= c()) }} })
    observe({ 
        if (input$select_Thymus_Fetal_H3K27me3 > 0) { 
          if (input$select_Thymus_Fetal_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K27me3", choices=list("E093 Fetal Thymus" ="E093"), selected= c("E093"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Thymus_Fetal_H3K27me3", choices=list("E093 Fetal Thymus" ="E093"), selected= c()) }} })
    observe({ 
        if (input$select_Blood_CellLine_H3K27me3 > 0) { 
          if (input$select_Blood_CellLine_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K27me3", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c("E115"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Blood_CellLine_H3K27me3", choices=list("E115 Dnd41 TCell Leukemia Cell Line" ="E115"), selected= c()) }} })
    observe({ 
        if (input$select_Cervix_CellLine_H3K27me3 > 0) { 
          if (input$select_Cervix_CellLine_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K27me3", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c("E117"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Cervix_CellLine_H3K27me3", choices=list("E117 HeLa-S3 Cervical Carcinoma Cell Line" ="E117"), selected= c()) }} })
    observe({ 
        if (input$select_Liver_CellLine_H3K27me3 > 0) { 
          if (input$select_Liver_CellLine_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K27me3", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c("E118"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Liver_CellLine_H3K27me3", choices=list("E118 HepG2 Hepatocellular Carcinoma Cell Line" ="E118"), selected= c()) }} })
    observe({ 
        if (input$select_Lung_CellLine_H3K27me3 > 0) { 
          if (input$select_Lung_CellLine_H3K27me3 %% 2 == 1){ updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K27me3", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c("E017","E114"))} 
          else { updateCheckboxGroupInput(session=session, inputId="Lung_CellLine_H3K27me3", choices=list("E017 IMR90 fetal lung fibroblasts Cell Line" ="E017","E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line" ="E114"), selected= c()) }} })


	############################################
  	#foreground and background #
  	fore <- reactiveValues(data = NULL)
  	back <- reactiveValues(data = NULL)
  	samVis <- reactiveValues(data = NULL)


  	#select samples for visualization for different features
  	observeEvent(input$selectSampleVis_hmm,{
	    if (input$selectHMM == '15 model'){
	        samVis$data <- c(input$Blood_Culture,input$Bone_Culture,input$Brain_Culture,input$Breast_Culture,input$ESC_Culture,input$ESC_Derived_Culture,input$Fat_Culture,input$IPSC_Culture,input$Lung_Culture,input$Muscle_Culture,input$Skin_Culture,input$Stromal_Connective_Culture,input$Vascular_Culture,input$Blood_Adult,input$Brain_Adult,input$Breast_Adult,input$Fat_Adult,input$GI_Colon_Adult,input$GI_Duodenum_Adult,input$GI_Esophagus_Adult,input$GI_Intestine_Adult,input$GI_Rectum_Adult,input$GI_Stomach_Adult,input$Heart_Adult,input$Liver_Adult,input$Lung_Adult,input$Muscle_Adult,input$Ovary_Adult,input$Pancreas_Adult,input$Spleen_Adult,input$Thymus_Adult,input$Vascular_Adult,input$Adrenal_Fetal,input$Blood_Fetal,input$Brain_Fetal,input$GI_Intestine_Fetal,input$GI_Stomach_Fetal,input$Heart_Fetal,input$Kidney_Fetal,input$Lung_Fetal,input$Muscle_Fetal,input$Placenta_Fetal,input$Thymus_Fetal,input$Blood_CellLine,input$Cervix_CellLine,input$Liver_CellLine,input$Lung_CellLine)
	    }else {
	      	samVis$data <-c(input$Blood_Culture_18,input$Bone_Culture_18,input$Brain_Culture_18,input$Breast_Culture_18,input$ESC_Culture_18,input$ESC_Derived_Culture_18,input$Fat_Culture_18,input$IPSC_Culture_18,input$Lung_Culture_18,input$Muscle_Culture_18,input$Skin_Culture_18,input$Stromal_Connective_Culture_18,input$Vascular_Culture_18,input$Blood_Adult_18,input$Brain_Adult_18,input$Breast_Adult_18,input$Fat_Adult_18,input$GI_Colon_Adult_18,input$GI_Duodenum_Adult_18,input$GI_Esophagus_Adult_18,input$GI_Intestine_Adult_18,input$GI_Rectum_Adult_18,input$GI_Stomach_Adult_18,input$Heart_Adult_18,input$Liver_Adult_18,input$Lung_Adult_18,input$Muscle_Adult_18,input$Ovary_Adult_18,input$Pancreas_Adult_18,input$Spleen_Adult_18,input$Thymus_Adult_18,input$Vascular_Adult_18,input$Adrenal_Fetal_18,input$Blood_Fetal_18,input$Brain_Fetal_18,input$GI_Intestine_Fetal_18,input$GI_Stomach_Fetal_18,input$Heart_Fetal_18,input$Kidney_Fetal_18,input$Lung_Fetal_18,input$Muscle_Fetal_18,input$Placenta_Fetal_18,input$Thymus_Fetal_18,input$Blood_CellLine_18,input$Cervix_CellLine_18,input$Liver_CellLine_18,input$Lung_CellLine_18)      
	    }
	})   

  	observeEvent(input$selectSampleVis_H3K27ac,{
		samVis$data <- c(input$Blood_Culture_H3K27ac,input$Bone_Culture_H3K27ac,input$Brain_Culture_H3K27ac,input$Breast_Culture_H3K27ac,input$ESC_Culture_H3K27ac,input$ESC_Derived_Culture_H3K27ac,input$Fat_Culture_H3K27ac,input$IPSC_Culture_H3K27ac,input$Lung_Culture_H3K27ac,input$Muscle_Culture_H3K27ac,input$Skin_Culture_H3K27ac,input$Stromal_Connective_Culture_H3K27ac,input$Vascular_Culture_H3K27ac,input$Blood_Adult_H3K27ac,input$Brain_Adult_H3K27ac,input$Breast_Adult_H3K27ac,input$Fat_Adult_H3K27ac,input$GI_Colon_Adult_H3K27ac,input$GI_Duodenum_Adult_H3K27ac,input$GI_Esophagus_Adult_H3K27ac,input$GI_Intestine_Adult_H3K27ac,input$GI_Rectum_Adult_H3K27ac,input$GI_Stomach_Adult_H3K27ac,input$Heart_Adult_H3K27ac,input$Liver_Adult_H3K27ac,input$Lung_Adult_H3K27ac,input$Muscle_Adult_H3K27ac,input$Ovary_Adult_H3K27ac,input$Pancreas_Adult_H3K27ac,input$Spleen_Adult_H3K27ac,input$Thymus_Adult_H3K27ac,input$Vascular_Adult_H3K27ac,input$Adrenal_Fetal_H3K27ac,input$Blood_Fetal_H3K27ac,input$Brain_Fetal_H3K27ac,input$GI_Intestine_Fetal_H3K27ac,input$GI_Stomach_Fetal_H3K27ac,input$Heart_Fetal_H3K27ac,input$Kidney_Fetal_H3K27ac,input$Lung_Fetal_H3K27ac,input$Muscle_Fetal_H3K27ac,input$Placenta_Fetal_H3K27ac,input$Thymus_Fetal_H3K27ac,input$Blood_CellLine_H3K27ac,input$Cervix_CellLine_H3K27ac,input$Liver_CellLine_H3K27ac,input$Lung_CellLine_H3K27ac)      
	}) 

  	observeEvent(input$selectSampleVis_H3K4me1,{
      	samVis$data <- c(input$Blood_Culture_H3K4me1,input$Bone_Culture_H3K4me1,input$Brain_Culture_H3K4me1,input$Breast_Culture_H3K4me1,input$ESC_Culture_H3K4me1,input$ESC_Derived_Culture_H3K4me1,input$Fat_Culture_H3K4me1,input$IPSC_Culture_H3K4me1,input$Lung_Culture_H3K4me1,input$Muscle_Culture_H3K4me1,input$Skin_Culture_H3K4me1,input$Stromal_Connective_Culture_H3K4me1,input$Vascular_Culture_H3K4me1,input$Blood_Adult_H3K4me1,input$Brain_Adult_H3K4me1,input$Breast_Adult_H3K4me1,input$Fat_Adult_H3K4me1,input$GI_Colon_Adult_H3K4me1,input$GI_Duodenum_Adult_H3K4me1,input$GI_Esophagus_Adult_H3K4me1,input$GI_Intestine_Adult_H3K4me1,input$GI_Rectum_Adult_H3K4me1,input$GI_Stomach_Adult_H3K4me1,input$Heart_Adult_H3K4me1,input$Liver_Adult_H3K4me1,input$Lung_Adult_H3K4me1,input$Muscle_Adult_H3K4me1,input$Ovary_Adult_H3K4me1,input$Pancreas_Adult_H3K4me1,input$Spleen_Adult_H3K4me1,input$Thymus_Adult_H3K4me1,input$Vascular_Adult_H3K4me1,input$Adrenal_Fetal_H3K4me1,input$Blood_Fetal_H3K4me1,input$Brain_Fetal_H3K4me1,input$GI_Intestine_Fetal_H3K4me1,input$GI_Stomach_Fetal_H3K4me1,input$Heart_Fetal_H3K4me1,input$Kidney_Fetal_H3K4me1,input$Lung_Fetal_H3K4me1,input$Muscle_Fetal_H3K4me1,input$Placenta_Fetal_H3K4me1,input$Thymus_Fetal_H3K4me1,input$Blood_CellLine_H3K4me1,input$Cervix_CellLine_H3K4me1,input$Liver_CellLine_H3K4me1,input$Lung_CellLine_H3K4me1)      
	})  

  	observeEvent(input$selectSampleVis_H3K4me3,{
      	samVis$data <- c(input$Blood_Culture_H3K4me3,input$Bone_Culture_H3K4me3,input$Brain_Culture_H3K4me3,input$Breast_Culture_H3K4me3,input$ESC_Culture_H3K4me3,input$ESC_Derived_Culture_H3K4me3,input$Fat_Culture_H3K4me3,input$IPSC_Culture_H3K4me3,input$Lung_Culture_H3K4me3,input$Muscle_Culture_H3K4me3,input$Skin_Culture_H3K4me3,input$Stromal_Connective_Culture_H3K4me3,input$Vascular_Culture_H3K4me3,input$Blood_Adult_H3K4me3,input$Brain_Adult_H3K4me3,input$Breast_Adult_H3K4me3,input$Fat_Adult_H3K4me3,input$GI_Colon_Adult_H3K4me3,input$GI_Duodenum_Adult_H3K4me3,input$GI_Esophagus_Adult_H3K4me3,input$GI_Intestine_Adult_H3K4me3,input$GI_Rectum_Adult_H3K4me3,input$GI_Stomach_Adult_H3K4me3,input$Heart_Adult_H3K4me3,input$Liver_Adult_H3K4me3,input$Lung_Adult_H3K4me3,input$Muscle_Adult_H3K4me3,input$Ovary_Adult_H3K4me3,input$Pancreas_Adult_H3K4me3,input$Spleen_Adult_H3K4me3,input$Thymus_Adult_H3K4me3,input$Vascular_Adult_H3K4me3,input$Adrenal_Fetal_H3K4me3,input$Blood_Fetal_H3K4me3,input$Brain_Fetal_H3K4me3,input$GI_Intestine_Fetal_H3K4me3,input$GI_Stomach_Fetal_H3K4me3,input$Heart_Fetal_H3K4me3,input$Kidney_Fetal_H3K4me3,input$Lung_Fetal_H3K4me3,input$Muscle_Fetal_H3K4me3,input$Placenta_Fetal_H3K4me3,input$Thymus_Fetal_H3K4me3,input$Blood_CellLine_H3K4me3,input$Cervix_CellLine_H3K4me3,input$Liver_CellLine_H3K4me3,input$Lung_CellLine_H3K4me3)      
	})

  	observeEvent(input$selectSampleVis_H3K27me3,{
      	samVis$data <- c(input$Blood_Culture_H3K27me3,input$Bone_Culture_H3K27me3,input$Brain_Culture_H3K27me3,input$Breast_Culture_H3K27me3,input$ESC_Culture_H3K27me3,input$ESC_Derived_Culture_H3K27me3,input$Fat_Culture_H3K27me3,input$IPSC_Culture_H3K27me3,input$Lung_Culture_H3K27me3,input$Muscle_Culture_H3K27me3,input$Skin_Culture_H3K27me3,input$Stromal_Connective_Culture_H3K27me3,input$Vascular_Culture_H3K27me3,input$Blood_Adult_H3K27me3,input$Brain_Adult_H3K27me3,input$Breast_Adult_H3K27me3,input$Fat_Adult_H3K27me3,input$GI_Colon_Adult_H3K27me3,input$GI_Duodenum_Adult_H3K27me3,input$GI_Esophagus_Adult_H3K27me3,input$GI_Intestine_Adult_H3K27me3,input$GI_Rectum_Adult_H3K27me3,input$GI_Stomach_Adult_H3K27me3,input$Heart_Adult_H3K27me3,input$Liver_Adult_H3K27me3,input$Lung_Adult_H3K27me3,input$Muscle_Adult_H3K27me3,input$Ovary_Adult_H3K27me3,input$Pancreas_Adult_H3K27me3,input$Spleen_Adult_H3K27me3,input$Thymus_Adult_H3K27me3,input$Vascular_Adult_H3K27me3,input$Adrenal_Fetal_H3K27me3,input$Blood_Fetal_H3K27me3,input$Brain_Fetal_H3K27me3,input$GI_Intestine_Fetal_H3K27me3,input$GI_Stomach_Fetal_H3K27me3,input$Heart_Fetal_H3K27me3,input$Kidney_Fetal_H3K27me3,input$Lung_Fetal_H3K27me3,input$Muscle_Fetal_H3K27me3,input$Placenta_Fetal_H3K27me3,input$Thymus_Fetal_H3K27me3,input$Blood_CellLine_H3K27me3,input$Cervix_CellLine_H3K27me3,input$Liver_CellLine_H3K27me3,input$Lung_CellLine_H3K27me3)      
	})


	#select foreground and background samples for different features
  	observeEvent(input$selectFore,{
      	if (input$selectHMM == '15 model'){
      		fore$data <- c(input$userSamples,input$Blood_Culture,input$Bone_Culture,input$Brain_Culture,input$Breast_Culture,input$ESC_Culture,input$ESC_Derived_Culture,input$Fat_Culture,input$IPSC_Culture,input$Lung_Culture,input$Muscle_Culture,input$Skin_Culture,input$Stromal_Connective_Culture,input$Vascular_Culture,input$Blood_Adult,input$Brain_Adult,input$Breast_Adult,input$Fat_Adult,input$GI_Colon_Adult,input$GI_Duodenum_Adult,input$GI_Esophagus_Adult,input$GI_Intestine_Adult,input$GI_Rectum_Adult,input$GI_Stomach_Adult,input$Heart_Adult,input$Liver_Adult,input$Lung_Adult,input$Muscle_Adult,input$Ovary_Adult,input$Pancreas_Adult,input$Spleen_Adult,input$Thymus_Adult,input$Vascular_Adult,input$Adrenal_Fetal,input$Blood_Fetal,input$Brain_Fetal,input$GI_Intestine_Fetal,input$GI_Stomach_Fetal,input$Heart_Fetal,input$Kidney_Fetal,input$Lung_Fetal,input$Muscle_Fetal,input$Placenta_Fetal,input$Thymus_Fetal,input$Blood_CellLine,input$Cervix_CellLine,input$Liver_CellLine,input$Lung_CellLine)
      	}else{
      	#modified 7-17
      		fore$data <- c(input$userSamples,input$Blood_Culture_18,input$Bone_Culture_18,input$Brain_Culture_18,input$Breast_Culture_18,input$ESC_Culture_18,input$ESC_Derived_Culture_18,input$Fat_Culture_18,input$IPSC_Culture_18,input$Lung_Culture_18,input$Muscle_Culture_18,input$Skin_Culture_18,input$Stromal_Connective_Culture_18,input$Vascular_Culture_18,input$Blood_Adult_18,input$Brain_Adult_18,input$Breast_Adult_18,input$Fat_Adult_18,input$GI_Colon_Adult_18,input$GI_Duodenum_Adult_18,input$GI_Esophagus_Adult_18,input$GI_Intestine_Adult_18,input$GI_Rectum_Adult_18,input$GI_Stomach_Adult_18,input$Heart_Adult_18,input$Liver_Adult_18,input$Lung_Adult_18,input$Muscle_Adult_18,input$Ovary_Adult_18,input$Pancreas_Adult_18,input$Spleen_Adult_18,input$Thymus_Adult_18,input$Vascular_Adult_18,input$Adrenal_Fetal_18,input$Blood_Fetal_18,input$Brain_Fetal_18,input$GI_Intestine_Fetal_18,input$GI_Stomach_Fetal_18,input$Heart_Fetal_18,input$Kidney_Fetal_18,input$Lung_Fetal_18,input$Muscle_Fetal_18,input$Placenta_Fetal_18,input$Thymus_Fetal_18,input$Blood_CellLine_18,input$Cervix_CellLine_18,input$Liver_CellLine_18,input$Lung_CellLine_18)      
      	}
	})

  	observeEvent(input$selectBack,{
      	if (input$selectHMM == '15 model'){
      		all_select <- c(input$userSamples,input$Blood_Culture,input$Bone_Culture,input$Brain_Culture,input$Breast_Culture,input$ESC_Culture,input$ESC_Derived_Culture,input$Fat_Culture,input$IPSC_Culture,input$Lung_Culture,input$Muscle_Culture,input$Skin_Culture,input$Stromal_Connective_Culture,input$Vascular_Culture,input$Blood_Adult,input$Brain_Adult,input$Breast_Adult,input$Fat_Adult,input$GI_Colon_Adult,input$GI_Duodenum_Adult,input$GI_Esophagus_Adult,input$GI_Intestine_Adult,input$GI_Rectum_Adult,input$GI_Stomach_Adult,input$Heart_Adult,input$Liver_Adult,input$Lung_Adult,input$Muscle_Adult,input$Ovary_Adult,input$Pancreas_Adult,input$Spleen_Adult,input$Thymus_Adult,input$Vascular_Adult,input$Adrenal_Fetal,input$Blood_Fetal,input$Brain_Fetal,input$GI_Intestine_Fetal,input$GI_Stomach_Fetal,input$Heart_Fetal,input$Kidney_Fetal,input$Lung_Fetal,input$Muscle_Fetal,input$Placenta_Fetal,input$Thymus_Fetal,input$Blood_CellLine,input$Cervix_CellLine,input$Liver_CellLine,input$Lung_CellLine)      
      	}else{
      	#modified 7-17
      		all_select <- c(input$userSamples,input$Blood_Culture_18,input$Bone_Culture_18,input$Brain_Culture_18,input$Breast_Culture_18,input$ESC_Culture_18,input$ESC_Derived_Culture_18,input$Fat_Culture_18,input$IPSC_Culture_18,input$Lung_Culture_18,input$Muscle_Culture_18,input$Skin_Culture_18,input$Stromal_Connective_Culture_18,input$Vascular_Culture_18,input$Blood_Adult_18,input$Brain_Adult_18,input$Breast_Adult_18,input$Fat_Adult_18,input$GI_Colon_Adult_18,input$GI_Duodenum_Adult_18,input$GI_Esophagus_Adult_18,input$GI_Intestine_Adult_18,input$GI_Rectum_Adult_18,input$GI_Stomach_Adult_18,input$Heart_Adult_18,input$Liver_Adult_18,input$Lung_Adult_18,input$Muscle_Adult_18,input$Ovary_Adult_18,input$Pancreas_Adult_18,input$Spleen_Adult_18,input$Thymus_Adult_18,input$Vascular_Adult_18,input$Adrenal_Fetal_18,input$Blood_Fetal_18,input$Brain_Fetal_18,input$GI_Intestine_Fetal_18,input$GI_Stomach_Fetal_18,input$Heart_Fetal_18,input$Kidney_Fetal_18,input$Lung_Fetal_18,input$Muscle_Fetal_18,input$Placenta_Fetal_18,input$Thymus_Fetal_18,input$Blood_CellLine_18,input$Cervix_CellLine_18,input$Liver_CellLine_18,input$Lung_CellLine_18)     
     	}
      	fore_index <- match(fore$data,all_select)     
      	back$data <- all_select[-fore_index]
    })

  	observeEvent(input$selectFore_H3K27ac,{
      	fore$data <- c(input$userSamples,input$Blood_Culture_H3K27ac,input$Bone_Culture_H3K27ac,input$Brain_Culture_H3K27ac,input$Breast_Culture_H3K27ac,input$ESC_Culture_H3K27ac,input$ESC_Derived_Culture_H3K27ac,input$Fat_Culture_H3K27ac,input$IPSC_Culture_H3K27ac,input$Lung_Culture_H3K27ac,input$Muscle_Culture_H3K27ac,input$Skin_Culture_H3K27ac,input$Stromal_Connective_Culture_H3K27ac,input$Vascular_Culture_H3K27ac,input$Blood_Adult_H3K27ac,input$Brain_Adult_H3K27ac,input$Breast_Adult_H3K27ac,input$Fat_Adult_H3K27ac,input$GI_Colon_Adult_H3K27ac,input$GI_Duodenum_Adult_H3K27ac,input$GI_Esophagus_Adult_H3K27ac,input$GI_Intestine_Adult_H3K27ac,input$GI_Rectum_Adult_H3K27ac,input$GI_Stomach_Adult_H3K27ac,input$Heart_Adult_H3K27ac,input$Liver_Adult_H3K27ac,input$Lung_Adult_H3K27ac,input$Muscle_Adult_H3K27ac,input$Ovary_Adult_H3K27ac,input$Pancreas_Adult_H3K27ac,input$Spleen_Adult_H3K27ac,input$Thymus_Adult_H3K27ac,input$Vascular_Adult_H3K27ac,input$Adrenal_Fetal_H3K27ac,input$Blood_Fetal_H3K27ac,input$Brain_Fetal_H3K27ac,input$GI_Intestine_Fetal_H3K27ac,input$GI_Stomach_Fetal_H3K27ac,input$Heart_Fetal_H3K27ac,input$Kidney_Fetal_H3K27ac,input$Lung_Fetal_H3K27ac,input$Muscle_Fetal_H3K27ac,input$Placenta_Fetal_H3K27ac,input$Thymus_Fetal_H3K27ac,input$Blood_CellLine_H3K27ac,input$Cervix_CellLine_H3K27ac,input$Liver_CellLine_H3K27ac,input$Lung_CellLine_H3K27ac)      
    })

  	observeEvent(input$selectBack_H3K27ac,{
      	all_select <- c(input$userSamples,input$Blood_Culture_H3K27ac,input$Bone_Culture_H3K27ac,input$Brain_Culture_H3K27ac,input$Breast_Culture_H3K27ac,input$ESC_Culture_H3K27ac,input$ESC_Derived_Culture_H3K27ac,input$Fat_Culture_H3K27ac,input$IPSC_Culture_H3K27ac,input$Lung_Culture_H3K27ac,input$Muscle_Culture_H3K27ac,input$Skin_Culture_H3K27ac,input$Stromal_Connective_Culture_H3K27ac,input$Vascular_Culture_H3K27ac,input$Blood_Adult_H3K27ac,input$Brain_Adult_H3K27ac,input$Breast_Adult_H3K27ac,input$Fat_Adult_H3K27ac,input$GI_Colon_Adult_H3K27ac,input$GI_Duodenum_Adult_H3K27ac,input$GI_Esophagus_Adult_H3K27ac,input$GI_Intestine_Adult_H3K27ac,input$GI_Rectum_Adult_H3K27ac,input$GI_Stomach_Adult_H3K27ac,input$Heart_Adult_H3K27ac,input$Liver_Adult_H3K27ac,input$Lung_Adult_H3K27ac,input$Muscle_Adult_H3K27ac,input$Ovary_Adult_H3K27ac,input$Pancreas_Adult_H3K27ac,input$Spleen_Adult_H3K27ac,input$Thymus_Adult_H3K27ac,input$Vascular_Adult_H3K27ac,input$Adrenal_Fetal_H3K27ac,input$Blood_Fetal_H3K27ac,input$Brain_Fetal_H3K27ac,input$GI_Intestine_Fetal_H3K27ac,input$GI_Stomach_Fetal_H3K27ac,input$Heart_Fetal_H3K27ac,input$Kidney_Fetal_H3K27ac,input$Lung_Fetal_H3K27ac,input$Muscle_Fetal_H3K27ac,input$Placenta_Fetal_H3K27ac,input$Thymus_Fetal_H3K27ac,input$Blood_CellLine_H3K27ac,input$Cervix_CellLine_H3K27ac,input$Liver_CellLine_H3K27ac,input$Lung_CellLine_H3K27ac)     
      	fore_index <- match(fore$data,all_select)     
      	back$data <- all_select[-fore_index]
    })

  	observeEvent(input$selectFore_H3K4me1,{
      	fore$data <- c(input$userSamples,input$Blood_Culture_H3K4me1,input$Bone_Culture_H3K4me1,input$Brain_Culture_H3K4me1,input$Breast_Culture_H3K4me1,input$ESC_Culture_H3K4me1,input$ESC_Derived_Culture_H3K4me1,input$Fat_Culture_H3K4me1,input$IPSC_Culture_H3K4me1,input$Lung_Culture_H3K4me1,input$Muscle_Culture_H3K4me1,input$Skin_Culture_H3K4me1,input$Stromal_Connective_Culture_H3K4me1,input$Vascular_Culture_H3K4me1,input$Blood_Adult_H3K4me1,input$Brain_Adult_H3K4me1,input$Breast_Adult_H3K4me1,input$Fat_Adult_H3K4me1,input$GI_Colon_Adult_H3K4me1,input$GI_Duodenum_Adult_H3K4me1,input$GI_Esophagus_Adult_H3K4me1,input$GI_Intestine_Adult_H3K4me1,input$GI_Rectum_Adult_H3K4me1,input$GI_Stomach_Adult_H3K4me1,input$Heart_Adult_H3K4me1,input$Liver_Adult_H3K4me1,input$Lung_Adult_H3K4me1,input$Muscle_Adult_H3K4me1,input$Ovary_Adult_H3K4me1,input$Pancreas_Adult_H3K4me1,input$Spleen_Adult_H3K4me1,input$Thymus_Adult_H3K4me1,input$Vascular_Adult_H3K4me1,input$Adrenal_Fetal_H3K4me1,input$Blood_Fetal_H3K4me1,input$Brain_Fetal_H3K4me1,input$GI_Intestine_Fetal_H3K4me1,input$GI_Stomach_Fetal_H3K4me1,input$Heart_Fetal_H3K4me1,input$Kidney_Fetal_H3K4me1,input$Lung_Fetal_H3K4me1,input$Muscle_Fetal_H3K4me1,input$Placenta_Fetal_H3K4me1,input$Thymus_Fetal_H3K4me1,input$Blood_CellLine_H3K4me1,input$Cervix_CellLine_H3K4me1,input$Liver_CellLine_H3K4me1,input$Lung_CellLine_H3K4me1)      
    })

  	observeEvent(input$selectBack_H3K4me1,{
      	all_select <- c(input$userSamples,input$Blood_Culture_H3K4me1,input$Bone_Culture_H3K4me1,input$Brain_Culture_H3K4me1,input$Breast_Culture_H3K4me1,input$ESC_Culture_H3K4me1,input$ESC_Derived_Culture_H3K4me1,input$Fat_Culture_H3K4me1,input$IPSC_Culture_H3K4me1,input$Lung_Culture_H3K4me1,input$Muscle_Culture_H3K4me1,input$Skin_Culture_H3K4me1,input$Stromal_Connective_Culture_H3K4me1,input$Vascular_Culture_H3K4me1,input$Blood_Adult_H3K4me1,input$Brain_Adult_H3K4me1,input$Breast_Adult_H3K4me1,input$Fat_Adult_H3K4me1,input$GI_Colon_Adult_H3K4me1,input$GI_Duodenum_Adult_H3K4me1,input$GI_Esophagus_Adult_H3K4me1,input$GI_Intestine_Adult_H3K4me1,input$GI_Rectum_Adult_H3K4me1,input$GI_Stomach_Adult_H3K4me1,input$Heart_Adult_H3K4me1,input$Liver_Adult_H3K4me1,input$Lung_Adult_H3K4me1,input$Muscle_Adult_H3K4me1,input$Ovary_Adult_H3K4me1,input$Pancreas_Adult_H3K4me1,input$Spleen_Adult_H3K4me1,input$Thymus_Adult_H3K4me1,input$Vascular_Adult_H3K4me1,input$Adrenal_Fetal_H3K4me1,input$Blood_Fetal_H3K4me1,input$Brain_Fetal_H3K4me1,input$GI_Intestine_Fetal_H3K4me1,input$GI_Stomach_Fetal_H3K4me1,input$Heart_Fetal_H3K4me1,input$Kidney_Fetal_H3K4me1,input$Lung_Fetal_H3K4me1,input$Muscle_Fetal_H3K4me1,input$Placenta_Fetal_H3K4me1,input$Thymus_Fetal_H3K4me1,input$Blood_CellLine_H3K4me1,input$Cervix_CellLine_H3K4me1,input$Liver_CellLine_H3K4me1,input$Lung_CellLine_H3K4me1)     
      	fore_index <- match(fore$data,all_select)     
      	back$data <- all_select[-fore_index]
    })

  	observeEvent(input$selectFore_H3K4me3,{
      	fore$data <- c(input$userSamples,input$Blood_Culture_H3K4me3,input$Bone_Culture_H3K4me3,input$Brain_Culture_H3K4me3,input$Breast_Culture_H3K4me3,input$ESC_Culture_H3K4me3,input$ESC_Derived_Culture_H3K4me3,input$Fat_Culture_H3K4me3,input$IPSC_Culture_H3K4me3,input$Lung_Culture_H3K4me3,input$Muscle_Culture_H3K4me3,input$Skin_Culture_H3K4me3,input$Stromal_Connective_Culture_H3K4me3,input$Vascular_Culture_H3K4me3,input$Blood_Adult_H3K4me3,input$Brain_Adult_H3K4me3,input$Breast_Adult_H3K4me3,input$Fat_Adult_H3K4me3,input$GI_Colon_Adult_H3K4me3,input$GI_Duodenum_Adult_H3K4me3,input$GI_Esophagus_Adult_H3K4me3,input$GI_Intestine_Adult_H3K4me3,input$GI_Rectum_Adult_H3K4me3,input$GI_Stomach_Adult_H3K4me3,input$Heart_Adult_H3K4me3,input$Liver_Adult_H3K4me3,input$Lung_Adult_H3K4me3,input$Muscle_Adult_H3K4me3,input$Ovary_Adult_H3K4me3,input$Pancreas_Adult_H3K4me3,input$Spleen_Adult_H3K4me3,input$Thymus_Adult_H3K4me3,input$Vascular_Adult_H3K4me3,input$Adrenal_Fetal_H3K4me3,input$Blood_Fetal_H3K4me3,input$Brain_Fetal_H3K4me3,input$GI_Intestine_Fetal_H3K4me3,input$GI_Stomach_Fetal_H3K4me3,input$Heart_Fetal_H3K4me3,input$Kidney_Fetal_H3K4me3,input$Lung_Fetal_H3K4me3,input$Muscle_Fetal_H3K4me3,input$Placenta_Fetal_H3K4me3,input$Thymus_Fetal_H3K4me3,input$Blood_CellLine_H3K4me3,input$Cervix_CellLine_H3K4me3,input$Liver_CellLine_H3K4me3,input$Lung_CellLine_H3K4me3)      
    })

  	observeEvent(input$selectBack_H3K4me3,{
      	all_select <- c(input$userSamples,input$Blood_Culture_H3K4me3,input$Bone_Culture_H3K4me3,input$Brain_Culture_H3K4me3,input$Breast_Culture_H3K4me3,input$ESC_Culture_H3K4me3,input$ESC_Derived_Culture_H3K4me3,input$Fat_Culture_H3K4me3,input$IPSC_Culture_H3K4me3,input$Lung_Culture_H3K4me3,input$Muscle_Culture_H3K4me3,input$Skin_Culture_H3K4me3,input$Stromal_Connective_Culture_H3K4me3,input$Vascular_Culture_H3K4me3,input$Blood_Adult_H3K4me3,input$Brain_Adult_H3K4me3,input$Breast_Adult_H3K4me3,input$Fat_Adult_H3K4me3,input$GI_Colon_Adult_H3K4me3,input$GI_Duodenum_Adult_H3K4me3,input$GI_Esophagus_Adult_H3K4me3,input$GI_Intestine_Adult_H3K4me3,input$GI_Rectum_Adult_H3K4me3,input$GI_Stomach_Adult_H3K4me3,input$Heart_Adult_H3K4me3,input$Liver_Adult_H3K4me3,input$Lung_Adult_H3K4me3,input$Muscle_Adult_H3K4me3,input$Ovary_Adult_H3K4me3,input$Pancreas_Adult_H3K4me3,input$Spleen_Adult_H3K4me3,input$Thymus_Adult_H3K4me3,input$Vascular_Adult_H3K4me3,input$Adrenal_Fetal_H3K4me3,input$Blood_Fetal_H3K4me3,input$Brain_Fetal_H3K4me3,input$GI_Intestine_Fetal_H3K4me3,input$GI_Stomach_Fetal_H3K4me3,input$Heart_Fetal_H3K4me3,input$Kidney_Fetal_H3K4me3,input$Lung_Fetal_H3K4me3,input$Muscle_Fetal_H3K4me3,input$Placenta_Fetal_H3K4me3,input$Thymus_Fetal_H3K4me3,input$Blood_CellLine_H3K4me3,input$Cervix_CellLine_H3K4me3,input$Liver_CellLine_H3K4me3,input$Lung_CellLine_H3K4me3)     
      	fore_index <- match(fore$data,all_select)     
      	back$data <- all_select[-fore_index]
    })

  	observeEvent(input$selectFore_H3K27me3,{
      	fore$data <- c(input$userSamples,input$Blood_Culture_H3K27me3,input$Bone_Culture_H3K27me3,input$Brain_Culture_H3K27me3,input$Breast_Culture_H3K27me3,input$ESC_Culture_H3K27me3,input$ESC_Derived_Culture_H3K27me3,input$Fat_Culture_H3K27me3,input$IPSC_Culture_H3K27me3,input$Lung_Culture_H3K27me3,input$Muscle_Culture_H3K27me3,input$Skin_Culture_H3K27me3,input$Stromal_Connective_Culture_H3K27me3,input$Vascular_Culture_H3K27me3,input$Blood_Adult_H3K27me3,input$Brain_Adult_H3K27me3,input$Breast_Adult_H3K27me3,input$Fat_Adult_H3K27me3,input$GI_Colon_Adult_H3K27me3,input$GI_Duodenum_Adult_H3K27me3,input$GI_Esophagus_Adult_H3K27me3,input$GI_Intestine_Adult_H3K27me3,input$GI_Rectum_Adult_H3K27me3,input$GI_Stomach_Adult_H3K27me3,input$Heart_Adult_H3K27me3,input$Liver_Adult_H3K27me3,input$Lung_Adult_H3K27me3,input$Muscle_Adult_H3K27me3,input$Ovary_Adult_H3K27me3,input$Pancreas_Adult_H3K27me3,input$Spleen_Adult_H3K27me3,input$Thymus_Adult_H3K27me3,input$Vascular_Adult_H3K27me3,input$Adrenal_Fetal_H3K27me3,input$Blood_Fetal_H3K27me3,input$Brain_Fetal_H3K27me3,input$GI_Intestine_Fetal_H3K27me3,input$GI_Stomach_Fetal_H3K27me3,input$Heart_Fetal_H3K27me3,input$Kidney_Fetal_H3K27me3,input$Lung_Fetal_H3K27me3,input$Muscle_Fetal_H3K27me3,input$Placenta_Fetal_H3K27me3,input$Thymus_Fetal_H3K27me3,input$Blood_CellLine_H3K27me3,input$Cervix_CellLine_H3K27me3,input$Liver_CellLine_H3K27me3,input$Lung_CellLine_H3K27me3)      
    })

  	observeEvent(input$selectBack_H3K27me3,{
      	all_select <- c(input$userSamples,input$Blood_Culture_H3K27me3,input$Bone_Culture_H3K27me3,input$Brain_Culture_H3K27me3,input$Breast_Culture_H3K27me3,input$ESC_Culture_H3K27me3,input$ESC_Derived_Culture_H3K27me3,input$Fat_Culture_H3K27me3,input$IPSC_Culture_H3K27me3,input$Lung_Culture_H3K27me3,input$Muscle_Culture_H3K27me3,input$Skin_Culture_H3K27me3,input$Stromal_Connective_Culture_H3K27me3,input$Vascular_Culture_H3K27me3,input$Blood_Adult_H3K27me3,input$Brain_Adult_H3K27me3,input$Breast_Adult_H3K27me3,input$Fat_Adult_H3K27me3,input$GI_Colon_Adult_H3K27me3,input$GI_Duodenum_Adult_H3K27me3,input$GI_Esophagus_Adult_H3K27me3,input$GI_Intestine_Adult_H3K27me3,input$GI_Rectum_Adult_H3K27me3,input$GI_Stomach_Adult_H3K27me3,input$Heart_Adult_H3K27me3,input$Liver_Adult_H3K27me3,input$Lung_Adult_H3K27me3,input$Muscle_Adult_H3K27me3,input$Ovary_Adult_H3K27me3,input$Pancreas_Adult_H3K27me3,input$Spleen_Adult_H3K27me3,input$Thymus_Adult_H3K27me3,input$Vascular_Adult_H3K27me3,input$Adrenal_Fetal_H3K27me3,input$Blood_Fetal_H3K27me3,input$Brain_Fetal_H3K27me3,input$GI_Intestine_Fetal_H3K27me3,input$GI_Stomach_Fetal_H3K27me3,input$Heart_Fetal_H3K27me3,input$Kidney_Fetal_H3K27me3,input$Lung_Fetal_H3K27me3,input$Muscle_Fetal_H3K27me3,input$Placenta_Fetal_H3K27me3,input$Thymus_Fetal_H3K27me3,input$Blood_CellLine_H3K27me3,input$Cervix_CellLine_H3K27me3,input$Liver_CellLine_H3K27me3,input$Lung_CellLine_H3K27me3)     
      	fore_index <- match(fore$data,all_select)     
      	back$data <- all_select[-fore_index]
    })

  	
  	#print samples selected for visualization in browser for different features
  	output$summary1Vis_hmm <- renderPrint({
    	validate(
      		need(length(samVis$data) != 0, "Please select samples for visualization in WashU Epigenome Browser.")
    	)
    	print(samVis$data)
  	})

  	output$summary1Vis_H3K27ac <- renderPrint({
    	validate(
      		need(length(samVis$data) != 0, "Please select samples for visualization in WashU Epigenome Browser.")
    	)
    	print(samVis$data)
  	})

  	output$summary1Vis_H3K4me1 <- renderPrint({
    	validate(
      		need(length(samVis$data) != 0, "Please select samples for visualization in WashU Epigenome Browser.")
    	)
    	print(samVis$data)
  	})

  	output$summary1Vis_H3K4me3 <- renderPrint({
    	validate(
      		need(length(samVis$data) != 0, "Please select samples for visualization in WashU Epigenome Browser.")
    	)
    	print(samVis$data)
  	})

  	output$summary1Vis_H3K27me3 <- renderPrint({
    	validate(
      		need(length(samVis$data) != 0, "Please select samples for visualization in WashU Epigenome Browser.")
    	)
    	print(samVis$data)
  	})


  	#print selected foreground and background samples for different features
  	output$summary1 <- renderPrint({
    	validate(
      		need(length(fore$data) != 0, "Please select foreground samples first.")
    	)
    	print(fore$data)
  	})

  	output$summary2 <- renderPrint({
    	validate(
      		need(length(back$data) != 0, "Please select background samples after selecting foreground samples.")
    	)
    	print(back$data)
  	})

  	output$summary1_H3K27ac <- renderPrint({
    	validate(
      		need(length(fore$data) != 0, "Please select foreground samples first.")
    	)
    	print(fore$data)
  	})

  	output$summary2_H3K27ac <- renderPrint({
    	validate(
      		need(length(back$data) != 0, "Please select background samples after selecting foreground samples.")
    	)
    	print(back$data)
  	})

  	output$summary1_H3K4me1 <- renderPrint({
    	validate(
      		need(length(fore$data) != 0, "Please select foreground samples first.")
    	)
    	print(fore$data)
  	})

  	output$summary2_H3K4me1 <- renderPrint({
    	validate(
      		need(length(back$data) != 0, "Please select background samples after selecting foreground samples.")
    	)
    	print(back$data)
  	})

  	output$summary1_H3K4me3 <- renderPrint({
    	validate(
      		need(length(fore$data) != 0, "Please select foreground samples first.")
    	)
    	print(fore$data)
  	})

  	output$summary2_H3K4me3 <- renderPrint({
    	validate(
      		need(length(back$data) != 0, "Please select background samples after selecting foreground samples.")
    	)
    	print(back$data)
  	})

  	output$summary1_H3K27me3 <- renderPrint({
    	validate(
      		need(length(fore$data) != 0, "Please select foreground samples first.")
    	)
    	print(fore$data)
  	})

  	output$summary2_H3K27me3 <- renderPrint({
    	validate(
      	need(length(back$data) != 0, "Please select background samples after selecting foreground samples.")
    	)
    	print(back$data)
  	})
 

  	#submit
  	observeEvent(input$submit,{
        validate(
      		need(length(fore$data) != 0, session$sendCustomMessage("no_submit", list()))
    	)
        validate(
      		need(length(fore$data) != 0, 'no fore')
    	)
    	updateTabsetPanel(session, "navBarPageID", selected = "Results")
    	session$sendCustomMessage("ok_submit", list())
    })


  	#get features selected for visualization in browser
  	featVis=reactive({
      	if (input$selectFeature=='H3K4me1'){
            input$selectFeatureVis_H3K4me1
        }else if (input$selectFeature=='H3K4me3'){
        	input$selectFeatureVis_H3K4me3
        }else if (input$selectFeature=='H3K27me3'){
        	input$selectFeatureVis_H3K27me3
        }else if (input$selectFeature=='H3K27ac'){
        	input$selectFeatureVis_H3K27ac
        }else{
        	input$selectFeatureVis_hmm
        }
    })

  
    #add user data
    output$addSamples <- renderUI({
        #get coordinates for map user data onto corresponding coordinates
        if (input$selectFeature=='ChromHMM'){
          if (input$selectHMM=='15 model'){
              if (input$selectState=="enhancer"){
                coord='coordinates/enhancer_logic_15_coord'
              }else{
              coord='coordinates/promoter_logic_15_coord' 
              }
          }else{
              if (input$selectState=="enhancer"){
                coord='coordinates/enhancer_logic_18_coord'   
              }else{
              coord='coordinates/promoter_logic_18_coord' 
              }
          }
        }else if (input$selectFeature=='H3K27ac'){
          coord='coordinates/H3K27ac_logic_coord'
        }else if (input$selectFeature=='H3K4me1'){
          coord='coordinates/H3K4me1_logic_coord'
        }else if (input$selectFeature=='H3K4me3'){
          coord='coordinates/H3K4me3_logic_coord'
        }else {
          coord='coordinates/H3K27me3_logic_coord'
        }

      #process one file or multiple files
        if (input$selectFile=='multiple'){ #multiple files
            #return null if files are empty
            inFile <- input$file2
            if (is.null(inFile))
                return(NULL)
            #wait
            session$sendCustomMessage("upload_process_data", list()) #added 10-07-2016

            #get file name by removing suffix 
            fileName=inFile[,'name']
            fileList=fileName
            numFile=length(fileName)
            for (i in c(1:numFile)){
                fileList[i]=unlist(strsplit(fileName[i],"[.]"))[1]
            }
            
            #process data
            data1=read.table(inFile[[1, 'datapath']],sep='\t')
            write.table(data1,'www/write_to_disk/userdata.txt', row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')      
            process_user_data(coord) #intersect coord file with user file with -c option
            userData=read.table('www/write_to_disk/user_processed.txt',sep='\t')
            userData=userData[,4]
            userData[userData>1]=1
            for (i in c(2:numFile)){
                data1=read.table(inFile[[i, 'datapath']],sep='\t')
                write.table(data1,'www/write_to_disk/userdata.txt', row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')      
                process_user_data(coord)
                temp=read.table('www/write_to_disk/user_processed.txt',sep='\t')
                temp=temp[,4]
                temp[temp>1]=1
                userData=cbind(userData,temp)       
            }   

        }else{  #process one file
            inFile <- input$file1
            if (is.null(inFile))
                return(NULL)

            session$sendCustomMessage("upload_process_data", list()) #added 10-07-2016

            #get file name
            fileName=inFile[,'name']
            fileList=unlist(strsplit(fileName,"[.]"))[1]

            #process data
            data1=read.table(inFile$datapath,sep='\t')
            write.table(data1,'www/write_to_disk/userdata.txt', row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')      
            process_user_data(coord)
            userData=read.table('www/write_to_disk/user_processed.txt',sep='\t')
            userData=userData[,4]
            userData[userData>1]=1
            userData=as.data.frame(userData) #convert to data frame for storing colunm names, otherwise a vector will not get a specified name
        }

        colnames(userData)=fileList
        #save processed user data
        write.table(userData,'www/write_to_disk/user_data_final.txt', row.names=FALSE,col.names=TRUE,quote=FALSE,sep='\t')
        rm(list=setdiff(ls(), "fileList"))
        gc()
        session$sendCustomMessage("finish_upload_process_data", list())  #added 10-07-2016       
        checkboxGroupInput("userSamples", "UserSamples", fileList) #multiple checkboxes for selecting user data
    })


    #generate output table
    table <-eventReactive(input$submit,{
        validate(
            need(length(fore$data) != 0, "Please select foreground and background samples.")
        )
        if (input$selectMethod=="fisher"){
            validate(need(length(back$data) != 0, "Fisher's exact test method is not applicable when background samples are not specified."))
        }
        session$sendCustomMessage("download_notready", list())
        session$sendCustomMessage("result_notready", list())
        session$sendCustomMessage("ok_submit", list())
        session$sendCustomMessage("start_processing", list())
        session$sendCustomMessage("showProgress", list())
        session$sendCustomMessage("barProgress", list(1,'Identifying regions'))

        #write hub file
        hub_name=paste('hub',sample(c(1:10000),1),'.JSON',sep='') #generate a random hub name for each submit
        if (length(featVis())==0 | length(samVis$data)==0){
            if (input$selectFeature=='ChromHMM'){
                if (input$selectHMM=='15 model'){
                    generate_hub_file('ChromHMM15',fore$data,hub_name)
                }else{
                    generate_hub_file('ChromHMM18',fore$data,hub_name)
                }
            }else{
                generate_hub_file(input$selectFeature,fore$data,hub_name)
            }   
        }else{
            generate_hub_file(featVis(),samVis$data,hub_name)
        }
      

        #get data
        if (input$selectFeature=='ChromHMM'){
            if (input$selectHMM=='15 model'){
                load('Rdata/ChromHMM15_logic.Rdata')
                if (input$selectState=="enhancer"){
                    sample_logic=enhancer_logic_15
                }else{
                    sample_logic=promoter_logic_15 
                }
            }else{
                load('Rdata/ChromHMM18_logic.Rdata')
                if (input$selectState=="enhancer"){
                    sample_logic=enhancer_logic_18 
                }else{
                    sample_logic=promoter_logic_18 
                }
            }
        }else if (input$selectFeature=='H3K27ac'){
            load('Rdata/H3K27ac_logic.Rdata')
            sample_logic=H3K27ac_logic
        }else if (input$selectFeature=='H3K4me1'){
            load('Rdata/H3K4me1_logic.Rdata')
            sample_logic=H3K4me1_logic
        }else if (input$selectFeature=='H3K4me3'){
            load('Rdata/H3K4me3_logic.Rdata')
            sample_logic=H3K4me3_logic
        }else {
            load('Rdata/H3K27me3_logic.Rdata')
            sample_logic=H3K27me3_logic
        }
        #combine user data with embedded data
        if (!is.null(input$file1) | !is.null(input$file2)){
            user_logic=read.table('www/write_to_disk/user_data_final.txt',header=TRUE,sep='\t')
            sample_logic=cbind(sample_logic,user_logic)
        }

        #sample
        sample_list=reactive({
            if (input$selectFeature=='H3K4me1'){
                sample_list127
            }else if (input$selectFeature=='H3K4me3'){
                sample_list127
            }else if (input$selectFeature=='H3K27me3'){
                sample_list127
            }else if (input$selectFeature=='H3K27ac'){
                sample_list98
            }else{
                if (input$selectHMM=='15 model'){
                  sample_list127
                }else{
                  sample_list98
                }
            }
        })

        #calcualte foreground sample and background sample sum
        len_fore=reactive({length(fore$data)})
        len_back=reactive({length(back$data)})


        if (input$selectMethod=="cutoff" |input$selectMethod=="fisher"){ #cutoff or fisher
            if (len_fore()==1){
                foreSum=sample_logic[,fore$data]
            }else{
                foreSum=rowSums(sample_logic[,fore$data])
            } 

            if (len_back()>0){
                if (len_back()==1){
                        backSum=sample_logic[,back$data]
                    }else{
                        backSum=rowSums(sample_logic[,back$data])
                    }
            }
        }else { #cluster
            if (input$selectFeature=='ChromHMM'){
                if (input$selectHMM=='15 model'){                   
                    if (input$selectState=="enhancer"){
                    	load('Rdata/enh15_cluster_data.Rdata')
		                if (input$selectClusterNum=='c140'){
			                cluster_last=enh15_140cluster_lastColumn
			                cluster_density=enh15_140cluster_density                	
		                }else if(input$selectClusterNum=='c90'){
			                cluster_last=enh15_90cluster_lastColumn
			                cluster_density=enh15_90cluster_density
		                }else if(input$selectClusterNum=='c200'){
			                cluster_last=enh15_200cluster_lastColumn
			                cluster_density=enh15_200cluster_density
		                }else {
			                cluster_last=enh15_250cluster_lastColumn
			                cluster_density=enh15_250cluster_density
		                }
                    }else{
                    	load('Rdata/tss15_cluster_data.Rdata')
		                if (input$selectClusterNum=='c140'){
			                cluster_last=tss15_140cluster_lastColumn
			                cluster_density=tss15_140cluster_density                	
		                }else if(input$selectClusterNum=='c90'){
			                cluster_last=tss15_90cluster_lastColumn
			                cluster_density=tss15_90cluster_density
		                }else if(input$selectClusterNum=='c200'){
			                cluster_last=tss15_200cluster_lastColumn
			                cluster_density=tss15_200cluster_density
		                }else {
			                cluster_last=tss15_250cluster_lastColumn
			                cluster_density=tss15_250cluster_density
		                }
                    }
                    
                }else{
                    if (input$selectState=="enhancer"){
                    	load('Rdata/enh18_cluster_data.Rdata')                    	
		                if (input$selectClusterNum=='c140'){
			                cluster_last=enh18_140cluster_lastColumn
			                cluster_density=enh18_140cluster_density                	
		                }else if(input$selectClusterNum=='c90'){
			                cluster_last=enh18_90cluster_lastColumn
			                cluster_density=enh18_90cluster_density
		                }else if(input$selectClusterNum=='c200'){
			                cluster_last=enh18_200cluster_lastColumn
			                cluster_density=enh18_200cluster_density
		                }else {
			                cluster_last=enh18_250cluster_lastColumn
			                cluster_density=enh18_250cluster_density
		                }

                    }else{
                    	load('Rdata/tss18_cluster_data.Rdata') 
		                if (input$selectClusterNum=='c140'){
			                cluster_last=tss18_140cluster_lastColumn
			                cluster_density=tss18_140cluster_density                	
		                }else if(input$selectClusterNum=='c90'){
			                cluster_last=tss18_90cluster_lastColumn
			                cluster_density=tss18_90cluster_density
		                }else if(input$selectClusterNum=='c200'){
			                cluster_last=tss18_200cluster_lastColumn
			                cluster_density=tss18_200cluster_density
		                }else {
			                cluster_last=tss18_250cluster_lastColumn
			                cluster_density=tss18_250cluster_density
		                }
                    }
                }

            }else if (input$selectFeature=='H3K27ac'){
                load('Rdata/H3K27ac_cluster_data.Rdata')
                if (input$selectClusterNum=='c140'){
	                cluster_last=H3K27ac_140cluster_lastColumn
	                cluster_density=H3K27ac_140cluster_density                	
                }else if(input$selectClusterNum=='c90'){
	                cluster_last=H3K27ac_90cluster_lastColumn
	                cluster_density=H3K27ac_90cluster_density
                }else if(input$selectClusterNum=='c200'){
	                cluster_last=H3K27ac_200cluster_lastColumn
	                cluster_density=H3K27ac_200cluster_density
                }else {
	                cluster_last=H3K27ac_250cluster_lastColumn
	                cluster_density=H3K27ac_250cluster_density
                }

            }else if (input$selectFeature=='H3K4me1'){
                load('Rdata/H3K4me1_cluster_data.Rdata')
                if (input$selectClusterNum=='c140'){
	                cluster_last=H3K4me1_140cluster_lastColumn
	                cluster_density=H3K4me1_140cluster_density                	
                }else if(input$selectClusterNum=='c90'){
	                cluster_last=H3K4me1_90cluster_lastColumn
	                cluster_density=H3K4me1_90cluster_density
                }else if(input$selectClusterNum=='c200'){
	                cluster_last=H3K4me1_200cluster_lastColumn
	                cluster_density=H3K4me1_200cluster_density
                }else {
	                cluster_last=H3K4me1_250cluster_lastColumn
	                cluster_density=H3K4me1_250cluster_density
                }

            }else if (input$selectFeature=='H3K4me3'){
                load('Rdata/H3K4me3_cluster_data.Rdata')
                if (input$selectClusterNum=='c140'){
	                cluster_last=H3K4me3_140cluster_lastColumn
	                cluster_density=H3K4me3_140cluster_density                	
                }else if(input$selectClusterNum=='c90'){
	                cluster_last=H3K4me3_90cluster_lastColumn
	                cluster_density=H3K4me3_90cluster_density
                }else if(input$selectClusterNum=='c200'){
	                cluster_last=H3K4me3_200cluster_lastColumn
	                cluster_density=H3K4me3_200cluster_density
                }else {
	                cluster_last=H3K4me3_250cluster_lastColumn
	                cluster_density=H3K4me3_250cluster_density
                }

            }else{
                load('Rdata/H3K27me3_cluster_data.Rdata')
                if (input$selectClusterNum=='c140'){
	                cluster_last=H3K27me3_140cluster_lastColumn
	                cluster_density=H3K27me3_140cluster_density                	
                }else if(input$selectClusterNum=='c90'){
	                cluster_last=H3K27me3_90cluster_lastColumn
	                cluster_density=H3K27me3_90cluster_density
                }else if(input$selectClusterNum=='c200'){
	                cluster_last=H3K27me3_200cluster_lastColumn
	                cluster_density=H3K27me3_200cluster_density
                }else {
	                cluster_last=H3K27me3_250cluster_lastColumn
	                cluster_density=H3K27me3_250cluster_density
                }

            } 
        }



        #cutoff method
        if (input$selectMethod=="cutoff"){
            forePer=foreSum/len_fore()
            if (len_back()>0){
                backPer=backSum/len_back()
                diff=round(forePer-backPer,3)
                logic=forePer>=input$foreCutoff & backPer<= input$backCutoff 
            }else{
                diff=round(forePer,3)
                logic=forePer>=input$foreCutoff 
            }
            final_data=cbind(sample_logic[logic,1:3],diff[logic])
            len_final=dim(final_data)[2]
            final_data=final_data[order(-final_data[,len_final]),]
            names(final_data)[len_final]="rank"
            rm(sample_logic)
            rm(list=setdiff(ls(), "final_data"))
            gc()
       
        #fisher method
        }else if (input$selectMethod=="fisher"){
            fore_zeroN=len_fore()-foreSum
            back_zeroN=len_back()-backSum
            combine=cbind(foreSum,fore_zeroN,backSum,back_zeroN)
            combine=combine[foreSum>0,]
            #parallel computing
            library(parallel)
            cl <- makeCluster(10)
            p_value=parApply(cl,combine,1,myfun)
            stopCluster(cl)
            q_value=p.adjust(p_value,"BH")
            final_data=cbind(sample_logic[foreSum>0,][q_value<input$fisherCutoff,1:3],q_value[q_value<input$fisherCutoff])
            len_final=dim(final_data)[2]
            final_data=final_data[order(final_data[,len_final]),]
            names(final_data)[len_final]="rank"
            rm(sample_logic)
            rm(list=setdiff(ls(), "final_data"))
            gc()

        #cluster method
        }else {
            final_data=data.frame(chr=character(),start=character(),end=character())        
            cluster_Name=get_cluster(fore$data,back$data,cluster_density,input$clusterQuantile/100,input$clusterCutoff)
            if (length(cluster_Name)>0){
                logic=get_regions(cluster_last,cluster_Name)
                final_data=sample_logic[logic,c(1:3)]
            }
                  
            rm(cluster_last,cluster_density)
            rm(list=setdiff(ls(), "final_data"))
            gc()
        } #end of all methods

        rm(list=setdiff(ls(), "final_data"))
        gc()
        final_data

    }) #end of table

	#write identified regions into disk and merge them for linking to GREAT tool
    outfile <-reactive({
        #added by Yu on 01/22/2017 to save merged file for great analysis
        outfile_name=paste('outfile',sample(c(1:10000),1),'.txt',sep='')
        write.table(table(), paste('www/write_to_disk/',outfile_name,sep=''), row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')
        cat(outfile_name,file='www/write_to_disk/outfile_name.txt') 

        #sort file
        write.table(table(), 'www/write_to_disk/outdata', row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')
        cmd=paste('sort -k1,1 -k2,2n  www/write_to_disk/outdata > www/write_to_disk/outdata_sort')
        system(cmd)

        #added by Yu on 01/22/2017 to save merged file for great analysis
        output$linkMergeGreat<-renderUI({
            filename=read.table('www/write_to_disk/outfile_name.txt',header=F)
            filename2=paste('www/write_to_disk/','merge_',filename[[1]],sep='')
            filename2_base=paste('merge_',filename[[1]],sep='')
            #write.table(filename2, 'www/write_to_disk/testFile2.txt', row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')
            cmd=paste('www/bedtools','merge','-i','www/write_to_disk/outdata_sort','>',filename2)
            system(cmd)
            mergelink=paste('http://epigenome.wustl.edu/epicompare/datahubs/',filename2_base,sep='')
            greatlink=paste('http://bejerano.stanford.edu/great/public/cgi-bin/greatStart.php?requestURL=http://epigenome.wustl.edu/epicompare/datahubs/',filename2_base,'&requestSpecies=hg19',sep='')
            #write.table(mylink, 'www/write_to_disk/testFile.txt', row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')
            tagList(
                HTML('<br><br>'),
                tags$a(href = mergelink, "Link to merged data"),
                HTML('<br><br>'),
                tags$a(href = greatlink, "Link to GREAT tool with merged data as input")
            )
        })
        # rm(list=setdiff(ls()))
        # gc()    
            #            
        'www/write_to_disk/outdata_sort'
    })#end of outfile

	#output rank information for all regions identified
    output$summary_rank <- renderPrint({
        validate(
            need(input$selectMethod != 'cluster', "No summary for K-means clustering method")
        )
        cat('Total number of regions identified:',dim(table())[1],sep=' ')
        cat('\n','\n')
        cat('Summary of rank for all regions identified:','\n')
        print(summary(table()[,4]))
        # rm(list=setdiff(ls()))
        # gc() 
    })

    #render image1 (plot enrichment for H3K27ac peaks)
    output$image1 <- renderPlot({
        validate(need(dim(table())[1] != 0, "No regions are identified"))
        session$sendCustomMessage("barProgress", list(40,'H3K27ac enrichment analysis'))
        print('plot image1')
        target_file=outfile()
        feature_folder='H3K27ac_peak_sort'
        data=cal_enrichment(target_file,fore$data,back$data)
        validate(need(dim(data)[1] != 0, "No regions overlap H3K27ac peaks."))
        print('done with image1')


        output$H3K27ac_enrich_download <- downloadHandler(
            filename = function() { 'H3K27ac_enrich.txt' },   
            content = function(file) {
            write.table(data, file, row.names=FALSE,col.names=TRUE,quote=FALSE,sep='\t')
        })
       
        rm(list=setdiff(ls(), "data"))
        gc()
    }, width=800, height=400)#end of render image1


    #start of image2 (plot ctm distribution on H3K27ac)
    output$image4<-renderPlot({
        fore_sam_k27=c()
        for (x in fore$data){
            if (is.element(x, sample_list98)){
                fore_sam_k27=c(fore_sam_k27,x)
            }
        }
        validate(need(dim(table())[1] != 0, "No regions are identified"))
        validate(need(length(fore_sam_k27) >0, "All foreground samples do not have H3K27ac data for the analysis"))
        session$sendCustomMessage("barProgress", list(70,'Tissue enrichment index analysis on H3K27ac'))
        load('Rdata/H3K27ac_RPKM.Rdata')

        back_sam_k27=c()
        for (x in back$data){
            if (is.element(x, sample_list98)){
                back_sam_k27=c(back_sam_k27,x)
            }
        }

        cmd1=paste('www/bedtools','intersect','-a',H3K27ac_rpkm_path,'-b',outfile(),'-c','-sorted','>www/write_to_disk/H3K27ac_rpkm_coord_intersect_output.txt')
        system(cmd1)
        intersect_mark=as.data.frame(fread('www/write_to_disk/H3K27ac_rpkm_coord_intersect_output.txt',header=F))
        H3K27ac_RPKM_intersect=H3K27ac_RPKM[intersect_mark[,4]==1,]
        validate(need(dim(H3K27ac_RPKM_intersect)[1] != 0, "No regions overlap H3K27ac peaks."))
        outdata=intersect_plot(H3K27ac_RPKM_intersect,fore_sam_k27,back_sam_k27,'H3K27ac_ctm')

                       
        output$CTM_H3K27ac_download <- downloadHandler(
            filename = function() { 'CTM_H3K27ac.txt' },   
            content = function(file) {
            write.table(outdata, file, row.names=FALSE,col.names=TRUE,quote=FALSE,sep='\t')
        })
        rm(list=setdiff(ls(), "outdata"))
        gc()
    }, width=800, height=400)#end of image2      


    #output table
    output$table1 <- renderDataTable({    
        mytable<-table()
        print('output table')
        mytable$epigenome_browser <- createLink(mytable$chr,mytable$start,mytable$end)
        print('done with output table')
        session$sendCustomMessage("download_ready", list())
        session$sendCustomMessage("finish_processing", list())
        session$sendCustomMessage("result_ready", list())    
        session$sendCustomMessage("hideProgress", list())      
        rm(list=setdiff(ls(), "mytable"))
        gc()
        mytable
      
    }, options = list(sDom  = '<"top">lrt<"bottom">ip'),escape = FALSE)


    #download table
    output$data_file <- downloadHandler(
        filename = function() { paste('data', '.txt', sep='') },   
        content = function(file) {
            write.table(table(), file, row.names=FALSE,col.names=FALSE,quote=FALSE,sep='\t')
    })

}#end of server


