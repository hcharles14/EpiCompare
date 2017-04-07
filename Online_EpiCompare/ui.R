library(shiny)
options(shiny.trace=TRUE)
ui<-navbarPage(
    # Application title
    id = "navBarPageID",
    title = "EpiCompare",

    tabPanel(
        'Home',

        tags$style(
            HTML("     
                .selectButton {
                    font-size: 12px;
                }

                #noSubmit,#loadData {
                    color: red;
                }

                .btn1 {
                    position: absolute;
                    left: 50%;
                }

                div.shiny-options-group {
                    width: 600px;
                    border-style: none;
                }

                div.checkbox {
                    position: relative;
                    left: 15%;
                }

                h4.title_pos2 {
                    position: relative;
                    left: 2%;
                }

                .shiny-progress-container {
                    top: 200px;
                }

                .shiny-progress .bar {
                    background-color: #FF0000;
                    .opacity = 0.8;
                }

                .shiny-progress .progress {
                  height:7px;
                }

                .shiny-progress .progress-text {
                    position: absolute;
                    left: 20%;
                    height: 50px;
                    width: 60%;
                    background-color:  transparent;
                    margin: 0px;
                    padding: 2px 3px;
                    opacity: 0.85;
                }

                .shiny-progress .progress-text .progress-message {
                  padding: 0px 3px;
                  font-weight: bold;
                  font-size: 24px;

                }

                .shiny-progress .progress-text .progress-detail {
                  padding: 0px 3px;
                  font-size: 24px;

                }

                #myProgress {
                    position: relative;
                    width: 100%;
                    height: 30px;
                    background-color: #ddd;
                }

                #myBar {
                    position: absolute;
                    width: 1%;
                    height: 100%;
                    background-color: #4CAF50;
                }

                #spin_bar {
                    position: absolute;
                    left: 50%;
                    top: 50%;
                    z-index: -1;
                    margin-top: -33px;  /* half of the spinner's height */
                    margin-left: -33px; /* half of the spinner's width */
                }

                #label {
                    text-align: center;
                    line-height: 30px;
                    color: black;
                }

                table, th, td {
                    border: 1px solid black;
                    border-collapse: collapse;
                }
                th, td {
                    padding: 5px;
                }
            ")#end of html
        ),#end of style


        column(10,offset=1,
            radioButtons("selectFeature", "1. Select a feature:",inline = TRUE,width = '50%',c("ChromHMM" ,"H3K27ac", "H3K4me1", "H3K4me3", "H3K27me3" )),
            #HTML(' <br> <label>select features:</label>'),
            conditionalPanel(condition = "input.selectFeature == 'ChromHMM'",
                radioButtons("selectState", "Select enhancer or promoter:",inline = TRUE,width = '50%',
                                   c("enhancer" ,
                                      "promoter" )
                ),
                radioButtons("selectHMM", "Select ChromHMM model:",inline = TRUE,width = '50%',
                            c("18 state"="18 model" ,
                              "15 state"="15 model" )
                )
            ),


            HTML('
              <br>
              <label>2. Upload and process users data:</label>
            '),
            HTML('<span class="help-block"> Skip this step if you don\'t want to use your own data. The files must have only three columns (chromosome, start, end) specifying the location of the feature. </span> '), 

            fluidRow(
                column(6,radioButtons("selectFile", "Number of files:",inline = TRUE,width = '50%',c("one","multiple")),
                    conditionalPanel(condition = "input.selectFile == 'one'",fileInput('file1', 'Choose one file',multiple = F,accept=c('text/csv', 'text/comma-separated-values,text/plain','.csv'))),
                    conditionalPanel(condition = "input.selectFile == 'multiple'",fileInput('file2', 'Choose multiple files',multiple = T,accept=c('text/csv', 'text/comma-separated-values,text/plain','.csv')))
                ),
                column(6,uiOutput("addSamples"),HTML('<font color="red" id="proAddSam">Uploading and processing files </font>'))
            ),

            conditionalPanel(condition = "input.selectFeature == 'ChromHMM'",
                fluidRow(
                    column(6,HTML('  
                        <p>
                        <br>
                        <label>3. Select foreground samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectFore" type="button" class="btn btn2 btn-default action-button" ><label>finish selection</label></button>
                        <pre id="summary1" class="shiny-text-output"></pre>
                        <br>
                        <label>4. Select background samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectBack" type="button" class="btn btn2 btn-default action-button"><label>finish selection</label></button>
                        <span class="help-block">Keep selected foreground samples in step 3 unchanged and select background samples. If background samples are not specified, the tool will identify shared enhancers for foreground samples.</span>
                        <pre id="summary2" class="shiny-text-output"></pre>
                        <br>
                        <label>5. Select features and samples for visualization in epigenome browser:</label>
                        <span class="help-block">If both features and samples are not chosen,  the default values for them will be used, which are the feature selected in step 1 and foreground samples selected in step 3.</span>


                        <div id="selectFeatureVis_hmm" style="width: 50%;" class="form-group shiny-input-checkboxgroup shiny-input-container shiny-input-container-inline shiny-bound-input">
                                    <label class="control-label" for="selectFeatureVis_hmm">Select features:</label>
                                    <div class="shiny-options-group">
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_hmm" value="ChromHMM15">
                                        <span>ChromHMM15</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_hmm" value="ChromHMM18">
                                        <span>ChromHMM18</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_hmm" value="H3K27ac">
                                        <span>H3K27ac</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_hmm" value="H3K4me1">
                                        <span>H3K4me1</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_hmm" value="H3K4me3">
                                        <span>H3K4me3</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_hmm" value="H3K27me3">
                                        <span>H3K27me3</span>
                                      </label>
                                    </div>
                                  </div>

                                    <label>Select samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectSampleVis_hmm" type="button" class="btn btn2 btn-default action-button" ><label>finish selection</label></button>
                                    <pre id="summary1Vis_hmm" class="shiny-text-output"></pre>
                                    <br> 


                                    </p>
                                    <br>')
                    ), #end of column 6

                    column(6,
                    conditionalPanel(condition = "input.selectHMM == '15 model'",
                        HTML('
                            <br>
                            
                            <span class="tab"></span> <button id="selectAll" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                            <br>
                        '),
                        HTML('

                            <br>
                            <div class="panel-group">
                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Adult_Tissue"> Adult Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Adult_Tissue" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Adult" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Blood_Adult" class="panel-collapse collapse"> 
                                        <div id="Blood_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E062"/>
                                                <span class="checkContent" >E062 Primary mononuclear cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E034"/>
                                                <span class="checkContent">E034 Primary T cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E045"/>
                                                <span class="checkContent">E045 Primary T cells effector/memory enriched from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E044"/>
                                                <span class="checkContent">E044 Primary T regulatory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E043"/>
                                                <span class="checkContent">E043 Primary T helper cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E039"/>
                                                <span class="checkContent">E039 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E041"/>
                                                <span class="checkContent">E041 Primary T helper cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E042"/>
                                                <span class="checkContent">E042 Primary T helper 17 cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E040"/>
                                                <span class="checkContent">E040 Primary T helper memory cells from peripheral blood 1</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E037"/>
                                                <span class="checkContent">E037 Primary T helper memory cells from peripheral blood 2</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E048"/>
                                                <span class="checkContent">E048 Primary T CD8+ memory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E038"/>
                                                <span class="checkContent">E038 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E047"/>
                                                <span class="checkContent">E047 Primary T CD8+ naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E029"/>
                                                <span class="checkContent">E029 Primary monocytes from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E035"/>
                                                <span class="checkContent">E035 Primary hematopoietic stem cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E051"/>
                                                <span class="checkContent">E051 Primary hematopoietic stem cells G-CSF-mobilized Male</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E050"/>
                                                <span class="checkContent">E050 Primary hematopoietic stem cells G-CSF-mobilized Female</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E036"/>
                                                <span class="checkContent">E036 Primary hematopoietic stem cells short term culture</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E032"/>
                                                <span class="checkContent">E032 Primary B cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E046"/>
                                                <span class="checkContent">E046 Primary Natural Killer cells from peripheral blood</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E030"/>
                                                <span class="checkContent">E030 Primary neutrophils from peripheral blood</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult" value="E124"/>
                                                <span class="checkContent">E124 Monocytes-CD14+ RO01746 Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Adult" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Brain_Adult" class="panel-collapse collapse"> 
                                        <div id="Brain_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult" value="E071"/>
                                                <span class="checkContent">E071 Brain Hippocampus Middle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult" value="E074"/>
                                                <span class="checkContent">E074 Brain Substantia Nigra</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult" value="E068"/>
                                                <span class="checkContent">E068 Brain Anterior Caudate</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult" value="E069"/>
                                                <span class="checkContent">E069 Brain Cingulate Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult" value="E072"/>
                                                <span class="checkContent">E072 Brain Inferior Temporal Lobe</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult" value="E067"/>
                                                <span class="checkContent">E067 Brain Angular Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult" value="E073"/>
                                                <span class="checkContent">E073 Brain_Dorsolateral_Prefrontal_Cortex</span>
                                              </label>
                                            </div>                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>
                           

                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Breast_Adult" >Breast <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Breast_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Breast_Adult" class="panel-collapse collapse"> 
                                        <div id="Breast_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Adult" value="E027"/>
                                                <span class="checkContent">E027 Breast Myoepithelial Primary Cells</span>
                                              </label>
                                            </div>
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Fat_Adult" >Fat <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Fat_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Fat_Adult" class="panel-collapse collapse"> 
                                        <div id="Fat_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Adult" value="E063"/>
                                                <span class="checkContent">E063 Adipose Nuclei</span>
                                              </label>
                                            </div>
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Colon_Adult" >GI_Colon <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Colon_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Colon_Adult" class="panel-collapse collapse"> 
                                        <div id="GI_Colon_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult" value="E076"/>
                                                <span class="checkContent">E076 Colon Smooth Muscle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult" value="E106"/>
                                                <span class="checkContent">E106 Sigmoid Colon</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult" value="E075"/>
                                                <span class="checkContent">E075 Colonic Mucosa</span>
                                              </label>
                                            </div>                                    
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Duodenum_Adult" >GI_Duodenum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Duodenum_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Duodenum_Adult" class="panel-collapse collapse"> 
                                        <div id="GI_Duodenum_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Duodenum_Adult" value="E078"/>
                                                <span class="checkContent">E078 Duodenu</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Duodenum_Adult" value="E077"/>
                                                <span class="checkContent">E077 Duodenum Mucosa</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Esophagus_Adult" >GI_Esophagus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Esophagus_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Esophagus_Adult" class="panel-collapse collapse"> 
                                        <div id="GI_Esophagus_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Esophagus_Adult" value="E079"/>
                                                <span class="checkContent">E079 Esophagus</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Adult" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Adult" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Adult" value="E109"/>
                                                <span class="checkContent">E109 Small Intestin</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Rectum_Adult" >GI_Rectum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Rectum_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Rectum_Adult" class="panel-collapse collapse"> 
                                        <div id="GI_Rectum_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult" value="E103"/>
                                                <span class="checkContent">E103 Rectal Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult" value="E101"/>
                                                <span class="checkContent">E101 Rectal Mucosa Donor 29</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult" value="E102"/>
                                                <span class="checkContent">E102 Rectal Mucosa Donor 31</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Adult" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Adult" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult" value="E111"/>
                                                <span class="checkContent">E111 Stomach Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult" value="E110"/>
                                                <span class="checkContent">E110 Stomach Mucosa</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult" value="E094"/>
                                                <span class="checkContent">E094 Gastric</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Heart_Adult" >Heart <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Heart_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Heart_Adult" class="panel-collapse collapse"> 
                                        <div id="Heart_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult" value="E104"/>
                                                <span class="checkContent">E104 Right Atrium</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult" value="E095"/>
                                                <span class="checkContent">E095 Left Ventricle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult" value="E105"/>
                                                <span class="checkContent">E105 Right Ventricle</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_Adult" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_Adult" class="panel-collapse collapse"> 
                                        <div id="Liver_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_Adult" value="E066"/>
                                                <span class="checkContent">E066 Liver</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Adult" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Adult" class="panel-collapse collapse"> 
                                        <div id="Lung_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Adult" value="E096"/>
                                                <span class="checkContent">E096 Lung</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Adult" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Adult" class="panel-collapse collapse"> 
                                        <div id="Muscle_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult" value="E100"/>
                                                <span class="checkContent">E100 Psoas Muscle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult" value="E108"/>
                                                <span class="checkContent">E108 Skeletal Muscle Female</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult" value="E107"/>
                                                <span class="checkContent">E107 Skeletal Muscle Male</span>
                                              </label>
                                            </div>                                                                                                           
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Ovary_Adult" >Ovary <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Ovary_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Ovary_Adult" class="panel-collapse collapse"> 
                                        <div id="Ovary_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Ovary_Adult" value="E097"/>
                                                <span class="checkContent">E097 Ovary</span>
                                              </label>
                                            </div>                                                                                                            
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Pancreas_Adult" >Pancreas <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Pancreas_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Pancreas_Adult" class="panel-collapse collapse"> 
                                        <div id="Pancreas_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult" value="E087"/>
                                                <span class="checkContent">E087 Pancreatic Islets</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult" value="E098"/>
                                                <span class="checkContent">E098 Pancreas</span>
                                              </label>
                                            </div>                                                                                                                           
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Spleen_Adult" >Spleen <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Spleen_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Spleen_Adult" class="panel-collapse collapse"> 
                                        <div id="Spleen_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Spleen_Adult" value="E113"/>
                                                <span class="checkContent">E113 Spleen</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Adult" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Adult" class="panel-collapse collapse"> 
                                        <div id="Thymus_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Adult" value="E112"/>
                                                <span class="checkContent">E112 Thymus</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Adult" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Adult" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Adult" class="panel-collapse collapse"> 
                                        <div id="Vascular_Adult" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Adult" value="E065"/>
                                                <span class="checkContent">E065 Aorta</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Fetal_Tissue"> Fetal Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Fetal_Tissue" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Adrenal_Fetal" >Adrenal <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Adrenal_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Adrenal_Fetal" class="panel-collapse collapse"> 
                                        <div id="Adrenal_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Adrenal_Fetal" value="E080"/>
                                                <span class="checkContent">E080 Fetal Adrenal Gland</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Fetal" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_Fetal" class="panel-collapse collapse"> 
                                        <div id="Blood_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Fetal" value="E033"/>
                                                <span class="checkContent">E033 Primary T cells from cord blood</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Fetal" value="E031"/>
                                                <span class="checkContent">E031 Primary B cells from cord blood</span>
                                              </label>
                                            </div>                                                                                                                                            
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Fetal" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Brain_Fetal" class="panel-collapse collapse"> 
                                        <div id="Brain_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal" value="E070"/>
                                                <span class="checkContent">E070 Brain Germinal Matrix</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal" value="E082"/>
                                                <span class="checkContent">E082 Fetal Brain Female</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal" value="E081"/>
                                                <span class="checkContent">E081 Fetal Brain Male</span>
                                              </label>
                                            </div>                                                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Fetal" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Fetal" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal" value="E085"/>
                                                <span class="checkContent">E085 Fetal Intestine Small</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal" value="E084"/>
                                                <span class="checkContent">E084 Fetal Intestine Large</span>
                                              </label>
                                            </div>                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Fetal" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Fetal" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Fetal" value="E092"/>
                                                <span class="checkContent">E092 Fetal Stomach</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Heart_Fetal" >Heart <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Heart_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Heart_Fetal" class="panel-collapse collapse"> 
                                        <div id="Heart_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Fetal" value="E083"/>
                                                <span class="checkContent">E083 Fetal Heart</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Kidney_Fetal" >Kidney <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Kidney_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Kidney_Fetal" class="panel-collapse collapse"> 
                                        <div id="Kidney_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Kidney_Fetal" value="E086"/>
                                                <span class="checkContent">E086 Fetal Kidney</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Fetal" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Fetal" class="panel-collapse collapse"> 
                                        <div id="Lung_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Fetal" value="E088"/>
                                                <span class="checkContent">E088 Fetal Lung</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Fetal" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Fetal" class="panel-collapse collapse"> 
                                        <div id="Muscle_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal" value="E089"/>
                                                <span class="checkContent">E089 Fetal Muscle Trunk</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal" value="E090"/>
                                                <span class="checkContent">E090 Fetal Muscle Leg</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href= "#collapse_Placenta_Fetal" >Placenta <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Placenta_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Placenta_Fetal" class="panel-collapse collapse"> 
                                        <div id="Placenta_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal" value="E099"/>
                                                <span class="checkContent">E099 Placenta Amnion</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal" value="E091"/>
                                                <span class="checkContent">E091 Placenta</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Fetal" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Fetal" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Fetal" class="panel-collapse collapse"> 
                                        <div id="Thymus_Fetal" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Fetal" value="E093"/>
                                                <span class="checkContent">E093 Fetal Thymus</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                        

                                                                          
                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Culture"> Primary Cultures <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Culture" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Culture" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_Culture" class="panel-collapse collapse"> 
                                        <div id="Blood_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture" value="E116"/>
                                                <span class="checkContent">E116 GM12878 Lymphoblastoid Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture" value="E123"/>
                                                <span class="checkContent">E123 K562 Leukemia Cells</span>
                                              </label>
                                            </div>                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Bone_Culture" >Bone <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Bone_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Bone_Culture" class="panel-collapse collapse"> 
                                        <div id="Bone_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Bone_Culture" value="E129"/>
                                                <span class="checkContent">E129 Osteoblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Culture" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Brain_Culture" class="panel-collapse collapse"> 
                                        <div id="Brain_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture" value="E054"/>
                                                <span class="checkContent">E054 Ganglion Eminence derived primary cultured neurospheres</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture" value="E053"/>
                                                <span class="checkContent">E053 Cortex derived primary cultured neurospheres</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture" value="E125"/>
                                                <span class="checkContent">E125 NH-A Astrocytes Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Breast_Culture" >Breast <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Breast_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Breast_Culture" class="panel-collapse collapse"> 
                                        <div id="Breast_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Culture" value="E028"/>
                                                <span class="checkContent">E028 Breast variant Human Mammary Epithelial Cells (vHMEC)</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Culture" value="E119"/>
                                                <span class="checkContent">E119 HMEC Mammary Epithelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Culture" >ESC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Culture" class="panel-collapse collapse"> 
                                        <div id="ESC_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture" value="E002"/>
                                                <span class="checkContent">E002 ES-WA7 Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture" value="E008"/>
                                                <span class="checkContent">E008 H9 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture" value="E001"/>
                                                <span class="checkContent">E001 ES-I3 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture" value="E015"/>
                                                <span class="checkContent">E015 HUES6 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture" value="E014"/>
                                                <span class="checkContent">E014 HUES48 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture" value="E016"/>
                                                <span class="checkContent">E016 HUES64 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture" value="E003"/>
                                                <span class="checkContent">E003 H1 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture" value="E024"/>
                                                <span class="checkContent">E024 ES-UCSF4  Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Derived_Culture" >ESC_Derived <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Derived_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Derived_Culture" class="panel-collapse collapse"> 
                                        <div id="ESC_Derived_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture" value="E007"/>
                                                <span class="checkContent">E007 H1 Derived Neuronal Progenitor Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture" value="E009"/>
                                                <span class="checkContent">E009 H9 Derived Neuronal Progenitor Cultured Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture" value="E010"/>
                                                <span class="checkContent">E010 H9 Derived Neuron Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture" value="E013"/>
                                                <span class="checkContent">E013 hESC Derived CD56+ Mesoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture" value="E012"/>
                                                <span class="checkContent">E012 hESC Derived CD56+ Ectoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture" value="E011"/>
                                                <span class="checkContent">E011 hESC Derived CD184+ Endoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture" value="E004"/>
                                                <span class="checkContent">E004 H1 BMP4 Derived Mesendoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture" value="E005"/>
                                                <span class="checkContent">E005 H1 BMP4 Derived Trophoblast Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture" value="E006"/>
                                                <span class="checkContent">E006 H1 Derived Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Fat_Culture" >Fat <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Fat_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Fat_Culture" class="panel-collapse collapse"> 
                                        <div id="Fat_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Culture" value="E025"/>
                                                <span class="checkContent">E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Culture" value="E023"/>
                                                <span class="checkContent">E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_IPSC_Culture" >IPSC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_IPSC_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_IPSC_Culture" class="panel-collapse collapse"> 
                                        <div id="IPSC_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture" value="E020"/>
                                                <span class="checkContent">E020 iPS-20b Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture" value="E019"/>
                                                <span class="checkContent">E019 iPS-18 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture" value="E018"/>
                                                <span class="checkContent">E018 iPS-15b Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture" value="E021"/>
                                                <span class="checkContent">E021 iPS DF 6.9 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture" value="E022"/>
                                                <span class="checkContent">E022 iPS DF 19.11 Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Culture" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Culture" class="panel-collapse collapse"> 
                                        <div id="Lung_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Culture" value="E128"/>
                                                <span class="checkContent">E128 NHLF Lung Fibroblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Culture" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Culture" class="panel-collapse collapse"> 
                                        <div id="Muscle_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture" value="E052"/>
                                                <span class="checkContent">E052 Muscle Satellite Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture" value="E120"/>
                                                <span class="checkContent">E120 HSMM Skeletal Muscle Myoblasts Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture" value="E121"/>
                                                <span class="checkContent">E121 HSMM cell derived Skeletal Muscle Myotubes Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Skin_Culture" >Skin <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Skin_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Skin_Culture" class="panel-collapse collapse"> 
                                        <div id="Skin_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture" value="E055"/>
                                                <span class="checkContent">E055 Foreskin Fibroblast Primary Cells skin01</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture" value="E056"/>
                                                <span class="checkContent">E056 Foreskin Fibroblast Primary Cells skin02</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture" value="E059"/>
                                                <span class="checkContent">E059 Foreskin Melanocyte Primary Cells skin01</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture" value="E061"/>
                                                <span class="checkContent">E061 Foreskin Melanocyte Primary Cells skin03</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture" value="E057"/>
                                                <span class="checkContent">E057 Foreskin Keratinocyte Primary Cells skin02</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture" value="E058"/>
                                                <span class="checkContent">E058 Foreskin Keratinocyte Primary Cells skin03</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture" value="E126"/>
                                                <span class="checkContent">E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture" value="E127"/>
                                                <span class="checkContent">E127 NHEK-Epidermal Keratinocyte Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Stromal_Connective_Culture" >Stromal_Connective <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Stromal_Connective_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Stromal_Connective_Culture" class="panel-collapse collapse"> 
                                        <div id="Stromal_Connective_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture" value="E026"/>
                                                <span class="checkContent">E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture" value="E049"/>
                                                <span class="checkContent">E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Culture" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Culture" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Culture" class="panel-collapse collapse"> 
                                        <div id="Vascular_Culture" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Culture" value="E122"/>
                                                <span class="checkContent">E122 HUVEC Umbilical Vein Endothelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                                                                                        


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_CellLine"> Cell Lines <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_CellLine" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_CellLine" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_CellLine" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_CellLine" class="panel-collapse collapse"> 
                                        <div id="Blood_CellLine" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_CellLine" value="E115"/>
                                                <span class="checkContent">E115 Dnd41 TCell Leukemia Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Cervix_CellLine" >Cervix <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Cervix_CellLine" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Cervix_CellLine" class="panel-collapse collapse"> 
                                        <div id="Cervix_CellLine" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Cervix_CellLine" value="E117"/>
                                                <span class="checkContent">E117 HeLa-S3 Cervical Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_CellLine" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_CellLine" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_CellLine" class="panel-collapse collapse"> 
                                        <div id="Liver_CellLine" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_CellLine" value="E118"/>
                                                <span class="checkContent">E118 HepG2 Hepatocellular Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_CellLine" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_CellLine" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_CellLine" class="panel-collapse collapse"> 
                                        <div id="Lung_CellLine" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine" value="E017"/>
                                                <span class="checkContent">E017 IMR90 fetal lung fibroblasts Cell Line</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine" value="E114"/>
                                                <span class="checkContent">E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                


                                </div> 
                              </div>


                            </div>
                           
                        ')
                    ),#end of conditionalpanel
                    conditionalPanel(condition = "input.selectHMM == '18 model'",
                        HTML('
                          <br>
                          
                          <span class="tab"></span> <button id="selectAll_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                          <br>
                          '),
                        HTML('

                            <br>
                            <div class="panel-group">
                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Adult_Tissue_18"> Adult Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Adult_Tissue_18" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Adult_18" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Blood_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Blood_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E062"/>
                                                <span class="checkContent">E062 Primary mononuclear cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E034"/>
                                                <span class="checkContent">E034 Primary T cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E045"/>
                                                <span class="checkContent">E045 Primary T cells effector/memory enriched from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E044"/>
                                                <span class="checkContent">E044 Primary T regulatory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E043"/>
                                                <span class="checkContent">E043 Primary T helper cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E039"/>
                                                <span class="checkContent">E039 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E041"/>
                                                <span class="checkContent">E041 Primary T helper cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E042"/>
                                                <span class="checkContent">E042 Primary T helper 17 cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E040"/>
                                                <span class="checkContent">E040 Primary T helper memory cells from peripheral blood 1</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E037"/>
                                                <span class="checkContent">E037 Primary T helper memory cells from peripheral blood 2</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E048"/>
                                                <span class="checkContent">E048 Primary T CD8+ memory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E038"/>
                                                <span class="checkContent">E038 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E047"/>
                                                <span class="checkContent">E047 Primary T CD8+ naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E029"/>
                                                <span class="checkContent">E029 Primary monocytes from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E050"/>
                                                <span class="checkContent">E050 Primary hematopoietic stem cells G-CSF-mobilized Female</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E032"/>
                                                <span class="checkContent">E032 Primary B cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E046"/>
                                                <span class="checkContent">E046 Primary Natural Killer cells from peripheral blood</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_18" value="E124"/>
                                                <span class="checkContent">E124 Monocytes-CD14+ RO01746 Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Adult_18" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Brain_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Brain_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_18" value="E071"/>
                                                <span class="checkContent">E071 Brain Hippocampus Middle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_18" value="E074"/>
                                                <span class="checkContent">E074 Brain Substantia Nigra</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_18" value="E068"/>
                                                <span class="checkContent">E068 Brain Anterior Caudate</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_18" value="E069"/>
                                                <span class="checkContent">E069 Brain Cingulate Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_18" value="E072"/>
                                                <span class="checkContent">E072 Brain Inferior Temporal Lobe</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_18" value="E067"/>
                                                <span class="checkContent">E067 Brain Angular Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_18" value="E073"/>
                                                <span class="checkContent">E073 Brain_Dorsolateral_Prefrontal_Cortex</span>
                                              </label>
                                            </div>                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Fat_Adult_18" >Fat <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Fat_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Fat_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Fat_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Adult_18" value="E063"/>
                                                <span class="checkContent">E063 Adipose Nuclei</span>
                                              </label>
                                            </div>
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Colon_Adult_18" >GI_Colon <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Colon_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Colon_Adult_18" class="panel-collapse collapse"> 
                                        <div id="GI_Colon_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_18" value="E076"/>
                                                <span class="checkContent">E076 Colon Smooth Muscle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_18" value="E106"/>
                                                <span class="checkContent">E106 Sigmoid Colon</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_18" value="E075"/>
                                                <span class="checkContent">E075 Colonic Mucosa</span>
                                              </label>
                                            </div>                                    
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Duodenum_Adult_18" >GI_Duodenum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Duodenum_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Duodenum_Adult_18" class="panel-collapse collapse"> 
                                        <div id="GI_Duodenum_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Duodenum_Adult_18" value="E078"/>
                                                <span class="checkContent">E078 Duodenu</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Esophagus_Adult_18" >GI_Esophagus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Esophagus_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Esophagus_Adult_18" class="panel-collapse collapse"> 
                                        <div id="GI_Esophagus_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Esophagus_Adult_18" value="E079"/>
                                                <span class="checkContent">E079 Esophagus</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Adult_18" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Adult_18" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Adult_18" value="E109"/>
                                                <span class="checkContent">E109 Small Intestin</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Rectum_Adult_18" >GI_Rectum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Rectum_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Rectum_Adult_18" class="panel-collapse collapse"> 
                                        <div id="GI_Rectum_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_18" value="E103"/>
                                                <span class="checkContent">E103 Rectal Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_18" value="E101"/>
                                                <span class="checkContent">E101 Rectal Mucosa Donor 29</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_18" value="E102"/>
                                                <span class="checkContent">E102 Rectal Mucosa Donor 31</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Adult_18" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Adult_18" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_18" value="E111"/>
                                                <span class="checkContent">E111 Stomach Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_18" value="E094"/>
                                                <span class="checkContent">E094 Gastric</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Heart_Adult_18" >Heart <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Heart_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Heart_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Heart_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_18" value="E104"/>
                                                <span class="checkContent">E104 Right Atrium</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_18" value="E095"/>
                                                <span class="checkContent">E095 Left Ventricle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_18" value="E105"/>
                                                <span class="checkContent">E105 Right Ventricle</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_Adult_18" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Liver_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_Adult_18" value="E066"/>
                                                <span class="checkContent">E066 Liver</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Adult_18" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Lung_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Adult_18" value="E096"/>
                                                <span class="checkContent">E096 Lung</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Adult_18" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Muscle_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_18" value="E100"/>
                                                <span class="checkContent">E100 Psoas Muscle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_18" value="E108"/>
                                                <span class="checkContent">E108 Skeletal Muscle Female</span>
                                              </label>
                                            </div>                                                                                                          
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Ovary_Adult_18" >Ovary <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Ovary_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Ovary_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Ovary_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Ovary_Adult_18" value="E097"/>
                                                <span class="checkContent">E097 Ovary</span>
                                              </label>
                                            </div>                                                                                                            
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Pancreas_Adult_18" >Pancreas <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Pancreas_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Pancreas_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Pancreas_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult_18" value="E087"/>
                                                <span class="checkContent">E087 Pancreatic Islets</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult_18" value="E098"/>
                                                <span class="checkContent">E098 Pancreas</span>
                                              </label>
                                            </div>                                                                                                                           
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Spleen_Adult_18" >Spleen <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Spleen_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Spleen_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Spleen_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Spleen_Adult_18" value="E113"/>
                                                <span class="checkContent">E113 Spleen</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Adult_18" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Thymus_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Adult_18" value="E112"/>
                                                <span class="checkContent">E112 Thymus</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Adult_18" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Adult_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Adult_18" class="panel-collapse collapse"> 
                                        <div id="Vascular_Adult_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Adult_18" value="E065"/>
                                                <span class="checkContent">E065 Aorta</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Fetal_Tissue_18"> Fetal Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Fetal_Tissue_18" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Adrenal_Fetal_18" >Adrenal <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Adrenal_Fetal_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Adrenal_Fetal_18" class="panel-collapse collapse"> 
                                        <div id="Adrenal_Fetal_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Adrenal_Fetal_18" value="E080"/>
                                                <span class="checkContent">E080 Fetal Adrenal Gland</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Fetal_18" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Fetal_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Fetal_18" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Fetal_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal_18" value="E085"/>
                                                <span class="checkContent">E085 Fetal Intestine Small</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal_18" value="E084"/>
                                                <span class="checkContent">E084 Fetal Intestine Large</span>
                                              </label>
                                            </div>                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Fetal_18" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Fetal_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Fetal_18" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Fetal_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Fetal_18" value="E092"/>
                                                <span class="checkContent">E092 Fetal Stomach</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Fetal_18" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Fetal_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Fetal_18" class="panel-collapse collapse"> 
                                        <div id="Muscle_Fetal_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal_18" value="E089"/>
                                                <span class="checkContent">E089 Fetal Muscle Trunk</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal_18" value="E090"/>
                                                <span class="checkContent">E090 Fetal Muscle Leg</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href= "#collapse_Placenta_Fetal_18" >Placenta <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Placenta_Fetal_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Placenta_Fetal_18" class="panel-collapse collapse"> 
                                        <div id="Placenta_Fetal_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal_18" value="E099"/>
                                                <span class="checkContent">E099 Placenta Amnion</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal_18" value="E091"/>
                                                <span class="checkContent">E091 Placenta</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Fetal_18" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Fetal_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Fetal_18" class="panel-collapse collapse"> 
                                        <div id="Thymus_Fetal_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Fetal_18" value="E093"/>
                                                <span class="checkContent">E093 Fetal Thymus</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                        

                                                                          
                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Culture_18"> Primary Cultures <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Culture_18" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Culture_18" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_Culture_18" class="panel-collapse collapse"> 
                                        <div id="Blood_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture_18" value="E116"/>
                                                <span class="checkContent">E116 GM12878 Lymphoblastoid Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture_18" value="E123"/>
                                                <span class="checkContent">E123 K562 Leukemia Cells</span>
                                              </label>
                                            </div>                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Bone_Culture_18" >Bone <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Bone_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Bone_Culture_18" class="panel-collapse collapse"> 
                                        <div id="Bone_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Bone_Culture_18" value="E129"/>
                                                <span class="checkContent">E129 Osteoblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Culture_18" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Brain_Culture_18" class="panel-collapse collapse"> 
                                        <div id="Brain_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_18" value="E125"/>
                                                <span class="checkContent">E125 NH-A Astrocytes Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Breast_Culture_18" >Breast <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Breast_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Breast_Culture_18" class="panel-collapse collapse"> 
                                        <div id="Breast_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Culture_18" value="E119"/>
                                                <span class="checkContent">E119 HMEC Mammary Epithelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Culture_18" >ESC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Culture_18" class="panel-collapse collapse"> 
                                        <div id="ESC_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_18" value="E008"/>
                                                <span class="checkContent">E008 H9 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_18" value="E015"/>
                                                <span class="checkContent">E015 HUES6 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_18" value="E014"/>
                                                <span class="checkContent">E014 HUES48 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_18" value="E016"/>
                                                <span class="checkContent">E016 HUES64 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_18" value="E003"/>
                                                <span class="checkContent">E003 H1 Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Derived_Culture_18" >ESC_Derived <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Derived_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Derived_Culture_18" class="panel-collapse collapse"> 
                                        <div id="ESC_Derived_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_18" value="E007"/>
                                                <span class="checkContent">E007 H1 Derived Neuronal Progenitor Cultured Cells</span>
                                              </label>
                                            </div>     
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_18" value="E013"/>
                                                <span class="checkContent">E013 hESC Derived CD56+ Mesoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_18" value="E012"/>
                                                <span class="checkContent">E012 hESC Derived CD56+ Ectoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_18" value="E011"/>
                                                <span class="checkContent">E011 hESC Derived CD184+ Endoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_18" value="E004"/>
                                                <span class="checkContent">E004 H1 BMP4 Derived Mesendoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_18" value="E005"/>
                                                <span class="checkContent">E005 H1 BMP4 Derived Trophoblast Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_18" value="E006"/>
                                                <span class="checkContent">E006 H1 Derived Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_IPSC_Culture_18" >IPSC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_IPSC_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_IPSC_Culture_18" class="panel-collapse collapse"> 
                                        <div id="IPSC_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_18" value="E020"/>
                                                <span class="checkContent">E020 iPS-20b Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_18" value="E019"/>
                                                <span class="checkContent">E019 iPS-18 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_18" value="E021"/>
                                                <span class="checkContent">E021 iPS DF 6.9 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_18" value="E022"/>
                                                <span class="checkContent">E022 iPS DF 19.11 Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Culture_18" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Culture_18" class="panel-collapse collapse"> 
                                        <div id="Lung_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Culture_18" value="E128"/>
                                                <span class="checkContent">E128 NHLF Lung Fibroblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Culture_18" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Culture_18" class="panel-collapse collapse"> 
                                        <div id="Muscle_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_18" value="E120"/>
                                                <span class="checkContent">E120 HSMM Skeletal Muscle Myoblasts Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_18" value="E121"/>
                                                <span class="checkContent">E121 HSMM cell derived Skeletal Muscle Myotubes Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Skin_Culture_18" >Skin <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Skin_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Skin_Culture_18" class="panel-collapse collapse"> 
                                        <div id="Skin_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_18" value="E055"/>
                                                <span class="checkContent">E055 Foreskin Fibroblast Primary Cells skin01</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_18" value="E056"/>
                                                <span class="checkContent">E056 Foreskin Fibroblast Primary Cells skin02</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_18" value="E059"/>
                                                <span class="checkContent">E059 Foreskin Melanocyte Primary Cells skin01</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_18" value="E061"/>
                                                <span class="checkContent">E061 Foreskin Melanocyte Primary Cells skin03</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_18" value="E058"/>
                                                <span class="checkContent">E058 Foreskin Keratinocyte Primary Cells skin03</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_18" value="E126"/>
                                                <span class="checkContent">E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_18" value="E127"/>
                                                <span class="checkContent">E127 NHEK-Epidermal Keratinocyte Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Stromal_Connective_Culture_18" >Stromal_Connective <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Stromal_Connective_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Stromal_Connective_Culture_18" class="panel-collapse collapse"> 
                                        <div id="Stromal_Connective_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture_18" value="E026"/>
                                                <span class="checkContent">E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture_18" value="E049"/>
                                                <span class="checkContent">E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Culture_18" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Culture_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Culture_18" class="panel-collapse collapse"> 
                                        <div id="Vascular_Culture_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Culture_18" value="E122"/>
                                                <span class="checkContent">E122 HUVEC Umbilical Vein Endothelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                                                                                        


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_CellLine_18"> Cell Lines <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_CellLine_18" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_CellLine_18" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_CellLine_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_CellLine_18" class="panel-collapse collapse"> 
                                        <div id="Blood_CellLine_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_CellLine_18" value="E115"/>
                                                <span class="checkContent">E115 Dnd41 TCell Leukemia Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Cervix_CellLine_18" >Cervix <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Cervix_CellLine_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Cervix_CellLine_18" class="panel-collapse collapse"> 
                                        <div id="Cervix_CellLine_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Cervix_CellLine_18" value="E117"/>
                                                <span class="checkContent">E117 HeLa-S3 Cervical Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_CellLine_18" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_CellLine_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_CellLine_18" class="panel-collapse collapse"> 
                                        <div id="Liver_CellLine_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_CellLine_18" value="E118"/>
                                                <span class="checkContent">E118 HepG2 Hepatocellular Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_CellLine_18" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_CellLine_18" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_CellLine_18" class="panel-collapse collapse"> 
                                        <div id="Lung_CellLine_18" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine_18" value="E017"/>
                                                <span class="checkContent">E017 IMR90 fetal lung fibroblasts Cell Line</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine_18" value="E114"/>
                                                <span class="checkContent">E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                


                                </div> 
                              </div>


                            </div>
                           
                            ')

                        )#end of conditional panel

                    )  #end of column 6
                )  #end of fluidRow
            ), #end of first level conditionalPanel


            conditionalPanel(condition = "input.selectFeature == 'H3K27ac'",
                fluidRow(
                    column(6,HTML('  
                    <p>
                    <br>
                    <label>3. Select foreground samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectFore_H3K27ac" type="button" class="btn btn2 btn-default action-button" ><label>finish selection</label></button>
                    <pre id="summary1_H3K27ac" class="shiny-text-output"></pre>
                    <br>
                    <label>4. Select background samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectBack_H3K27ac" type="button" class="btn btn2 btn-default action-button"><label>finish selection</label></button>
                    <span class="help-block">If identifying shared enhancers for foreground samples, don\'t select background samples. This works for cutoff and clustering method, but not Fisher\'s exact test method.</span>
                    <pre id="summary2_H3K27ac" class="shiny-text-output"></pre>


                    <br>
                    <label>5. Select features and samples for visualization in browser:</label>
                    <span class="help-block">If both features and samples are not specified, the default values for them will be used, which are the feature selected in step 1 and foreground samples selected in step 3.</span>


                    <div id="selectFeatureVis_H3K27ac" style="width: 50%;" class="form-group shiny-input-checkboxgroup shiny-input-container shiny-input-container-inline shiny-bound-input">
                                <label class="control-label" for="selectFeatureVis_H3K27ac">Select features:</label>
                                <div class="shiny-options-group">
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27ac" value="ChromHMM15">
                                    <span>ChromHMM15</span>
                                  </label>
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27ac" value="ChromHMM18">
                                    <span>ChromHMM18</span>
                                  </label>
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27ac" value="H3K27ac">
                                    <span>H3K27ac</span>
                                  </label>
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27ac" value="H3K4me1">
                                    <span>H3K4me1</span>
                                  </label>
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27ac" value="H3K4me3">
                                    <span>H3K4me3</span>
                                  </label>
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27ac" value="H3K27me3">
                                    <span>H3K27me3</span>
                                  </label>
                                </div>
                              </div>

                                <label>Select samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectSampleVis_H3K27ac" type="button" class="btn btn2 btn-default action-button" ><label>finish selection</label></button>
                                <pre id="summary1Vis_H3K27ac" class="shiny-text-output"></pre>
                                <br> 


                                </p>
                                <br>')), #end of column 6

                    column(6,
                        HTML('
                          <br>
                          
                          <span class="tab"></span> <button id="selectAll_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                          <br>
                        '),
                        HTML('

                            <br>
                            <div class="panel-group">
                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Adult_Tissue_H3K27ac"> Adult Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Adult_Tissue_H3K27ac" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Adult_H3K27ac" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Blood_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Blood_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E062"/>
                                                <span class="checkContent">E062 Primary mononuclear cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E034"/>
                                                <span class="checkContent">E034 Primary T cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E045"/>
                                                <span class="checkContent">E045 Primary T cells effector/memory enriched from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E044"/>
                                                <span class="checkContent">E044 Primary T regulatory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E043"/>
                                                <span class="checkContent">E043 Primary T helper cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E039"/>
                                                <span class="checkContent">E039 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E041"/>
                                                <span class="checkContent">E041 Primary T helper cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E042"/>
                                                <span class="checkContent">E042 Primary T helper 17 cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E040"/>
                                                <span class="checkContent">E040 Primary T helper memory cells from peripheral blood 1</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E037"/>
                                                <span class="checkContent">E037 Primary T helper memory cells from peripheral blood 2</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E048"/>
                                                <span class="checkContent">E048 Primary T CD8+ memory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E038"/>
                                                <span class="checkContent">E038 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E047"/>
                                                <span class="checkContent">E047 Primary T CD8+ naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E029"/>
                                                <span class="checkContent">E029 Primary monocytes from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E050"/>
                                                <span class="checkContent">E050 Primary hematopoietic stem cells G-CSF-mobilized Female</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E032"/>
                                                <span class="checkContent">E032 Primary B cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E046"/>
                                                <span class="checkContent">E046 Primary Natural Killer cells from peripheral blood</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27ac" value="E124"/>
                                                <span class="checkContent">E124 Monocytes-CD14+ RO01746 Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Adult_H3K27ac" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Brain_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Brain_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27ac" value="E071"/>
                                                <span class="checkContent">E071 Brain Hippocampus Middle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27ac" value="E074"/>
                                                <span class="checkContent">E074 Brain Substantia Nigra</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27ac" value="E068"/>
                                                <span class="checkContent">E068 Brain Anterior Caudate</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27ac" value="E069"/>
                                                <span class="checkContent">E069 Brain Cingulate Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27ac" value="E072"/>
                                                <span class="checkContent">E072 Brain Inferior Temporal Lobe</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27ac" value="E067"/>
                                                <span class="checkContent">E067 Brain Angular Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27ac" value="E073"/>
                                                <span class="checkContent">E073 Brain_Dorsolateral_Prefrontal_Cortex</span>
                                              </label>
                                            </div>                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Fat_Adult_H3K27ac" >Fat <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Fat_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Fat_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Fat_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Adult_H3K27ac" value="E063"/>
                                                <span class="checkContent">E063 Adipose Nuclei</span>
                                              </label>
                                            </div>
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Colon_Adult_H3K27ac" >GI_Colon <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Colon_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Colon_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="GI_Colon_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K27ac" value="E076"/>
                                                <span class="checkContent">E076 Colon Smooth Muscle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K27ac" value="E106"/>
                                                <span class="checkContent">E106 Sigmoid Colon</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K27ac" value="E075"/>
                                                <span class="checkContent">E075 Colonic Mucosa</span>
                                              </label>
                                            </div>                                    
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Duodenum_Adult_H3K27ac" >GI_Duodenum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Duodenum_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Duodenum_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="GI_Duodenum_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Duodenum_Adult_H3K27ac" value="E078"/>
                                                <span class="checkContent">E078 Duodenu</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Esophagus_Adult_H3K27ac" >GI_Esophagus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Esophagus_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Esophagus_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="GI_Esophagus_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Esophagus_Adult_H3K27ac" value="E079"/>
                                                <span class="checkContent">E079 Esophagus</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Adult_H3K27ac" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Adult_H3K27ac" value="E109"/>
                                                <span class="checkContent">E109 Small Intestin</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Rectum_Adult_H3K27ac" >GI_Rectum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Rectum_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Rectum_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="GI_Rectum_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K27ac" value="E103"/>
                                                <span class="checkContent">E103 Rectal Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K27ac" value="E101"/>
                                                <span class="checkContent">E101 Rectal Mucosa Donor 29</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K27ac" value="E102"/>
                                                <span class="checkContent">E102 Rectal Mucosa Donor 31</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Adult_H3K27ac" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K27ac" value="E111"/>
                                                <span class="checkContent">E111 Stomach Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K27ac" value="E094"/>
                                                <span class="checkContent">E094 Gastric</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Heart_Adult_H3K27ac" >Heart <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Heart_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Heart_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Heart_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K27ac" value="E104"/>
                                                <span class="checkContent">E104 Right Atrium</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K27ac" value="E095"/>
                                                <span class="checkContent">E095 Left Ventricle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K27ac" value="E105"/>
                                                <span class="checkContent">E105 Right Ventricle</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_Adult_H3K27ac" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Liver_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_Adult_H3K27ac" value="E066"/>
                                                <span class="checkContent">E066 Liver</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Adult_H3K27ac" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Lung_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Adult_H3K27ac" value="E096"/>
                                                <span class="checkContent">E096 Lung</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Adult_H3K27ac" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Muscle_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K27ac" value="E100"/>
                                                <span class="checkContent">E100 Psoas Muscle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K27ac" value="E108"/>
                                                <span class="checkContent">E108 Skeletal Muscle Female</span>
                                              </label>
                                            </div>                                                                                                          
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Ovary_Adult_H3K27ac" >Ovary <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Ovary_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Ovary_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Ovary_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Ovary_Adult_H3K27ac" value="E097"/>
                                                <span class="checkContent">E097 Ovary</span>
                                              </label>
                                            </div>                                                                                                            
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Pancreas_Adult_H3K27ac" >Pancreas <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Pancreas_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Pancreas_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Pancreas_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult_H3K27ac" value="E087"/>
                                                <span class="checkContent">E087 Pancreatic Islets</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult_H3K27ac" value="E098"/>
                                                <span class="checkContent">E098 Pancreas</span>
                                              </label>
                                            </div>                                                                                                                           
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Spleen_Adult_H3K27ac" >Spleen <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Spleen_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Spleen_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Spleen_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Spleen_Adult_H3K27ac" value="E113"/>
                                                <span class="checkContent">E113 Spleen</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Adult_H3K27ac" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Thymus_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Adult_H3K27ac" value="E112"/>
                                                <span class="checkContent">E112 Thymus</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Adult_H3K27ac" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Adult_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Adult_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Vascular_Adult_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Adult_H3K27ac" value="E065"/>
                                                <span class="checkContent">E065 Aorta</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Fetal_Tissue_H3K27ac"> Fetal Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Fetal_Tissue_H3K27ac" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Adrenal_Fetal_H3K27ac" >Adrenal <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Adrenal_Fetal_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Adrenal_Fetal_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Adrenal_Fetal_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Adrenal_Fetal_H3K27ac" value="E080"/>
                                                <span class="checkContent">E080 Fetal Adrenal Gland</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Fetal_H3K27ac" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Fetal_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Fetal_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Fetal_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal_H3K27ac" value="E085"/>
                                                <span class="checkContent">E085 Fetal Intestine Small</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal_H3K27ac" value="E084"/>
                                                <span class="checkContent">E084 Fetal Intestine Large</span>
                                              </label>
                                            </div>                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Fetal_H3K27ac" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Fetal_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Fetal_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Fetal_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Fetal_H3K27ac" value="E092"/>
                                                <span class="checkContent">E092 Fetal Stomach</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Fetal_H3K27ac" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Fetal_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Fetal_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Muscle_Fetal_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal_H3K27ac" value="E089"/>
                                                <span class="checkContent">E089 Fetal Muscle Trunk</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal_H3K27ac" value="E090"/>
                                                <span class="checkContent">E090 Fetal Muscle Leg</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href= "#collapse_Placenta_Fetal_H3K27ac" >Placenta <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Placenta_Fetal_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Placenta_Fetal_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Placenta_Fetal_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal_H3K27ac" value="E099"/>
                                                <span class="checkContent">E099 Placenta Amnion</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal_H3K27ac" value="E091"/>
                                                <span class="checkContent">E091 Placenta</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Fetal_H3K27ac" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Fetal_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Fetal_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Thymus_Fetal_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Fetal_H3K27ac" value="E093"/>
                                                <span class="checkContent">E093 Fetal Thymus</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                        

                                                                          
                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Culture_H3K27ac"> Primary Cultures <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Culture_H3K27ac" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Culture_H3K27ac" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Blood_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture_H3K27ac" value="E116"/>
                                                <span class="checkContent">E116 GM12878 Lymphoblastoid Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture_H3K27ac" value="E123"/>
                                                <span class="checkContent">E123 K562 Leukemia Cells</span>
                                              </label>
                                            </div>                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Bone_Culture_H3K27ac" >Bone <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Bone_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Bone_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Bone_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Bone_Culture_H3K27ac" value="E129"/>
                                                <span class="checkContent">E129 Osteoblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Culture_H3K27ac" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Brain_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Brain_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_H3K27ac" value="E125"/>
                                                <span class="checkContent">E125 NH-A Astrocytes Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Breast_Culture_H3K27ac" >Breast <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Breast_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Breast_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Breast_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Culture_H3K27ac" value="E119"/>
                                                <span class="checkContent">E119 HMEC Mammary Epithelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Culture_H3K27ac" >ESC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="ESC_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27ac" value="E008"/>
                                                <span class="checkContent">E008 H9 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27ac" value="E015"/>
                                                <span class="checkContent">E015 HUES6 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27ac" value="E014"/>
                                                <span class="checkContent">E014 HUES48 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27ac" value="E016"/>
                                                <span class="checkContent">E016 HUES64 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27ac" value="E003"/>
                                                <span class="checkContent">E003 H1 Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Derived_Culture_H3K27ac" >ESC_Derived <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Derived_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Derived_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="ESC_Derived_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27ac" value="E007"/>
                                                <span class="checkContent">E007 H1 Derived Neuronal Progenitor Cultured Cells</span>
                                              </label>
                                            </div>     
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27ac" value="E013"/>
                                                <span class="checkContent">E013 hESC Derived CD56+ Mesoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27ac" value="E012"/>
                                                <span class="checkContent">E012 hESC Derived CD56+ Ectoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27ac" value="E011"/>
                                                <span class="checkContent">E011 hESC Derived CD184+ Endoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27ac" value="E004"/>
                                                <span class="checkContent">E004 H1 BMP4 Derived Mesendoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27ac" value="E005"/>
                                                <span class="checkContent">E005 H1 BMP4 Derived Trophoblast Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27ac" value="E006"/>
                                                <span class="checkContent">E006 H1 Derived Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_IPSC_Culture_H3K27ac" >IPSC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_IPSC_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_IPSC_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="IPSC_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K27ac" value="E020"/>
                                                <span class="checkContent">E020 iPS-20b Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K27ac" value="E019"/>
                                                <span class="checkContent">E019 iPS-18 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K27ac" value="E021"/>
                                                <span class="checkContent">E021 iPS DF 6.9 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K27ac" value="E022"/>
                                                <span class="checkContent">E022 iPS DF 19.11 Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Culture_H3K27ac" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Lung_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Culture_H3K27ac" value="E128"/>
                                                <span class="checkContent">E128 NHLF Lung Fibroblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Culture_H3K27ac" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Muscle_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K27ac" value="E120"/>
                                                <span class="checkContent">E120 HSMM Skeletal Muscle Myoblasts Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K27ac" value="E121"/>
                                                <span class="checkContent">E121 HSMM cell derived Skeletal Muscle Myotubes Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Skin_Culture_H3K27ac" >Skin <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Skin_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Skin_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Skin_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27ac" value="E055"/>
                                                <span class="checkContent">E055 Foreskin Fibroblast Primary Cells skin01</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27ac" value="E056"/>
                                                <span class="checkContent">E056 Foreskin Fibroblast Primary Cells skin02</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27ac" value="E059"/>
                                                <span class="checkContent">E059 Foreskin Melanocyte Primary Cells skin01</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27ac" value="E061"/>
                                                <span class="checkContent">E061 Foreskin Melanocyte Primary Cells skin03</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27ac" value="E058"/>
                                                <span class="checkContent">E058 Foreskin Keratinocyte Primary Cells skin03</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27ac" value="E126"/>
                                                <span class="checkContent">E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27ac" value="E127"/>
                                                <span class="checkContent">E127 NHEK-Epidermal Keratinocyte Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Stromal_Connective_Culture_H3K27ac" >Stromal_Connective <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Stromal_Connective_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Stromal_Connective_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Stromal_Connective_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture_H3K27ac" value="E026"/>
                                                <span class="checkContent">E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture_H3K27ac" value="E049"/>
                                                <span class="checkContent">E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Culture_H3K27ac" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Culture_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Culture_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Vascular_Culture_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Culture_H3K27ac" value="E122"/>
                                                <span class="checkContent">E122 HUVEC Umbilical Vein Endothelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                                                                                        


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_CellLine_H3K27ac"> Cell Lines <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_CellLine_H3K27ac" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_CellLine_H3K27ac" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_CellLine_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_CellLine_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Blood_CellLine_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_CellLine_H3K27ac" value="E115"/>
                                                <span class="checkContent">E115 Dnd41 TCell Leukemia Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Cervix_CellLine_H3K27ac" >Cervix <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Cervix_CellLine_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Cervix_CellLine_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Cervix_CellLine_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Cervix_CellLine_H3K27ac" value="E117"/>
                                                <span class="checkContent">E117 HeLa-S3 Cervical Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_CellLine_H3K27ac" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_CellLine_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_CellLine_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Liver_CellLine_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_CellLine_H3K27ac" value="E118"/>
                                                <span class="checkContent">E118 HepG2 Hepatocellular Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_CellLine_H3K27ac" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_CellLine_H3K27ac" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_CellLine_H3K27ac" class="panel-collapse collapse"> 
                                        <div id="Lung_CellLine_H3K27ac" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine_H3K27ac" value="E017"/>
                                                <span class="checkContent">E017 IMR90 fetal lung fibroblasts Cell Line</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine_H3K27ac" value="E114"/>
                                                <span class="checkContent">E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                


                                </div> 
                              </div>


                            </div>
                           
                        ')#end of HTML
                    ) #end of column 8 


                ) #end of fluidRow

                            
            ) ,#end of first level conditionalPanel


            conditionalPanel(condition = "input.selectFeature == 'H3K4me1'",
                fluidRow(
                    column(6,HTML('  
                        <p>
                        <br>
                        <label>3. Select foreground samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectFore_H3K4me1" type="button" class="btn btn2 btn-default action-button" ><label>finish selection</label></button>
                        <pre id="summary1_H3K4me1" class="shiny-text-output"></pre>
                        <br>    
                        <label>4. Select background samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectBack_H3K4me1" type="button" class="btn btn2 btn-default action-button"><label>finish selection</label></button>
                        <span class="help-block">If identifying shared enhancers for foreground samples, don\'t select background samples. This works for cutoff and clustering method, but not Fisher\'s exact test method.</span>
                        <pre id="summary2_H3K4me1" class="shiny-text-output"></pre>
                        <br>
                        <label>5. Select features and samples for visualization in browser:</label>
                        <span class="help-block">If both features and samples are not specified, the default values for them will be used, which are the feature selected in step 1 and foreground samples selected in step 3.</span>


                        <div id="selectFeatureVis_H3K4me1" style="width: 50%;" class="form-group shiny-input-checkboxgroup shiny-input-container shiny-input-container-inline shiny-bound-input">
                                    <label class="control-label" for="selectFeatureVis_H3K4me1">Select features:</label>
                                    <div class="shiny-options-group">
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me1" value="ChromHMM15">
                                        <span>ChromHMM15</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me1" value="ChromHMM18">
                                        <span>ChromHMM18</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me1" value="H3K27ac">
                                        <span>H3K27ac</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me1" value="H3K4me1">
                                        <span>H3K4me1</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me1" value="H3K4me3">
                                        <span>H3K4me3</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me1" value="H3K27me3">
                                        <span>H3K27me3</span>
                                      </label>
                                    </div>
                                  </div>

                                    <label>Select samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectSampleVis_H3K4me1" type="button" class="btn btn2 btn-default action-button" ><label>finish selection</label></button>
                                    <pre id="summary1Vis_H3K4me1" class="shiny-text-output"></pre>
                                    <br> 


                                    </p>
                                    <br>')
                    ), #end of column 4

                    column(6,


                        HTML('
                            <br>
                            
                            <span class="tab"></span> <button id="selectAll_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                            <br>
                        '),
                        HTML('

                            <br>
                            <div class="panel-group">
                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Adult_Tissue_H3K4me1"> Adult Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Adult_Tissue_H3K4me1" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Adult_H3K4me1" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Blood_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Blood_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E062"/>
                                                <span class="checkContent" >E062 Primary mononuclear cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E034"/>
                                                <span class="checkContent">E034 Primary T cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E045"/>
                                                <span class="checkContent">E045 Primary T cells effector/memory enriched from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E044"/>
                                                <span class="checkContent">E044 Primary T regulatory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E043"/>
                                                <span class="checkContent">E043 Primary T helper cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E039"/>
                                                <span class="checkContent">E039 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E041"/>
                                                <span class="checkContent">E041 Primary T helper cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E042"/>
                                                <span class="checkContent">E042 Primary T helper 17 cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E040"/>
                                                <span class="checkContent">E040 Primary T helper memory cells from peripheral blood 1</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E037"/>
                                                <span class="checkContent">E037 Primary T helper memory cells from peripheral blood 2</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E048"/>
                                                <span class="checkContent">E048 Primary T CD8+ memory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E038"/>
                                                <span class="checkContent">E038 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E047"/>
                                                <span class="checkContent">E047 Primary T CD8+ naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E029"/>
                                                <span class="checkContent">E029 Primary monocytes from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E035"/>
                                                <span class="checkContent">E035 Primary hematopoietic stem cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E051"/>
                                                <span class="checkContent">E051 Primary hematopoietic stem cells G-CSF-mobilized Male</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E050"/>
                                                <span class="checkContent">E050 Primary hematopoietic stem cells G-CSF-mobilized Female</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E036"/>
                                                <span class="checkContent">E036 Primary hematopoietic stem cells short term culture</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E032"/>
                                                <span class="checkContent">E032 Primary B cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E046"/>
                                                <span class="checkContent">E046 Primary Natural Killer cells from peripheral blood</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E030"/>
                                                <span class="checkContent">E030 Primary neutrophils from peripheral blood</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me1" value="E124"/>
                                                <span class="checkContent">E124 Monocytes-CD14+ RO01746 Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Adult_H3K4me1" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Brain_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Brain_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me1" value="E071"/>
                                                <span class="checkContent">E071 Brain Hippocampus Middle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me1" value="E074"/>
                                                <span class="checkContent">E074 Brain Substantia Nigra</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me1" value="E068"/>
                                                <span class="checkContent">E068 Brain Anterior Caudate</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me1" value="E069"/>
                                                <span class="checkContent">E069 Brain Cingulate Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me1" value="E072"/>
                                                <span class="checkContent">E072 Brain Inferior Temporal Lobe</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me1" value="E067"/>
                                                <span class="checkContent">E067 Brain Angular Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me1" value="E073"/>
                                                <span class="checkContent">E073 Brain_Dorsolateral_Prefrontal_Cortex</span>
                                              </label>
                                            </div>                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>
                           

                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Breast_Adult_H3K4me1" >Breast <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Breast_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Breast_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Breast_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Adult_H3K4me1" value="E027"/>
                                                <span class="checkContent">E027 Breast Myoepithelial Primary Cells</span>
                                              </label>
                                            </div>
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Fat_Adult_H3K4me1" >Fat <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Fat_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Fat_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Fat_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Adult_H3K4me1" value="E063"/>
                                                <span class="checkContent">E063 Adipose Nuclei</span>
                                              </label>
                                            </div>
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Colon_Adult_H3K4me1" >GI_Colon <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Colon_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Colon_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="GI_Colon_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K4me1" value="E076"/>
                                                <span class="checkContent">E076 Colon Smooth Muscle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K4me1" value="E106"/>
                                                <span class="checkContent">E106 Sigmoid Colon</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K4me1" value="E075"/>
                                                <span class="checkContent">E075 Colonic Mucosa</span>
                                              </label>
                                            </div>                                    
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Duodenum_Adult_H3K4me1" >GI_Duodenum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Duodenum_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Duodenum_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="GI_Duodenum_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Duodenum_Adult_H3K4me1" value="E078"/>
                                                <span class="checkContent">E078 Duodenu</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Duodenum_Adult_H3K4me1" value="E077"/>
                                                <span class="checkContent">E077 Duodenum Mucosa</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Esophagus_Adult_H3K4me1" >GI_Esophagus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Esophagus_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Esophagus_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="GI_Esophagus_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Esophagus_Adult_H3K4me1" value="E079"/>
                                                <span class="checkContent">E079 Esophagus</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Adult_H3K4me1" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Adult_H3K4me1" value="E109"/>
                                                <span class="checkContent">E109 Small Intestin</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Rectum_Adult_H3K4me1" >GI_Rectum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Rectum_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Rectum_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="GI_Rectum_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K4me1" value="E103"/>
                                                <span class="checkContent">E103 Rectal Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K4me1" value="E101"/>
                                                <span class="checkContent">E101 Rectal Mucosa Donor 29</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K4me1" value="E102"/>
                                                <span class="checkContent">E102 Rectal Mucosa Donor 31</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Adult_H3K4me1" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K4me1" value="E111"/>
                                                <span class="checkContent">E111 Stomach Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K4me1" value="E110"/>
                                                <span class="checkContent">E110 Stomach Mucosa</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K4me1" value="E094"/>
                                                <span class="checkContent">E094 Gastric</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Heart_Adult_H3K4me1" >Heart <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Heart_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Heart_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Heart_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K4me1" value="E104"/>
                                                <span class="checkContent">E104 Right Atrium</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K4me1" value="E095"/>
                                                <span class="checkContent">E095 Left Ventricle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K4me1" value="E105"/>
                                                <span class="checkContent">E105 Right Ventricle</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_Adult_H3K4me1" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Liver_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_Adult_H3K4me1" value="E066"/>
                                                <span class="checkContent">E066 Liver</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Adult_H3K4me1" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Lung_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Adult_H3K4me1" value="E096"/>
                                                <span class="checkContent">E096 Lung</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Adult_H3K4me1" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Muscle_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K4me1" value="E100"/>
                                                <span class="checkContent">E100 Psoas Muscle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K4me1" value="E108"/>
                                                <span class="checkContent">E108 Skeletal Muscle Female</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K4me1" value="E107"/>
                                                <span class="checkContent">E107 Skeletal Muscle Male</span>
                                              </label>
                                            </div>                                                                                                           
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Ovary_Adult_H3K4me1" >Ovary <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Ovary_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Ovary_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Ovary_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Ovary_Adult_H3K4me1" value="E097"/>
                                                <span class="checkContent">E097 Ovary</span>
                                              </label>
                                            </div>                                                                                                            
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Pancreas_Adult_H3K4me1" >Pancreas <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Pancreas_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Pancreas_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Pancreas_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult_H3K4me1" value="E087"/>
                                                <span class="checkContent">E087 Pancreatic Islets</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult_H3K4me1" value="E098"/>
                                                <span class="checkContent">E098 Pancreas</span>
                                              </label>
                                            </div>                                                                                                                           
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Spleen_Adult_H3K4me1" >Spleen <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Spleen_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Spleen_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Spleen_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Spleen_Adult_H3K4me1" value="E113"/>
                                                <span class="checkContent">E113 Spleen</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Adult_H3K4me1" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Thymus_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Adult_H3K4me1" value="E112"/>
                                                <span class="checkContent">E112 Thymus</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Adult_H3K4me1" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Adult_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Adult_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Vascular_Adult_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Adult_H3K4me1" value="E065"/>
                                                <span class="checkContent">E065 Aorta</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Fetal_Tissue_H3K4me1"> Fetal Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Fetal_Tissue_H3K4me1" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Adrenal_Fetal_H3K4me1" >Adrenal <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Adrenal_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Adrenal_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Adrenal_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Adrenal_Fetal_H3K4me1" value="E080"/>
                                                <span class="checkContent">E080 Fetal Adrenal Gland</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Fetal_H3K4me1" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Blood_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Fetal_H3K4me1" value="E033"/>
                                                <span class="checkContent">E033 Primary T cells from cord blood</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Fetal_H3K4me1" value="E031"/>
                                                <span class="checkContent">E031 Primary B cells from cord blood</span>
                                              </label>
                                            </div>                                                                                                                                            
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Fetal_H3K4me1" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Brain_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Brain_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal_H3K4me1" value="E070"/>
                                                <span class="checkContent">E070 Brain Germinal Matrix</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal_H3K4me1" value="E082"/>
                                                <span class="checkContent">E082 Fetal Brain Female</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal_H3K4me1" value="E081"/>
                                                <span class="checkContent">E081 Fetal Brain Male</span>
                                              </label>
                                            </div>                                                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Fetal_H3K4me1" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal_H3K4me1" value="E085"/>
                                                <span class="checkContent">E085 Fetal Intestine Small</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal_H3K4me1" value="E084"/>
                                                <span class="checkContent">E084 Fetal Intestine Large</span>
                                              </label>
                                            </div>                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Fetal_H3K4me1" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Fetal_H3K4me1" value="E092"/>
                                                <span class="checkContent">E092 Fetal Stomach</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Heart_Fetal_H3K4me1" >Heart <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Heart_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Heart_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Heart_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Fetal_H3K4me1" value="E083"/>
                                                <span class="checkContent">E083 Fetal Heart</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Kidney_Fetal_H3K4me1" >Kidney <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Kidney_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Kidney_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Kidney_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Kidney_Fetal_H3K4me1" value="E086"/>
                                                <span class="checkContent">E086 Fetal Kidney</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Fetal_H3K4me1" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Lung_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Fetal_H3K4me1" value="E088"/>
                                                <span class="checkContent">E088 Fetal Lung</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Fetal_H3K4me1" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Muscle_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal_H3K4me1" value="E089"/>
                                                <span class="checkContent">E089 Fetal Muscle Trunk</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal_H3K4me1" value="E090"/>
                                                <span class="checkContent">E090 Fetal Muscle Leg</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href= "#collapse_Placenta_Fetal_H3K4me1" >Placenta <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Placenta_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Placenta_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Placenta_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal_H3K4me1" value="E099"/>
                                                <span class="checkContent">E099 Placenta Amnion</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal_H3K4me1" value="E091"/>
                                                <span class="checkContent">E091 Placenta</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Fetal_H3K4me1" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Fetal_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Fetal_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Thymus_Fetal_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Fetal_H3K4me1" value="E093"/>
                                                <span class="checkContent">E093 Fetal Thymus</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                        

                                                                          
                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Culture_H3K4me1"> Primary Cultures <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Culture_H3K4me1" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Culture_H3K4me1" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Blood_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture_H3K4me1" value="E116"/>
                                                <span class="checkContent">E116 GM12878 Lymphoblastoid Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture_H3K4me1" value="E123"/>
                                                <span class="checkContent">E123 K562 Leukemia Cells</span>
                                              </label>
                                            </div>                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Bone_Culture_H3K4me1" >Bone <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Bone_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Bone_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Bone_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Bone_Culture_H3K4me1" value="E129"/>
                                                <span class="checkContent">E129 Osteoblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Culture_H3K4me1" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Brain_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Brain_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_H3K4me1" value="E054"/>
                                                <span class="checkContent">E054 Ganglion Eminence derived primary cultured neurospheres</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_H3K4me1" value="E053"/>
                                                <span class="checkContent">E053 Cortex derived primary cultured neurospheres</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_H3K4me1" value="E125"/>
                                                <span class="checkContent">E125 NH-A Astrocytes Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Breast_Culture_H3K4me1" >Breast <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Breast_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Breast_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Breast_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Culture_H3K4me1" value="E028"/>
                                                <span class="checkContent">E028 Breast variant Human Mammary Epithelial Cells (vHMEC)</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Culture_H3K4me1" value="E119"/>
                                                <span class="checkContent">E119 HMEC Mammary Epithelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Culture_H3K4me1" >ESC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="ESC_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me1" value="E002"/>
                                                <span class="checkContent">E002 ES-WA7 Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me1" value="E008"/>
                                                <span class="checkContent">E008 H9 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me1" value="E001"/>
                                                <span class="checkContent">E001 ES-I3 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me1" value="E015"/>
                                                <span class="checkContent">E015 HUES6 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me1" value="E014"/>
                                                <span class="checkContent">E014 HUES48 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me1" value="E016"/>
                                                <span class="checkContent">E016 HUES64 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me1" value="E003"/>
                                                <span class="checkContent">E003 H1 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me1" value="E024"/>
                                                <span class="checkContent">E024 ES-UCSF4  Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Derived_Culture_H3K4me1" >ESC_Derived <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Derived_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Derived_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="ESC_Derived_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me1" value="E007"/>
                                                <span class="checkContent">E007 H1 Derived Neuronal Progenitor Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me1" value="E009"/>
                                                <span class="checkContent">E009 H9 Derived Neuronal Progenitor Cultured Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me1" value="E010"/>
                                                <span class="checkContent">E010 H9 Derived Neuron Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me1" value="E013"/>
                                                <span class="checkContent">E013 hESC Derived CD56+ Mesoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me1" value="E012"/>
                                                <span class="checkContent">E012 hESC Derived CD56+ Ectoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me1" value="E011"/>
                                                <span class="checkContent">E011 hESC Derived CD184+ Endoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me1" value="E004"/>
                                                <span class="checkContent">E004 H1 BMP4 Derived Mesendoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me1" value="E005"/>
                                                <span class="checkContent">E005 H1 BMP4 Derived Trophoblast Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me1" value="E006"/>
                                                <span class="checkContent">E006 H1 Derived Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Fat_Culture_H3K4me1" >Fat <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Fat_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Fat_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Fat_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Culture_H3K4me1" value="E025"/>
                                                <span class="checkContent">E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Culture_H3K4me1" value="E023"/>
                                                <span class="checkContent">E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_IPSC_Culture_H3K4me1" >IPSC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_IPSC_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_IPSC_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="IPSC_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K4me1" value="E020"/>
                                                <span class="checkContent">E020 iPS-20b Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K4me1" value="E019"/>
                                                <span class="checkContent">E019 iPS-18 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K4me1" value="E018"/>
                                                <span class="checkContent">E018 iPS-15b Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K4me1" value="E021"/>
                                                <span class="checkContent">E021 iPS DF 6.9 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K4me1" value="E022"/>
                                                <span class="checkContent">E022 iPS DF 19.11 Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Culture_H3K4me1" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Lung_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Culture_H3K4me1" value="E128"/>
                                                <span class="checkContent">E128 NHLF Lung Fibroblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Culture_H3K4me1" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Muscle_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K4me1" value="E052"/>
                                                <span class="checkContent">E052 Muscle Satellite Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K4me1" value="E120"/>
                                                <span class="checkContent">E120 HSMM Skeletal Muscle Myoblasts Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K4me1" value="E121"/>
                                                <span class="checkContent">E121 HSMM cell derived Skeletal Muscle Myotubes Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Skin_Culture_H3K4me1" >Skin <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Skin_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Skin_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Skin_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me1" value="E055"/>
                                                <span class="checkContent">E055 Foreskin Fibroblast Primary Cells skin01</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me1" value="E056"/>
                                                <span class="checkContent">E056 Foreskin Fibroblast Primary Cells skin02</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me1" value="E059"/>
                                                <span class="checkContent">E059 Foreskin Melanocyte Primary Cells skin01</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me1" value="E061"/>
                                                <span class="checkContent">E061 Foreskin Melanocyte Primary Cells skin03</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me1" value="E057"/>
                                                <span class="checkContent">E057 Foreskin Keratinocyte Primary Cells skin02</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me1" value="E058"/>
                                                <span class="checkContent">E058 Foreskin Keratinocyte Primary Cells skin03</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me1" value="E126"/>
                                                <span class="checkContent">E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me1" value="E127"/>
                                                <span class="checkContent">E127 NHEK-Epidermal Keratinocyte Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Stromal_Connective_Culture_H3K4me1" >Stromal_Connective <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Stromal_Connective_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Stromal_Connective_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Stromal_Connective_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture_H3K4me1" value="E026"/>
                                                <span class="checkContent">E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture_H3K4me1" value="E049"/>
                                                <span class="checkContent">E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Culture_H3K4me1" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Culture_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Culture_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Vascular_Culture_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Culture_H3K4me1" value="E122"/>
                                                <span class="checkContent">E122 HUVEC Umbilical Vein Endothelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                                                                                        


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_CellLine_H3K4me1"> Cell Lines <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_CellLine_H3K4me1" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_CellLine_H3K4me1" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_CellLine_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_CellLine_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Blood_CellLine_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_CellLine_H3K4me1" value="E115"/>
                                                <span class="checkContent">E115 Dnd41 TCell Leukemia Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Cervix_CellLine_H3K4me1" >Cervix <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Cervix_CellLine_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Cervix_CellLine_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Cervix_CellLine_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Cervix_CellLine_H3K4me1" value="E117"/>
                                                <span class="checkContent">E117 HeLa-S3 Cervical Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_CellLine_H3K4me1" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_CellLine_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_CellLine_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Liver_CellLine_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_CellLine_H3K4me1" value="E118"/>
                                                <span class="checkContent">E118 HepG2 Hepatocellular Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_CellLine_H3K4me1" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_CellLine_H3K4me1" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_CellLine_H3K4me1" class="panel-collapse collapse"> 
                                        <div id="Lung_CellLine_H3K4me1" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine_H3K4me1" value="E017"/>
                                                <span class="checkContent">E017 IMR90 fetal lung fibroblasts Cell Line</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine_H3K4me1" value="E114"/>
                                                <span class="checkContent">E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                


                                </div> 
                              </div>


                            </div>
                              
                        ')#end of HTML
                    ) #end of column 8 


                ) #end of fluidRow

                            
            ) ,#end of first level conditionalPanel


            conditionalPanel(condition = "input.selectFeature == 'H3K4me3'",
                fluidRow(

                    column(6,HTML('  
                        <p>
                        <br>
                        <label>3. Select foreground samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectFore_H3K4me3" type="button" class="btn btn2 btn-default action-button" ><label>finish selection</label></button>
                        <pre id="summary1_H3K4me3" class="shiny-text-output"></pre>
                        <br>    
                        <label>4. Select background samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectBack_H3K4me3" type="button" class="btn btn2 btn-default action-button"><label>finish selection</label></button>
                        <span class="help-block">If identifying shared enhancers for foreground samples, don\'t select background samples. This works for cutoff and clustering method, but not Fisher\'s exact test method.</span>
                        <pre id="summary2_H3K4me3" class="shiny-text-output"></pre>
                        <br>
                        <label>5. Select features and samples for visualization in browser:</label>
                        <span class="help-block">If both features and samples are not specified, the default values for them will be used, which are the feature selected in step 1 and foreground samples selected in step 3.</span>


                        <div id="selectFeatureVis_H3K4me3" style="width: 50%;" class="form-group shiny-input-checkboxgroup shiny-input-container shiny-input-container-inline shiny-bound-input">
                                    <label class="control-label" for="selectFeatureVis_H3K4me3">Select features:</label>
                                    <div class="shiny-options-group">
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me3" value="ChromHMM15">
                                        <span>ChromHMM15</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me3" value="ChromHMM18">
                                        <span>ChromHMM18</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me3" value="H3K27ac">
                                        <span>H3K27ac</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me3" value="H3K4me1">
                                        <span>H3K4me1</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me3" value="H3K4me3">
                                        <span>H3K4me3</span>
                                      </label>
                                      <label class="checkbox-inline">
                                        <input type="checkbox" name="selectFeatureVis_H3K4me3" value="H3K27me3">
                                        <span>H3K27me3</span>
                                      </label>
                                    </div>
                                  </div>

                                    <label>Select samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectSampleVis_H3K4me3" type="button" class="btn btn2 btn-default action-button" ><label>finish selection</label></button>
                                    <pre id="summary1Vis_H3K4me3" class="shiny-text-output"></pre>
                                    <br> 


                                    </p>
                                    <br>')
                    ), #end of column 4

                    column(6,
                        HTML('
                          <br>
                          
                          <span class="tab"></span> <button id="selectAll_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                          <br>
                        '),
                        HTML('

                            <br>
                            <div class="panel-group">
                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Adult_Tissue_H3K4me3"> Adult Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Adult_Tissue_H3K4me3" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Adult_H3K4me3" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Blood_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Blood_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E062"/>
                                                <span class="checkContent" >E062 Primary mononuclear cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E034"/>
                                                <span class="checkContent">E034 Primary T cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E045"/>
                                                <span class="checkContent">E045 Primary T cells effector/memory enriched from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E044"/>
                                                <span class="checkContent">E044 Primary T regulatory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E043"/>
                                                <span class="checkContent">E043 Primary T helper cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E039"/>
                                                <span class="checkContent">E039 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E041"/>
                                                <span class="checkContent">E041 Primary T helper cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E042"/>
                                                <span class="checkContent">E042 Primary T helper 17 cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E040"/>
                                                <span class="checkContent">E040 Primary T helper memory cells from peripheral blood 1</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E037"/>
                                                <span class="checkContent">E037 Primary T helper memory cells from peripheral blood 2</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E048"/>
                                                <span class="checkContent">E048 Primary T CD8+ memory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E038"/>
                                                <span class="checkContent">E038 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E047"/>
                                                <span class="checkContent">E047 Primary T CD8+ naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E029"/>
                                                <span class="checkContent">E029 Primary monocytes from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E035"/>
                                                <span class="checkContent">E035 Primary hematopoietic stem cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E051"/>
                                                <span class="checkContent">E051 Primary hematopoietic stem cells G-CSF-mobilized Male</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E050"/>
                                                <span class="checkContent">E050 Primary hematopoietic stem cells G-CSF-mobilized Female</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E036"/>
                                                <span class="checkContent">E036 Primary hematopoietic stem cells short term culture</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E032"/>
                                                <span class="checkContent">E032 Primary B cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E046"/>
                                                <span class="checkContent">E046 Primary Natural Killer cells from peripheral blood</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E030"/>
                                                <span class="checkContent">E030 Primary neutrophils from peripheral blood</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K4me3" value="E124"/>
                                                <span class="checkContent">E124 Monocytes-CD14+ RO01746 Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Adult_H3K4me3" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Brain_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Brain_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me3" value="E071"/>
                                                <span class="checkContent">E071 Brain Hippocampus Middle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me3" value="E074"/>
                                                <span class="checkContent">E074 Brain Substantia Nigra</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me3" value="E068"/>
                                                <span class="checkContent">E068 Brain Anterior Caudate</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me3" value="E069"/>
                                                <span class="checkContent">E069 Brain Cingulate Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me3" value="E072"/>
                                                <span class="checkContent">E072 Brain Inferior Temporal Lobe</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me3" value="E067"/>
                                                <span class="checkContent">E067 Brain Angular Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K4me3" value="E073"/>
                                                <span class="checkContent">E073 Brain_Dorsolateral_Prefrontal_Cortex</span>
                                              </label>
                                            </div>                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>
                           

                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Breast_Adult_H3K4me3" >Breast <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Breast_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Breast_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Breast_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Adult_H3K4me3" value="E027"/>
                                                <span class="checkContent">E027 Breast Myoepithelial Primary Cells</span>
                                              </label>
                                            </div>
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Fat_Adult_H3K4me3" >Fat <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Fat_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Fat_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Fat_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Adult_H3K4me3" value="E063"/>
                                                <span class="checkContent">E063 Adipose Nuclei</span>
                                              </label>
                                            </div>
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Colon_Adult_H3K4me3" >GI_Colon <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Colon_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Colon_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="GI_Colon_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K4me3" value="E076"/>
                                                <span class="checkContent">E076 Colon Smooth Muscle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K4me3" value="E106"/>
                                                <span class="checkContent">E106 Sigmoid Colon</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K4me3" value="E075"/>
                                                <span class="checkContent">E075 Colonic Mucosa</span>
                                              </label>
                                            </div>                                    
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Duodenum_Adult_H3K4me3" >GI_Duodenum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Duodenum_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Duodenum_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="GI_Duodenum_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Duodenum_Adult_H3K4me3" value="E078"/>
                                                <span class="checkContent">E078 Duodenu</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Duodenum_Adult_H3K4me3" value="E077"/>
                                                <span class="checkContent">E077 Duodenum Mucosa</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Esophagus_Adult_H3K4me3" >GI_Esophagus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Esophagus_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Esophagus_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="GI_Esophagus_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Esophagus_Adult_H3K4me3" value="E079"/>
                                                <span class="checkContent">E079 Esophagus</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Adult_H3K4me3" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Adult_H3K4me3" value="E109"/>
                                                <span class="checkContent">E109 Small Intestin</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Rectum_Adult_H3K4me3" >GI_Rectum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Rectum_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Rectum_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="GI_Rectum_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K4me3" value="E103"/>
                                                <span class="checkContent">E103 Rectal Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K4me3" value="E101"/>
                                                <span class="checkContent">E101 Rectal Mucosa Donor 29</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K4me3" value="E102"/>
                                                <span class="checkContent">E102 Rectal Mucosa Donor 31</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Adult_H3K4me3" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K4me3" value="E111"/>
                                                <span class="checkContent">E111 Stomach Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K4me3" value="E110"/>
                                                <span class="checkContent">E110 Stomach Mucosa</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K4me3" value="E094"/>
                                                <span class="checkContent">E094 Gastric</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Heart_Adult_H3K4me3" >Heart <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Heart_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Heart_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Heart_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K4me3" value="E104"/>
                                                <span class="checkContent">E104 Right Atrium</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K4me3" value="E095"/>
                                                <span class="checkContent">E095 Left Ventricle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K4me3" value="E105"/>
                                                <span class="checkContent">E105 Right Ventricle</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_Adult_H3K4me3" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Liver_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_Adult_H3K4me3" value="E066"/>
                                                <span class="checkContent">E066 Liver</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Adult_H3K4me3" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Lung_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Adult_H3K4me3" value="E096"/>
                                                <span class="checkContent">E096 Lung</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Adult_H3K4me3" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Muscle_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K4me3" value="E100"/>
                                                <span class="checkContent">E100 Psoas Muscle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K4me3" value="E108"/>
                                                <span class="checkContent">E108 Skeletal Muscle Female</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K4me3" value="E107"/>
                                                <span class="checkContent">E107 Skeletal Muscle Male</span>
                                              </label>
                                            </div>                                                                                                           
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Ovary_Adult_H3K4me3" >Ovary <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Ovary_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Ovary_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Ovary_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Ovary_Adult_H3K4me3" value="E097"/>
                                                <span class="checkContent">E097 Ovary</span>
                                              </label>
                                            </div>                                                                                                            
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Pancreas_Adult_H3K4me3" >Pancreas <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Pancreas_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Pancreas_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Pancreas_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult_H3K4me3" value="E087"/>
                                                <span class="checkContent">E087 Pancreatic Islets</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult_H3K4me3" value="E098"/>
                                                <span class="checkContent">E098 Pancreas</span>
                                              </label>
                                            </div>                                                                                                                           
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Spleen_Adult_H3K4me3" >Spleen <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Spleen_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Spleen_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Spleen_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Spleen_Adult_H3K4me3" value="E113"/>
                                                <span class="checkContent">E113 Spleen</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Adult_H3K4me3" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Thymus_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Adult_H3K4me3" value="E112"/>
                                                <span class="checkContent">E112 Thymus</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Adult_H3K4me3" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Adult_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Adult_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Vascular_Adult_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Adult_H3K4me3" value="E065"/>
                                                <span class="checkContent">E065 Aorta</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Fetal_Tissue_H3K4me3"> Fetal Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Fetal_Tissue_H3K4me3" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Adrenal_Fetal_H3K4me3" >Adrenal <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Adrenal_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Adrenal_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Adrenal_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Adrenal_Fetal_H3K4me3" value="E080"/>
                                                <span class="checkContent">E080 Fetal Adrenal Gland</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Fetal_H3K4me3" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Blood_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Fetal_H3K4me3" value="E033"/>
                                                <span class="checkContent">E033 Primary T cells from cord blood</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Fetal_H3K4me3" value="E031"/>
                                                <span class="checkContent">E031 Primary B cells from cord blood</span>
                                              </label>
                                            </div>                                                                                                                                            
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Fetal_H3K4me3" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Brain_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Brain_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal_H3K4me3" value="E070"/>
                                                <span class="checkContent">E070 Brain Germinal Matrix</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal_H3K4me3" value="E082"/>
                                                <span class="checkContent">E082 Fetal Brain Female</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal_H3K4me3" value="E081"/>
                                                <span class="checkContent">E081 Fetal Brain Male</span>
                                              </label>
                                            </div>                                                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Fetal_H3K4me3" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal_H3K4me3" value="E085"/>
                                                <span class="checkContent">E085 Fetal Intestine Small</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal_H3K4me3" value="E084"/>
                                                <span class="checkContent">E084 Fetal Intestine Large</span>
                                              </label>
                                            </div>                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Fetal_H3K4me3" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Fetal_H3K4me3" value="E092"/>
                                                <span class="checkContent">E092 Fetal Stomach</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Heart_Fetal_H3K4me3" >Heart <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Heart_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Heart_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Heart_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Fetal_H3K4me3" value="E083"/>
                                                <span class="checkContent">E083 Fetal Heart</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Kidney_Fetal_H3K4me3" >Kidney <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Kidney_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Kidney_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Kidney_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Kidney_Fetal_H3K4me3" value="E086"/>
                                                <span class="checkContent">E086 Fetal Kidney</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Fetal_H3K4me3" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Lung_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Fetal_H3K4me3" value="E088"/>
                                                <span class="checkContent">E088 Fetal Lung</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Fetal_H3K4me3" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Muscle_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal_H3K4me3" value="E089"/>
                                                <span class="checkContent">E089 Fetal Muscle Trunk</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal_H3K4me3" value="E090"/>
                                                <span class="checkContent">E090 Fetal Muscle Leg</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href= "#collapse_Placenta_Fetal_H3K4me3" >Placenta <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Placenta_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Placenta_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Placenta_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal_H3K4me3" value="E099"/>
                                                <span class="checkContent">E099 Placenta Amnion</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal_H3K4me3" value="E091"/>
                                                <span class="checkContent">E091 Placenta</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Fetal_H3K4me3" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Fetal_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Fetal_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Thymus_Fetal_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Fetal_H3K4me3" value="E093"/>
                                                <span class="checkContent">E093 Fetal Thymus</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                        

                                                                          
                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Culture_H3K4me3"> Primary Cultures <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Culture_H3K4me3" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Culture_H3K4me3" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Blood_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture_H3K4me3" value="E116"/>
                                                <span class="checkContent">E116 GM12878 Lymphoblastoid Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture_H3K4me3" value="E123"/>
                                                <span class="checkContent">E123 K562 Leukemia Cells</span>
                                              </label>
                                            </div>                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Bone_Culture_H3K4me3" >Bone <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Bone_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Bone_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Bone_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Bone_Culture_H3K4me3" value="E129"/>
                                                <span class="checkContent">E129 Osteoblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Culture_H3K4me3" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Brain_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Brain_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_H3K4me3" value="E054"/>
                                                <span class="checkContent">E054 Ganglion Eminence derived primary cultured neurospheres</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_H3K4me3" value="E053"/>
                                                <span class="checkContent">E053 Cortex derived primary cultured neurospheres</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_H3K4me3" value="E125"/>
                                                <span class="checkContent">E125 NH-A Astrocytes Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Breast_Culture_H3K4me3" >Breast <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Breast_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Breast_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Breast_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Culture_H3K4me3" value="E028"/>
                                                <span class="checkContent">E028 Breast variant Human Mammary Epithelial Cells (vHMEC)</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Culture_H3K4me3" value="E119"/>
                                                <span class="checkContent">E119 HMEC Mammary Epithelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Culture_H3K4me3" >ESC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="ESC_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me3" value="E002"/>
                                                <span class="checkContent">E002 ES-WA7 Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me3" value="E008"/>
                                                <span class="checkContent">E008 H9 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me3" value="E001"/>
                                                <span class="checkContent">E001 ES-I3 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me3" value="E015"/>
                                                <span class="checkContent">E015 HUES6 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me3" value="E014"/>
                                                <span class="checkContent">E014 HUES48 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me3" value="E016"/>
                                                <span class="checkContent">E016 HUES64 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me3" value="E003"/>
                                                <span class="checkContent">E003 H1 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K4me3" value="E024"/>
                                                <span class="checkContent">E024 ES-UCSF4  Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Derived_Culture_H3K4me3" >ESC_Derived <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Derived_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Derived_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="ESC_Derived_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me3" value="E007"/>
                                                <span class="checkContent">E007 H1 Derived Neuronal Progenitor Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me3" value="E009"/>
                                                <span class="checkContent">E009 H9 Derived Neuronal Progenitor Cultured Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me3" value="E010"/>
                                                <span class="checkContent">E010 H9 Derived Neuron Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me3" value="E013"/>
                                                <span class="checkContent">E013 hESC Derived CD56+ Mesoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me3" value="E012"/>
                                                <span class="checkContent">E012 hESC Derived CD56+ Ectoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me3" value="E011"/>
                                                <span class="checkContent">E011 hESC Derived CD184+ Endoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me3" value="E004"/>
                                                <span class="checkContent">E004 H1 BMP4 Derived Mesendoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me3" value="E005"/>
                                                <span class="checkContent">E005 H1 BMP4 Derived Trophoblast Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K4me3" value="E006"/>
                                                <span class="checkContent">E006 H1 Derived Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Fat_Culture_H3K4me3" >Fat <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Fat_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Fat_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Fat_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Culture_H3K4me3" value="E025"/>
                                                <span class="checkContent">E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Culture_H3K4me3" value="E023"/>
                                                <span class="checkContent">E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_IPSC_Culture_H3K4me3" >IPSC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_IPSC_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_IPSC_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="IPSC_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K4me3" value="E020"/>
                                                <span class="checkContent">E020 iPS-20b Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K4me3" value="E019"/>
                                                <span class="checkContent">E019 iPS-18 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K4me3" value="E018"/>
                                                <span class="checkContent">E018 iPS-15b Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K4me3" value="E021"/>
                                                <span class="checkContent">E021 iPS DF 6.9 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K4me3" value="E022"/>
                                                <span class="checkContent">E022 iPS DF 19.11 Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Culture_H3K4me3" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Lung_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Culture_H3K4me3" value="E128"/>
                                                <span class="checkContent">E128 NHLF Lung Fibroblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Culture_H3K4me3" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Muscle_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K4me3" value="E052"/>
                                                <span class="checkContent">E052 Muscle Satellite Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K4me3" value="E120"/>
                                                <span class="checkContent">E120 HSMM Skeletal Muscle Myoblasts Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K4me3" value="E121"/>
                                                <span class="checkContent">E121 HSMM cell derived Skeletal Muscle Myotubes Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Skin_Culture_H3K4me3" >Skin <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Skin_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Skin_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Skin_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me3" value="E055"/>
                                                <span class="checkContent">E055 Foreskin Fibroblast Primary Cells skin01</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me3" value="E056"/>
                                                <span class="checkContent">E056 Foreskin Fibroblast Primary Cells skin02</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me3" value="E059"/>
                                                <span class="checkContent">E059 Foreskin Melanocyte Primary Cells skin01</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me3" value="E061"/>
                                                <span class="checkContent">E061 Foreskin Melanocyte Primary Cells skin03</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me3" value="E057"/>
                                                <span class="checkContent">E057 Foreskin Keratinocyte Primary Cells skin02</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me3" value="E058"/>
                                                <span class="checkContent">E058 Foreskin Keratinocyte Primary Cells skin03</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me3" value="E126"/>
                                                <span class="checkContent">E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K4me3" value="E127"/>
                                                <span class="checkContent">E127 NHEK-Epidermal Keratinocyte Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Stromal_Connective_Culture_H3K4me3" >Stromal_Connective <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Stromal_Connective_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Stromal_Connective_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Stromal_Connective_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture_H3K4me3" value="E026"/>
                                                <span class="checkContent">E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture_H3K4me3" value="E049"/>
                                                <span class="checkContent">E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Culture_H3K4me3" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Culture_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Culture_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Vascular_Culture_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Culture_H3K4me3" value="E122"/>
                                                <span class="checkContent">E122 HUVEC Umbilical Vein Endothelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                                                                                        


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_CellLine_H3K4me3"> Cell Lines <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_CellLine_H3K4me3" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_CellLine_H3K4me3" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_CellLine_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_CellLine_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Blood_CellLine_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_CellLine_H3K4me3" value="E115"/>
                                                <span class="checkContent">E115 Dnd41 TCell Leukemia Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Cervix_CellLine_H3K4me3" >Cervix <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Cervix_CellLine_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Cervix_CellLine_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Cervix_CellLine_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Cervix_CellLine_H3K4me3" value="E117"/>
                                                <span class="checkContent">E117 HeLa-S3 Cervical Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_CellLine_H3K4me3" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_CellLine_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_CellLine_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Liver_CellLine_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_CellLine_H3K4me3" value="E118"/>
                                                <span class="checkContent">E118 HepG2 Hepatocellular Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_CellLine_H3K4me3" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_CellLine_H3K4me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_CellLine_H3K4me3" class="panel-collapse collapse"> 
                                        <div id="Lung_CellLine_H3K4me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine_H3K4me3" value="E017"/>
                                                <span class="checkContent">E017 IMR90 fetal lung fibroblasts Cell Line</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine_H3K4me3" value="E114"/>
                                                <span class="checkContent">E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                


                                </div> 
                              </div>


                            </div>
                              
                        ')#end of HTML
                    ) #end of column 8

                ) #end of fluidRow

                            
            ) ,#end of first level conditionalPanel


            conditionalPanel(condition = "input.selectFeature == 'H3K27me3'",
                fluidRow(

                    column(6,HTML('  
                    <p>
                    <br>
                    <label>3. Select foreground samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectFore_H3K27me3" type="button" class="btn btn2 btn-default action-button" ><label>finish selection</label></button>
                    <pre id="summary1_H3K27me3" class="shiny-text-output"></pre>
                    <br>    
                    <label>4. Select background samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectBack_H3K27me3" type="button" class="btn btn2 btn-default action-button"><label>finish selection</label></button>
                    <span class="help-block">If identifying shared enhancers for foreground samples, don\'t select background samples. This works for cutoff and clustering method, but not Fisher\'s exact test method.</span>
                    <pre id="summary2_H3K27me3" class="shiny-text-output"></pre>
                    <br>
                    <label>5. Select features and samples for visualization in browser:</label>
                    <span class="help-block">If both features and samples are not specified, the default values for them will be used, which are the feature selected in step 1 and foreground samples selected in step 3.</span>


                    <div id="selectFeatureVis_H3K27me3" style="width: 50%;" class="form-group shiny-input-checkboxgroup shiny-input-container shiny-input-container-inline shiny-bound-input">
                                <label class="control-label" for="selectFeatureVis_H3K27me3">Select features:</label>
                                <div class="shiny-options-group">
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27me3" value="ChromHMM15">
                                    <span>ChromHMM15</span>
                                  </label>
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27me3" value="ChromHMM18">
                                    <span>ChromHMM18</span>
                                  </label>
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27me3" value="H3K27ac">
                                    <span>H3K27ac</span>
                                  </label>
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27me3" value="H3K4me1">
                                    <span>H3K4me1</span>
                                  </label>
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27me3" value="H3K4me3">
                                    <span>H3K4me3</span>
                                  </label>
                                  <label class="checkbox-inline">
                                    <input type="checkbox" name="selectFeatureVis_H3K27me3" value="H3K27me3">
                                    <span>H3K27me3</span>
                                  </label>
                                </div>
                              </div>

                                <label>Select samples and click finish selection button:</label> &nbsp&nbsp&nbsp&nbsp <button id="selectSampleVis_H3K27me3" type="button" class="btn btn2 btn-default action-button" ><label>finish selection</label></button>
                                <pre id="summary1Vis_H3K27me3" class="shiny-text-output"></pre>
                                <br> 


                                </p>
                                <br>')), #end of column 4

                    column(6,
                        HTML('
                          <br>
                          
                          <span class="tab"></span> <button id="selectAll_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                          <br>
                        '),
                        HTML('

                            <br>
                            <div class="panel-group">
                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Adult_Tissue_H3K27me3"> Adult Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Adult_Tissue_H3K27me3" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Adult_H3K27me3" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Blood_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Blood_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E062"/>
                                                <span class="checkContent" >E062 Primary mononuclear cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E034"/>
                                                <span class="checkContent">E034 Primary T cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E045"/>
                                                <span class="checkContent">E045 Primary T cells effector/memory enriched from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E044"/>
                                                <span class="checkContent">E044 Primary T regulatory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E043"/>
                                                <span class="checkContent">E043 Primary T helper cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E039"/>
                                                <span class="checkContent">E039 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E041"/>
                                                <span class="checkContent">E041 Primary T helper cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E042"/>
                                                <span class="checkContent">E042 Primary T helper 17 cells PMA-I stimulated</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E040"/>
                                                <span class="checkContent">E040 Primary T helper memory cells from peripheral blood 1</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E037"/>
                                                <span class="checkContent">E037 Primary T helper memory cells from peripheral blood 2</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E048"/>
                                                <span class="checkContent">E048 Primary T CD8+ memory cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E038"/>
                                                <span class="checkContent">E038 Primary T helper naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E047"/>
                                                <span class="checkContent">E047 Primary T CD8+ naive cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E029"/>
                                                <span class="checkContent">E029 Primary monocytes from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E035"/>
                                                <span class="checkContent">E035 Primary hematopoietic stem cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E051"/>
                                                <span class="checkContent">E051 Primary hematopoietic stem cells G-CSF-mobilized Male</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E050"/>
                                                <span class="checkContent">E050 Primary hematopoietic stem cells G-CSF-mobilized Female</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E036"/>
                                                <span class="checkContent">E036 Primary hematopoietic stem cells short term culture</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E032"/>
                                                <span class="checkContent">E032 Primary B cells from peripheral blood</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E046"/>
                                                <span class="checkContent">E046 Primary Natural Killer cells from peripheral blood</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E030"/>
                                                <span class="checkContent">E030 Primary neutrophils from peripheral blood</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Adult_H3K27me3" value="E124"/>
                                                <span class="checkContent">E124 Monocytes-CD14+ RO01746 Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Adult_H3K27me3" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>        
                                      <div id="collapse_Brain_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Brain_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27me3" value="E071"/>
                                                <span class="checkContent">E071 Brain Hippocampus Middle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27me3" value="E074"/>
                                                <span class="checkContent">E074 Brain Substantia Nigra</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27me3" value="E068"/>
                                                <span class="checkContent">E068 Brain Anterior Caudate</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27me3" value="E069"/>
                                                <span class="checkContent">E069 Brain Cingulate Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27me3" value="E072"/>
                                                <span class="checkContent">E072 Brain Inferior Temporal Lobe</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27me3" value="E067"/>
                                                <span class="checkContent">E067 Brain Angular Gyrus</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Adult_H3K27me3" value="E073"/>
                                                <span class="checkContent">E073 Brain_Dorsolateral_Prefrontal_Cortex</span>
                                              </label>
                                            </div>                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>
                           

                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Breast_Adult_H3K27me3" >Breast <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Breast_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Breast_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Breast_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Adult_H3K27me3" value="E027"/>
                                                <span class="checkContent">E027 Breast Myoepithelial Primary Cells</span>
                                              </label>
                                            </div>
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Fat_Adult_H3K27me3" >Fat <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Fat_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Fat_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Fat_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Adult_H3K27me3" value="E063"/>
                                                <span class="checkContent">E063 Adipose Nuclei</span>
                                              </label>
                                            </div>
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Colon_Adult_H3K27me3" >GI_Colon <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Colon_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Colon_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="GI_Colon_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K27me3" value="E076"/>
                                                <span class="checkContent">E076 Colon Smooth Muscle</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K27me3" value="E106"/>
                                                <span class="checkContent">E106 Sigmoid Colon</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Colon_Adult_H3K27me3" value="E075"/>
                                                <span class="checkContent">E075 Colonic Mucosa</span>
                                              </label>
                                            </div>                                    
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Duodenum_Adult_H3K27me3" >GI_Duodenum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Duodenum_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Duodenum_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="GI_Duodenum_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Duodenum_Adult_H3K27me3" value="E078"/>
                                                <span class="checkContent">E078 Duodenu</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Duodenum_Adult_H3K27me3" value="E077"/>
                                                <span class="checkContent">E077 Duodenum Mucosa</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Esophagus_Adult_H3K27me3" >GI_Esophagus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Esophagus_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Esophagus_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="GI_Esophagus_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Esophagus_Adult_H3K27me3" value="E079"/>
                                                <span class="checkContent">E079 Esophagus</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Adult_H3K27me3" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Adult_H3K27me3" value="E109"/>
                                                <span class="checkContent">E109 Small Intestin</span>
                                              </label>
                                            </div>                                   
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Rectum_Adult_H3K27me3" >GI_Rectum <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Rectum_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Rectum_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="GI_Rectum_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K27me3" value="E103"/>
                                                <span class="checkContent">E103 Rectal Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K27me3" value="E101"/>
                                                <span class="checkContent">E101 Rectal Mucosa Donor 29</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Rectum_Adult_H3K27me3" value="E102"/>
                                                <span class="checkContent">E102 Rectal Mucosa Donor 31</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Adult_H3K27me3" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K27me3" value="E111"/>
                                                <span class="checkContent">E111 Stomach Smooth Muscle</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K27me3" value="E110"/>
                                                <span class="checkContent">E110 Stomach Mucosa</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Adult_H3K27me3" value="E094"/>
                                                <span class="checkContent">E094 Gastric</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Heart_Adult_H3K27me3" >Heart <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Heart_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Heart_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Heart_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K27me3" value="E104"/>
                                                <span class="checkContent">E104 Right Atrium</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K27me3" value="E095"/>
                                                <span class="checkContent">E095 Left Ventricle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Adult_H3K27me3" value="E105"/>
                                                <span class="checkContent">E105 Right Ventricle</span>
                                              </label>
                                            </div>                                                                     
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_Adult_H3K27me3" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Liver_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_Adult_H3K27me3" value="E066"/>
                                                <span class="checkContent">E066 Liver</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Adult_H3K27me3" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Lung_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Adult_H3K27me3" value="E096"/>
                                                <span class="checkContent">E096 Lung</span>
                                              </label>
                                            </div>                                                                        
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Adult_H3K27me3" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Muscle_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K27me3" value="E100"/>
                                                <span class="checkContent">E100 Psoas Muscle</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K27me3" value="E108"/>
                                                <span class="checkContent">E108 Skeletal Muscle Female</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Adult_H3K27me3" value="E107"/>
                                                <span class="checkContent">E107 Skeletal Muscle Male</span>
                                              </label>
                                            </div>                                                                                                           
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Ovary_Adult_H3K27me3" >Ovary <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Ovary_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Ovary_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Ovary_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Ovary_Adult_H3K27me3" value="E097"/>
                                                <span class="checkContent">E097 Ovary</span>
                                              </label>
                                            </div>                                                                                                            
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Pancreas_Adult_H3K27me3" >Pancreas <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Pancreas_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Pancreas_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Pancreas_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult_H3K27me3" value="E087"/>
                                                <span class="checkContent">E087 Pancreatic Islets</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Pancreas_Adult_H3K27me3" value="E098"/>
                                                <span class="checkContent">E098 Pancreas</span>
                                              </label>
                                            </div>                                                                                                                           
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Spleen_Adult_H3K27me3" >Spleen <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Spleen_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Spleen_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Spleen_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Spleen_Adult_H3K27me3" value="E113"/>
                                                <span class="checkContent">E113 Spleen</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Adult_H3K27me3" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Thymus_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Adult_H3K27me3" value="E112"/>
                                                <span class="checkContent">E112 Thymus</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Adult_H3K27me3" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Adult_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Adult_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Vascular_Adult_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Adult_H3K27me3" value="E065"/>
                                                <span class="checkContent">E065 Aorta</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Fetal_Tissue_H3K27me3"> Fetal Cells/Tissues <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Fetal_Tissue_H3K27me3" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Adrenal_Fetal_H3K27me3" >Adrenal <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Adrenal_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Adrenal_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Adrenal_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Adrenal_Fetal_H3K27me3" value="E080"/>
                                                <span class="checkContent">E080 Fetal Adrenal Gland</span>
                                              </label>
                                            </div>                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Fetal_H3K27me3" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Blood_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Fetal_H3K27me3" value="E033"/>
                                                <span class="checkContent">E033 Primary T cells from cord blood</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Fetal_H3K27me3" value="E031"/>
                                                <span class="checkContent">E031 Primary B cells from cord blood</span>
                                              </label>
                                            </div>                                                                                                                                            
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Fetal_H3K27me3" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Brain_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Brain_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal_H3K27me3" value="E070"/>
                                                <span class="checkContent">E070 Brain Germinal Matrix</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal_H3K27me3" value="E082"/>
                                                <span class="checkContent">E082 Fetal Brain Female</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Fetal_H3K27me3" value="E081"/>
                                                <span class="checkContent">E081 Fetal Brain Male</span>
                                              </label>
                                            </div>                                                                                                                                                             
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Intestine_Fetal_H3K27me3" >GI_Intestine <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Intestine_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Intestine_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="GI_Intestine_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal_H3K27me3" value="E085"/>
                                                <span class="checkContent">E085 Fetal Intestine Small</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Intestine_Fetal_H3K27me3" value="E084"/>
                                                <span class="checkContent">E084 Fetal Intestine Large</span>
                                              </label>
                                            </div>                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_GI_Stomach_Fetal_H3K27me3" >GI_Stomach <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_GI_Stomach_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_GI_Stomach_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="GI_Stomach_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="GI_Stomach_Fetal_H3K27me3" value="E092"/>
                                                <span class="checkContent">E092 Fetal Stomach</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Heart_Fetal_H3K27me3" >Heart <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Heart_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Heart_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Heart_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Heart_Fetal_H3K27me3" value="E083"/>
                                                <span class="checkContent">E083 Fetal Heart</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Kidney_Fetal_H3K27me3" >Kidney <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Kidney_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Kidney_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Kidney_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Kidney_Fetal_H3K27me3" value="E086"/>
                                                <span class="checkContent">E086 Fetal Kidney</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Fetal_H3K27me3" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Lung_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Fetal_H3K27me3" value="E088"/>
                                                <span class="checkContent">E088 Fetal Lung</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Fetal_H3K27me3" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Muscle_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal_H3K27me3" value="E089"/>
                                                <span class="checkContent">E089 Fetal Muscle Trunk</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Fetal_H3K27me3" value="E090"/>
                                                <span class="checkContent">E090 Fetal Muscle Leg</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href= "#collapse_Placenta_Fetal_H3K27me3" >Placenta <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Placenta_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Placenta_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Placenta_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal_H3K27me3" value="E099"/>
                                                <span class="checkContent">E099 Placenta Amnion</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Placenta_Fetal_H3K27me3" value="E091"/>
                                                <span class="checkContent">E091 Placenta</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Thymus_Fetal_H3K27me3" >Thymus <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Thymus_Fetal_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Thymus_Fetal_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Thymus_Fetal_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Thymus_Fetal_H3K27me3" value="E093"/>
                                                <span class="checkContent">E093 Fetal Thymus</span>
                                              </label>
                                            </div>                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                        

                                                                          
                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_Culture_H3K27me3"> Primary Cultures <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_Culture_H3K27me3" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_Culture_H3K27me3" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Blood_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture_H3K27me3" value="E116"/>
                                                <span class="checkContent">E116 GM12878 Lymphoblastoid Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_Culture_H3K27me3" value="E123"/>
                                                <span class="checkContent">E123 K562 Leukemia Cells</span>
                                              </label>
                                            </div>                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Bone_Culture_H3K27me3" >Bone <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Bone_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Bone_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Bone_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Bone_Culture_H3K27me3" value="E129"/>
                                                <span class="checkContent">E129 Osteoblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Brain_Culture_H3K27me3" >Brain <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Brain_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Brain_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Brain_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_H3K27me3" value="E054"/>
                                                <span class="checkContent">E054 Ganglion Eminence derived primary cultured neurospheres</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_H3K27me3" value="E053"/>
                                                <span class="checkContent">E053 Cortex derived primary cultured neurospheres</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Brain_Culture_H3K27me3" value="E125"/>
                                                <span class="checkContent">E125 NH-A Astrocytes Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Breast_Culture_H3K27me3" >Breast <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Breast_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Breast_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Breast_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Culture_H3K27me3" value="E028"/>
                                                <span class="checkContent">E028 Breast variant Human Mammary Epithelial Cells (vHMEC)</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Breast_Culture_H3K27me3" value="E119"/>
                                                <span class="checkContent">E119 HMEC Mammary Epithelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Culture_H3K27me3" >ESC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="ESC_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27me3" value="E002"/>
                                                <span class="checkContent">E002 ES-WA7 Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27me3" value="E008"/>
                                                <span class="checkContent">E008 H9 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27me3" value="E001"/>
                                                <span class="checkContent">E001 ES-I3 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27me3" value="E015"/>
                                                <span class="checkContent">E015 HUES6 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27me3" value="E014"/>
                                                <span class="checkContent">E014 HUES48 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27me3" value="E016"/>
                                                <span class="checkContent">E016 HUES64 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27me3" value="E003"/>
                                                <span class="checkContent">E003 H1 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Culture_H3K27me3" value="E024"/>
                                                <span class="checkContent">E024 ES-UCSF4  Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_ESC_Derived_Culture_H3K27me3" >ESC_Derived <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_ESC_Derived_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_ESC_Derived_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="ESC_Derived_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27me3" value="E007"/>
                                                <span class="checkContent">E007 H1 Derived Neuronal Progenitor Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27me3" value="E009"/>
                                                <span class="checkContent">E009 H9 Derived Neuronal Progenitor Cultured Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27me3" value="E010"/>
                                                <span class="checkContent">E010 H9 Derived Neuron Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27me3" value="E013"/>
                                                <span class="checkContent">E013 hESC Derived CD56+ Mesoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27me3" value="E012"/>
                                                <span class="checkContent">E012 hESC Derived CD56+ Ectoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27me3" value="E011"/>
                                                <span class="checkContent">E011 hESC Derived CD184+ Endoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27me3" value="E004"/>
                                                <span class="checkContent">E004 H1 BMP4 Derived Mesendoderm Cultured Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27me3" value="E005"/>
                                                <span class="checkContent">E005 H1 BMP4 Derived Trophoblast Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="ESC_Derived_Culture_H3K27me3" value="E006"/>
                                                <span class="checkContent">E006 H1 Derived Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Fat_Culture_H3K27me3" >Fat <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Fat_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Fat_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Fat_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Culture_H3K27me3" value="E025"/>
                                                <span class="checkContent">E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Fat_Culture_H3K27me3" value="E023"/>
                                                <span class="checkContent">E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_IPSC_Culture_H3K27me3" >IPSC <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_IPSC_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_IPSC_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="IPSC_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K27me3" value="E020"/>
                                                <span class="checkContent">E020 iPS-20b Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K27me3" value="E019"/>
                                                <span class="checkContent">E019 iPS-18 Cells</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K27me3" value="E018"/>
                                                <span class="checkContent">E018 iPS-15b Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K27me3" value="E021"/>
                                                <span class="checkContent">E021 iPS DF 6.9 Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="IPSC_Culture_H3K27me3" value="E022"/>
                                                <span class="checkContent">E022 iPS DF 19.11 Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                              
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_Culture_H3K27me3" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Lung_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_Culture_H3K27me3" value="E128"/>
                                                <span class="checkContent">E128 NHLF Lung Fibroblast Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Muscle_Culture_H3K27me3" >Muscle <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Muscle_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Muscle_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Muscle_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K27me3" value="E052"/>
                                                <span class="checkContent">E052 Muscle Satellite Cultured Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K27me3" value="E120"/>
                                                <span class="checkContent">E120 HSMM Skeletal Muscle Myoblasts Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Muscle_Culture_H3K27me3" value="E121"/>
                                                <span class="checkContent">E121 HSMM cell derived Skeletal Muscle Myotubes Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                               
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Skin_Culture_H3K27me3" >Skin <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Skin_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Skin_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Skin_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27me3" value="E055"/>
                                                <span class="checkContent">E055 Foreskin Fibroblast Primary Cells skin01</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27me3" value="E056"/>
                                                <span class="checkContent">E056 Foreskin Fibroblast Primary Cells skin02</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27me3" value="E059"/>
                                                <span class="checkContent">E059 Foreskin Melanocyte Primary Cells skin01</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27me3" value="E061"/>
                                                <span class="checkContent">E061 Foreskin Melanocyte Primary Cells skin03</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27me3" value="E057"/>
                                                <span class="checkContent">E057 Foreskin Keratinocyte Primary Cells skin02</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27me3" value="E058"/>
                                                <span class="checkContent">E058 Foreskin Keratinocyte Primary Cells skin03</span>
                                              </label>
                                            </div> 
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27me3" value="E126"/>
                                                <span class="checkContent">E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells</span>
                                              </label>
                                            </div>
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Skin_Culture_H3K27me3" value="E127"/>
                                                <span class="checkContent">E127 NHEK-Epidermal Keratinocyte Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                 
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Stromal_Connective_Culture_H3K27me3" >Stromal_Connective <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Stromal_Connective_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Stromal_Connective_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Stromal_Connective_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture_H3K27me3" value="E026"/>
                                                <span class="checkContent">E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells</span>
                                              </label>
                                            </div>   
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Stromal_Connective_Culture_H3K27me3" value="E049"/>
                                                <span class="checkContent">E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Vascular_Culture_H3K27me3" >Vascular <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Vascular_Culture_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Vascular_Culture_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Vascular_Culture_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Vascular_Culture_H3K27me3" value="E122"/>
                                                <span class="checkContent">E122 HUVEC Umbilical Vein Endothelial Primary Cells</span>
                                              </label>
                                            </div>                                                                                                                                                                                                                                                                  
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                                                                                        


                                </div> 
                              </div>


                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title title_pos1">          
                                    <a data-toggle="collapse" href="#collapse_CellLine_H3K27me3"> Cell Lines <span class="caret"></span></a>
                                  </h4>
                                </div>   
                              <div id="collapse_CellLine_H3K27me3" class="panel-collapse collapse">


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Blood_CellLine_H3K27me3" >Blood <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Blood_CellLine_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Blood_CellLine_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Blood_CellLine_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Blood_CellLine_H3K27me3" value="E115"/>
                                                <span class="checkContent">E115 Dnd41 TCell Leukemia Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Cervix_CellLine_H3K27me3" >Cervix <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Cervix_CellLine_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Cervix_CellLine_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Cervix_CellLine_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Cervix_CellLine_H3K27me3" value="E117"/>
                                                <span class="checkContent">E117 HeLa-S3 Cervical Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Liver_CellLine_H3K27me3" >Liver <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Liver_CellLine_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Liver_CellLine_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Liver_CellLine_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Liver_CellLine_H3K27me3" value="E118"/>
                                                <span class="checkContent">E118 HepG2 Hepatocellular Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>


                                  <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <h4 class="panel-title title_pos2">
                                          <a data-toggle="collapse" href="#collapse_Lung_CellLine_H3K27me3" >Lung <span class="caret"></span></a>
                                          <span class="tab"></span> <button id="select_Lung_CellLine_H3K27me3" type="button" class="btn btn1 btn-default action-button"><span class="selectButton"> select/deselect all </span></button>
                                        </h4>
                                      </div>
                                      <div id="collapse_Lung_CellLine_H3K27me3" class="panel-collapse collapse"> 
                                        <div id="Lung_CellLine_H3K27me3" class="form-group shiny-input-checkboxgroup shiny-input-container" >
                                          <div class="shiny-options-group">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine_H3K27me3" value="E017"/>
                                                <span class="checkContent">E017 IMR90 fetal lung fibroblasts Cell Line</span>
                                              </label>
                                            </div>  
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="Lung_CellLine_H3K27me3" value="E114"/>
                                                <span class="checkContent">E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line</span>
                                              </label>
                                            </div>                                                                                                                                                                
                                          </div>
                                        </div> 
                                      </div>
                                  </div>                


                                </div> 
                              </div>


                            </div>
                              
                        ')#end of HTML
                    ) #end of column 8

                ) #end of fluidRow

                            
            ) ,#end of first level conditionalPanel


            #shared by all conditional panels
            radioButtons("selectMethod", "6. Select method and associated parameters:",inline = TRUE,width = '50%',
                      c("frequency cutoff" = "cutoff",
                        "Fisher's exact test" = "fisher",
                        "k-means clustering"="cluster")
                      ),
            helpText('Fisher\'s exact test method is not applicable when background samples are not specified. K-means clustering method is not applicable for analyzing uploaded data.'),
            conditionalPanel(condition = "input.selectMethod == 'cutoff'",
                  numericInput("foreCutoff", "Foreground cutoff:", 0.8,
                       min = 0, step=0.05, max = 1),
                  helpText('For a selected region, no less than 80% (default) of foreground samples have the feature in this region.'),
                  numericInput("backCutoff", "Background cutoff:", 0.2,
                       min = 0, step=0.05, max = 1),
                  helpText('For a selected region, no more than 20% (default) of background samples have the feature in this region.')
              ),

            conditionalPanel(condition = "input.selectMethod == 'fisher'",
                  numericInput("fisherCutoff", "Q-value cutoff:", 0.01,
                       min = 0, step=0.01, max = 1),
                  helpText('For a selected region, its q value from the test is less than 0.01 (default).')
              ),

            conditionalPanel(condition = "input.selectMethod == 'cluster'",
                  radioButtons("selectClusterNum", "Select cluster number:",inline = TRUE,width = '50%',
                            c("140 (optimal)" = "c140","90" = "c90","200" = "c200","250" = "c250")),
                  numericInput("clusterCutoff", "Foreground density cutoff :", 0.4,
                       min = 0, step=0.1, max = 1),
                  helpText('For a selected cluster, the median of feature densities of foreground samples in this cluster are no less than 0.4 (default).'),
                  numericInput("clusterQuantile", "Percentile cutoff (%):", 100,
                       min = 1, step=1, max = 100),
                  helpText('For a selected cluster, the median of feature densities of foreground samples in this cluster are no less than 100% (default) percentile of the feature densities of background samples.')
              ),
            

            singleton(tags$head(HTML(
            '
            <script type="text/javascript">
              $(document).ready(function() {
                // disable download at startup. data_file is the id of the downloadButton
                $("#processData").hide(); //modified on 11/1/2016
                $("#spin_bar").hide();
                $(".result").hide();
                $("#noSubmit").hide();
                $("#label").hide();
                $("#myProgress").hide();
                $("#proAddSam").hide();   // added 10-07-2016


                // added 10-07-2016
                Shiny.addCustomMessageHandler("upload_process_data", function(message) {
                  $("#proAddSam").show();
                });  

                Shiny.addCustomMessageHandler("finish_upload_process_data", function(message) {
                  $("#proAddSam").hide();
                });
                // added

                Shiny.addCustomMessageHandler("start_processing", function(message) {
                  $("#processData").show(); //modified on 11/1/2016
                  $("#spin_bar").show();
                });

                Shiny.addCustomMessageHandler("finish_processing", function(message) {
                  $("#processData").hide(); //modified on 11/1/2016
                  $("#spin_bar").hide();
                });
                Shiny.addCustomMessageHandler("no_submit", function(message) {
                  $("#noSubmit").show();
                });

                Shiny.addCustomMessageHandler("ok_submit", function(message) {
                  $("#noSubmit").hide();
                });
                Shiny.addCustomMessageHandler("download_ready", function(message) {
                  $("#data_file").show();
                  $("#CTM_H3K27ac_download").show();
                  $("#H3K27ac_enrich_download").show();
                  $("#more_information").show();
                });  
                Shiny.addCustomMessageHandler("download_notready", function(message) {
                  $("#data_file").hide();
                  $("#CTM_H3K27ac_download").hide();
                  $("#H3K27ac_enrich_download").hide();
                  $("#more_information").hide();
                });
                Shiny.addCustomMessageHandler("result_notready", function(message) {
                  $(".result").hide();
                  $("#image1").hide();
                  $("#image2").hide();
                  $("#image3").hide();
                  $("#image4").hide();
                  $("#table1").hide();
                  $("#summary_rank").hide();


                });  
                Shiny.addCustomMessageHandler("result_ready", function(message) {
                  $(".result").show();
                  $("#image1").show();
                  $("#image2").show();
                  $("#image3").show();
                  $("#image4").show();
                  $("#table1").show();
                  $("#summary_rank").show();
                });

                Shiny.addCustomMessageHandler("barProgress", function(message) {
                  move(message);
                });

                Shiny.addCustomMessageHandler("showProgress", function(message) {
                        $("#label").show();
                    $("#myProgress").show();
                });

                Shiny.addCustomMessageHandler("hideProgress", function(message) {
                        $("#label").hide();
                $("#myProgress").hide();
                });

              })

              function move(a) {
                var elem = document.getElementById("myBar");   
                elem.style.width = a[0] + "%"; 
                document.getElementById("label").innerHTML = a[1];
              }
            </script>
          '
          ))),

              #panel for submit and output
            hr(),
            fluidRow(actionButton(inputId = 'submit',label='Submit'),
            HTML('<span id="noSubmit">Please select foreground and background samples</span>')),
            #column(6,offset=3,HTML('<h3 id="noSubmit">Please select foreground and background samples</h3>')),
            HTML('<br><br><br>')  

        ) #end of column (10,offset=1)
    ), #end of first level tabPanel
  


    tabPanel(
        'Results',
        HTML('
            <div id="myProgress">
              <div id="myBar"></div>
            </div>
            <div id="label"></div>  
        '),
        column(10,offset=1,
            fluidRow(column(6,offset=3,
                #HTML('<h1 id="processData"> Processing ... &nbsp&nbsp&nbsp&nbsp(about 1-2 min)</h1> <br>'), #modified on 11/1/2016
                HTML('<span id="processData"> <br> <br> <br> </span> '), #modified on 11/1/2016
                tags$img(src = "spin_circle.gif",id = "spin_bar")  #modified on 11/1/2016
                )
            ),
            #data output
            column(6,
                HTML('<h3 class="result">Results:</h3>'),
                HTML(' <label class="result">Summary:</label> 
                      <pre id="summary_rank" class="shiny-text-output"></pre>'),
                HTML(' <label class="result">Data Table:</label>'),
                dataTableOutput('table1'),
                downloadButton('data_file', 'download unmerged table data'),   
                uiOutput('linkMergeGreat'), #added by Yu on 01/24/2017
                HTML('<br><br>')
                #helpText("Download will be available once the processing is completed.") 
              ),#end of column

            column(6,
                HTML('<br> <h3 class="result">Validation:</h3>'),

                HTML('<p class="result"><span class="glyphicon glyphicon-star"></span> Enrichment for H3K27ac peaks</p>'),
                plotOutput("image1"),
                HTML('<p class="result">The figure displays the enrichment fold of identified regions for H3K27ac peaks in different tissues.</p>'),
                downloadButton('H3K27ac_enrich_download', 'download figure data'),
                HTML('

                  <div id=more_information>
                      <h4 class="panel-title title_pos2">
                        <br>
                        <a data-toggle="collapse" href="#collapse_sample" ><h6>See detailed sample description <span class="caret"></span></h6></a>
                      </h4>

                    <div id="collapse_sample" class="panel-collapse collapse"> 
                      <table style="width:50%" >
                        <br>
                        <tr>
                          <th>ID</th>
                          <th>Sample description</th>
                          <th>Type</th>
                        </tr>

                        <tr>
                        <td>E001</td>
                        <td>ES-I3 Cells</td>
                        <td>ESC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E002</td>
                        <td>ES-WA7 Cells</td>
                        <td>ESC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E003</td>
                        <td>H1 Cells</td>
                        <td>ESC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E004</td>
                        <td>H1 BMP4 Derived Mesendoderm Cultured Cells</td>
                        <td>ESC_DERIVED_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E005</td>
                        <td>H1 BMP4 Derived Trophoblast Cultured Cells</td>
                        <td>ESC_DERIVED_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E006</td>
                        <td>H1 Derived Mesenchymal Stem Cells</td>
                        <td>ESC_DERIVED_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E007</td>
                        <td>H1 Derived Neuronal Progenitor Cultured Cells</td>
                        <td>ESC_DERIVED_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E008</td>
                        <td>H9 Cells</td>
                        <td>ESC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E009</td>
                        <td>H9 Derived Neuronal Progenitor Cultured Cells</td>
                        <td>ESC_DERIVED_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E010</td>
                        <td>H9 Derived Neuron Cultured Cells</td>
                        <td>ESC_DERIVED_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E011</td>
                        <td>hESC Derived CD184+ Endoderm Cultured Cells</td>
                        <td>ESC_DERIVED_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E012</td>
                        <td>hESC Derived CD56+ Ectoderm Cultured Cells</td>
                        <td>ESC_DERIVED_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E013</td>
                        <td>hESC Derived CD56+ Mesoderm Cultured Cells</td>
                        <td>ESC_DERIVED_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E014</td>
                        <td>HUES48 Cells</td>
                        <td>ESC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E015</td>
                        <td>HUES6 Cells</td>
                        <td>ESC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E016</td>
                        <td>HUES64 Cells</td>
                        <td>ESC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E017</td>
                        <td>IMR90 fetal lung fibroblasts Cell Line</td>
                        <td>LUNG_CellLine</td>
                        </tr>

                        <tr>
                        <td>E018</td>
                        <td>iPS-15b Cells</td>
                        <td>IPSC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E019</td>
                        <td>iPS-18 Cells</td>
                        <td>IPSC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E020</td>
                        <td>iPS-20b Cells</td>
                        <td>IPSC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E021</td>
                        <td>iPS DF 6.9 Cells</td>
                        <td>IPSC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E022</td>
                        <td>iPS DF 19.11 Cells</td>
                        <td>IPSC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E023</td>
                        <td>Mesenchymal Stem Cell Derived Adipocyte Cultured Cells</td>
                        <td>FAT_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E024</td>
                        <td>ES-UCSF4  Cells</td>
                        <td>ESC_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E025</td>
                        <td>Adipose Derived Mesenchymal Stem Cell Cultured Cells</td>
                        <td>FAT_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E026</td>
                        <td>Bone Marrow Derived Cultured Mesenchymal Stem Cells</td>
                        <td>STROMAL_CONNECTIVE_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E027</td>
                        <td>Breast Myoepithelial Primary Cells</td>
                        <td>BREAST_Adult</td>
                        </tr>

                        <tr>
                        <td>E028</td>
                        <td>Breast variant Human Mammary Epithelial Cells (vHMEC)</td>
                        <td>BREAST_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E029</td>
                        <td>Primary monocytes from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E030</td>
                        <td>Primary neutrophils from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E031</td>
                        <td>Primary B cells from cord blood</td>
                        <td>Blood_Fetal</td>
                        </tr>

                        <tr>
                        <td>E032</td>
                        <td>Primary B cells from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E033</td>
                        <td>Primary T cells from cord blood</td>
                        <td>Blood_Fetal</td>
                        </tr>

                        <tr>
                        <td>E034</td>
                        <td>Primary T cells from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E035</td>
                        <td>Primary hematopoietic stem cells</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E036</td>
                        <td>Primary hematopoietic stem cells short term culture</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E037</td>
                        <td>Primary T helper memory cells from peripheral blood 2</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E038</td>
                        <td>Primary T helper naive cells from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E039</td>
                        <td>Primary T helper naive cells from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E040</td>
                        <td>Primary T helper memory cells from peripheral blood 1</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E041</td>
                        <td>Primary T helper cells PMA-I stimulated</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E042</td>
                        <td>Primary T helper 17 cells PMA-I stimulated</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E043</td>
                        <td>Primary T helper cells from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E044</td>
                        <td>Primary T regulatory cells from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E045</td>
                        <td>Primary T cells effector/memory enriched from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E046</td>
                        <td>Primary Natural Killer cells from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E047</td>
                        <td>Primary T CD8+ naive cells from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E048</td>
                        <td>Primary T CD8+ memory cells from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E049</td>
                        <td>Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells</td>
                        <td>STROMAL_CONNECTIVE_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E050</td>
                        <td>Primary hematopoietic stem cells G-CSF-mobilized Female</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E051</td>
                        <td>Primary hematopoietic stem cells G-CSF-mobilized Male</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E052</td>
                        <td>Muscle Satellite Cultured Cells</td>
                        <td>MUSCLE_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E053</td>
                        <td>Cortex derived primary cultured neurospheres</td>
                        <td>BRAIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E054</td>
                        <td>Ganglion Eminence derived primary cultured neurospheres</td>
                        <td>BRAIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E055</td>
                        <td>Foreskin Fibroblast Primary Cells skin01</td>
                        <td>SKIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E056</td>
                        <td>Foreskin Fibroblast Primary Cells skin02</td>
                        <td>SKIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E057</td>
                        <td>Foreskin Keratinocyte Primary Cells skin02</td>
                        <td>SKIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E058</td>
                        <td>Foreskin Keratinocyte Primary Cells skin03</td>
                        <td>SKIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E059</td>
                        <td>Foreskin Melanocyte Primary Cells skin01</td>
                        <td>SKIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E061</td>
                        <td>Foreskin Melanocyte Primary Cells skin03</td>
                        <td>SKIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E062</td>
                        <td>Primary mononuclear cells from peripheral blood</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E063</td>
                        <td>Adipose Nuclei</td>
                        <td>FAT_Adult</td>
                        </tr>

                        <tr>
                        <td>E065</td>
                        <td>Aorta</td>
                        <td>VASCULAR_Adult</td>
                        </tr>

                        <tr>
                        <td>E066</td>
                        <td>Liver</td>
                        <td>LIVER_Adult</td>
                        </tr>

                        <tr>
                        <td>E067</td>
                        <td>Brain Angular Gyrus</td>
                        <td>BRAIN_Adult</td>
                        </tr>

                        <tr>
                        <td>E068</td>
                        <td>Brain Anterior Caudate</td>
                        <td>BRAIN_Adult</td>
                        </tr>

                        <tr>
                        <td>E069</td>
                        <td>Brain Cingulate Gyrus</td>
                        <td>BRAIN_Adult</td>
                        </tr>

                        <tr>
                        <td>E070</td>
                        <td>Brain Germinal Matrix</td>
                        <td>BRAIN_Fetal</td>
                        </tr>

                        <tr>
                        <td>E071</td>
                        <td>Brain Hippocampus Middle</td>
                        <td>BRAIN_Adult</td>
                        </tr>

                        <tr>
                        <td>E072</td>
                        <td>Brain Inferior Temporal Lobe</td>
                        <td>BRAIN_Adult</td>
                        </tr>

                        <tr>
                        <td>E073</td>
                        <td>Brain_Dorsolateral_Prefrontal_Cortex</td>
                        <td>BRAIN_Adult</td>
                        </tr>

                        <tr>
                        <td>E074</td>
                        <td>Brain Substantia Nigra</td>
                        <td>BRAIN_Adult</td>
                        </tr>

                        <tr>
                        <td>E075</td>
                        <td>Colonic Mucosa</td>
                        <td>GI_COLON_Adult</td>
                        </tr>

                        <tr>
                        <td>E076</td>
                        <td>Colon Smooth Muscle</td>
                        <td>GI_COLON_Adult</td>
                        </tr>

                        <tr>
                        <td>E077</td>
                        <td>Duodenum Mucosa</td>
                        <td>GI_DUODENUM_Adult</td>
                        </tr>

                        <tr>
                        <td>E078</td>
                        <td>Duodenum Smooth Muscle</td>
                        <td>GI_DUODENUM_Adult</td>
                        </tr>

                        <tr>
                        <td>E079</td>
                        <td>Esophagus</td>
                        <td>GI_ESOPHAGUS_Adult</td>
                        </tr>

                        <tr>
                        <td>E080</td>
                        <td>Fetal Adrenal Gland</td>
                        <td>ADRENAL_Fetal</td>
                        </tr>

                        <tr>
                        <td>E081</td>
                        <td>Fetal Brain Male</td>
                        <td>BRAIN_Fetal</td>
                        </tr>

                        <tr>
                        <td>E082</td>
                        <td>Fetal Brain Female</td>
                        <td>BRAIN_Fetal</td>
                        </tr>

                        <tr>
                        <td>E083</td>
                        <td>Fetal Heart</td>
                        <td>HEART_Fetal</td>
                        </tr>

                        <tr>
                        <td>E084</td>
                        <td>Fetal Intestine Large</td>
                        <td>GI_INTESTINE_Fetal</td>
                        </tr>

                        <tr>
                        <td>E085</td>
                        <td>Fetal Intestine Small</td>
                        <td>GI_INTESTINE_Fetal</td>
                        </tr>

                        <tr>
                        <td>E086</td>
                        <td>Fetal Kidney</td>
                        <td>KIDNEY_Fetal</td>
                        </tr>

                        <tr>
                        <td>E087</td>
                        <td>Pancreatic Islets</td>
                        <td>PANCREAS_Adult</td>
                        </tr>

                        <tr>
                        <td>E088</td>
                        <td>Fetal Lung</td>
                        <td>LUNG_Fetal</td>
                        </tr>

                        <tr>
                        <td>E089</td>
                        <td>Fetal Muscle Trunk</td>
                        <td>MUSCLE_Fetal</td>
                        </tr>

                        <tr>
                        <td>E090</td>
                        <td>Fetal Muscle Leg</td>
                        <td>MUSCLE_Fetal</td>
                        </tr>

                        <tr>
                        <td>E091</td>
                        <td>Placenta</td>
                        <td>PLACENTA_Fetal</td>
                        </tr>

                        <tr>
                        <td>E092</td>
                        <td>Fetal Stomach</td>
                        <td>GI_STOMACH_Fetal</td>
                        </tr>

                        <tr>
                        <td>E093</td>
                        <td>Fetal Thymus</td>
                        <td>THYMUS_Fetal</td>
                        </tr>

                        <tr>
                        <td>E094</td>
                        <td>Gastric</td>
                        <td>GI_STOMACH_Adult</td>
                        </tr>

                        <tr>
                        <td>E095</td>
                        <td>Left Ventricle</td>
                        <td>HEART_Adult</td>
                        </tr>

                        <tr>
                        <td>E096</td>
                        <td>Lung</td>
                        <td>LUNG_Adult</td>
                        </tr>

                        <tr>
                        <td>E097</td>
                        <td>Ovary</td>
                        <td>OVARY_Adult</td>
                        </tr>

                        <tr>
                        <td>E098</td>
                        <td>Pancreas</td>
                        <td>PANCREAS_Adult</td>
                        </tr>

                        <tr>
                        <td>E099</td>
                        <td>Placenta Amnion</td>
                        <td>PLACENTA_Fetal</td>
                        </tr>

                        <tr>
                        <td>E100</td>
                        <td>Psoas Muscle</td>
                        <td>MUSCLE_Adult</td>
                        </tr>

                        <tr>
                        <td>E101</td>
                        <td>Rectal Mucosa Donor 29</td>
                        <td>GI_RECTUM_Adult</td>
                        </tr>

                        <tr>
                        <td>E102</td>
                        <td>Rectal Mucosa Donor 31</td>
                        <td>GI_RECTUM_Adult</td>
                        </tr>

                        <tr>
                        <td>E103</td>
                        <td>Rectal Smooth Muscle</td>
                        <td>GI_RECTUM_Adult</td>
                        </tr>

                        <tr>
                        <td>E104</td>
                        <td>Right Atrium</td>
                        <td>HEART_Adult</td>
                        </tr>

                        <tr>
                        <td>E105</td>
                        <td>Right Ventricle</td>
                        <td>HEART_Adult</td>
                        </tr>

                        <tr>
                        <td>E106</td>
                        <td>Sigmoid Colon</td>
                        <td>GI_COLON_Adult</td>
                        </tr>

                        <tr>
                        <td>E107</td>
                        <td>Skeletal Muscle Male</td>
                        <td>MUSCLE_Adult</td>
                        </tr>

                        <tr>
                        <td>E108</td>
                        <td>Skeletal Muscle Female</td>
                        <td>MUSCLE_Adult</td>
                        </tr>

                        <tr>
                        <td>E109</td>
                        <td>Small Intestine</td>
                        <td>GI_INTESTINE_Adult</td>
                        </tr>

                        <tr>
                        <td>E110</td>
                        <td>Stomach Mucosa</td>
                        <td>GI_STOMACH_Adult</td>
                        </tr>

                        <tr>
                        <td>E111</td>
                        <td>Stomach Smooth Muscle</td>
                        <td>GI_STOMACH_Adult</td>
                        </tr>

                        <tr>
                        <td>E112</td>
                        <td>Thymus</td>
                        <td>THYMUS_Adult</td>
                        </tr>

                        <tr>
                        <td>E113</td>
                        <td>Spleen</td>
                        <td>SPLEEN_Adult</td>
                        </tr>

                        <tr>
                        <td>E114</td>
                        <td>A549 EtOH 0.02pct Lung Carcinoma Cell Line</td>
                        <td>LUNG_CellLine</td>
                        </tr>

                        <tr>
                        <td>E115</td>
                        <td>Dnd41 TCell Leukemia Cell Line</td>
                        <td>BLOOD_CellLine</td>
                        </tr>

                        <tr>
                        <td>E116</td>
                        <td>GM12878 Lymphoblastoid Cells</td>
                        <td>BLOOD_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E117</td>
                        <td>HeLa-S3 Cervical Carcinoma Cell Line</td>
                        <td>CERVIX_CellLine</td>
                        </tr>

                        <tr>
                        <td>E118</td>
                        <td>HepG2 Hepatocellular Carcinoma Cell Line</td>
                        <td>LIVER_CellLine</td>
                        </tr>

                        <tr>
                        <td>E119</td>
                        <td>HMEC Mammary Epithelial Primary Cells</td>
                        <td>BREAST_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E120</td>
                        <td>HSMM Skeletal Muscle Myoblasts Cells</td>
                        <td>MUSCLE_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E121</td>
                        <td>HSMM cell derived Skeletal Muscle Myotubes Cells</td>
                        <td>MUSCLE_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E122</td>
                        <td>HUVEC Umbilical Vein Endothelial Primary Cells</td>
                        <td>VASCULAR_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E123</td>
                        <td>K562 Leukemia Cells</td>
                        <td>BLOOD_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E124</td>
                        <td>Monocytes-CD14+ RO01746 Primary Cells</td>
                        <td>BLOOD_Adult</td>
                        </tr>

                        <tr>
                        <td>E125</td>
                        <td>NH-A Astrocytes Primary Cells</td>
                        <td>BRAIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E126</td>
                        <td>NHDF-Ad Adult Dermal Fibroblast Primary Cells</td>
                        <td>SKIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E127</td>
                        <td>NHEK-Epidermal Keratinocyte Primary Cells</td>
                        <td>SKIN_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E128</td>
                        <td>NHLF Lung Fibroblast Primary Cells</td>
                        <td>LUNG_PrimaryCulture</td>
                        </tr>

                        <tr>
                        <td>E129</td>
                        <td>Osteoblast Primary Cells</td>
                        <td>BONE_PrimaryCulture</td>
                        </tr>

                                      </table>
                                    </div>
                                  </div>

                '),

                HTML('<br> <br> <br> <p class="result"><span class="glyphicon glyphicon-star"></span> Tissue enrichment index for H3K27ac</p>'),
                plotOutput("image4"),
                HTML('<p class="result">The figure plots the tissue enrichment index CTM distribution based on H3K27ac expression for identified regions in different tissues.</p>'),
                downloadButton('CTM_H3K27ac_download', 'download  figure data')
            )

        )#end of column 10

    ), #end of first level tabPanel


    navbarMenu(
        'Help',
        tabPanel('About',
            column(10,offset=1,
                HTML('

                  <center><h1> EpiCompare: An online tool to define and explore genomic regions with tissue or cell type-specific epigenomic features</h1> 
                  </center><hr> 
                  <p> The Human Reference Epigenome Map, generated by the Roadmap Epigenomics Consortium, contains thousands of genome-wide epigenomic datasets that describe epigenomes of a variety of different human tissue and cell types. This map has allowed investigators to obtain a much deeper and more comprehensive view of our regulatory genome, for example defining regulatory elements including all promoters and enhancers for a given tissue or cell type. An outstanding task is to combine and compare different epigenomes in order to identify regions with epigenomic features specific to certain type of tissues or cells, for example, lineage-specific regulatory elements. Currently available tools do not directly address this question. This need motivated us to develop EpiCompare that allows investigators to easily identify regions with epigenetic features unique to specific epigenomes that they choose, making detection of common regulatory elements and/or cell type-specific regulatory elements an interactive and dynamic experience.  

                  Investigators can design their tests by choosing different combinations of epigenomes, and choosing different classification algorithms provided by our tool. EpiCompare will then identify regions with specified epigenomic features, and provide a quality assessment of the predictions. Investigators can interact with EpiCompare by investigating Roadmap Epigenomics data, or uploading their own data for comparison. Finally, prediction results can be readily visualized and further explored in the WashU Epigenome Browser.</p>
                  <br>


                  <h2> Index </h2>

                  <hr>
                  <ul>
                      <li style="display:block;"> <a href="#Datasets">1. Datasets</a>
                      </li>
                      <ul>
                          <li style="display:block"> <a href="#ChromHMM">1.1 Chromatin states</a>

                          </li>
                          <li style="display:block"> <a href="#H3K27ac">1.2 H3K27ac</a>

                          </li>
                          <li style="display:block"> <a href="#H3K4me1">1.3 H3K4me1</a>

                          </li>                
                          <li style="display:block"> <a href="#H3K4me3">1.4 H3K4me3</a>

                          </li> 
                          <li style="display:block"> <a href="#H3K27me3">1.5 H3K27me3</a>

                          </li> 

                      </ul>

                      <li style="display:block;"> <a href="#Methods">2. Methods</a>
                      </li>
                      <ul>
                          <li style="display:block"> <a href="#Cutoff">2.1 Frequncy cutoff</a>

                          </li>
                          <li style="display:block"> <a href="#Fisher">2.2 Fisher\'s exact test</a>

                          </li>
                          <li style="display:block"> <a href="#Clustering">2.3 K-means clustering</a>

                          </li>                
                      </ul>

                      <li style="display:block;"> <a href="#output">3. Output</a>
                      </li>
                      <ul>
                      <li style="display:block"> <a href="#Data">3.1 Data output</a>
                          </li>

                          <li style="display:block"> <a href="#Validation">3.2  Validation output</a>
                          </li>
                          <ul>
                            <li style="display:block"> <a href="#Enrich">3.2.1 Enrichment for H3K27ac peaks</a>

                            </li>

                            <li style="display:block"> <a href="#CTM">3.2.2 Tissue enrichment index on H3K27ac</a>

                            </li>                   
                          </ul>
                      </ul>

                      <li style="display:block;"> <a href="#How">4. How to use the tool</a>
                      </li>
                      <ul>
                          <li style="display:block"> <a href="#S1">4.1 Select a feature</a>
                          </li>
                          <li style="display:block"> <a href="#S2">4.2 Upload data</a>
                          </li>
                          <li style="display:block"> <a href="#S3">4.3 Select foreground samples</a>
                          </li>                
                          <li style="display:block"> <a href="#S4">4.4 Select background samples</a>
                          </li> 
                          <li style="display:block"> <a href="#S5">4.5 Select features and samples for visualization</a>
                          </li> 
                          <li style="display:block"> <a href="#S6">4.6 Select methods</a>
                          </li>                                 
                          <li style="display:block"> <a href="#S7">4.7 Submit</a>
                          </li>
                      </ul>

                      <li style="display:block;"> <a href="#ref">5. Reference</a>
                      </li>            
                  </ul>

                  <br>
                  <br>
                  <h2> <a name="Datasets">1. Datasets</a></h2>
                  For each feature - the <a href="http://compbio.mit.edu/ChromHMM/">ChromHMM </a> state or epigenomic modification peak below, it is converted into binary presence or absence of the feature in each 200bp window, denoted by 1 or 0. A table is generated for each feature by summarizing the presence or absence of the feature in all samples across windows where at least one sample has the feature.
                  <hr>
                  <h3> <a name="ChromHMM">1.1 Chromatin states </a></h3> Chromatin state data for 15-state model and 18-state model for all tissue/cell types (127 samples have chromatin states from 15-state model and 98 samples from 18-state model) are obtained from Roadmap Epigenomics Project (Roadmap Epigenomics, et al., 2015). Enhancers for <a href="http://egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html#core_15state ">15-state model </a> are defined as state number 6, 7, 12 and enhancers for <a href="http://egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html#exp_18state ">18-state model </a>  are defined as state number 7, 8, 9, 10, 11, 15. Promoters for 15-state model are defined as state number 1, 2, 10 and promoters for 18-state model are defined as state number 1, 2, 3, 4, 14. Chromatin states are defined on each 200bp window by ChromHMM.

                  <h3> <a name="H3K27ac">1.2 H3K27ac </a></h3> H3K27ac peak data for 98 tissue/cell types are obtained from Roadmap Epigenomics Project. The peaks are called by MACS2 (Zhang, et al., 2008). H3K27ac peak data are processed on 200bp window by requiring at least 50bp overlapping with 200bp window in the genome. Only peaks with q-value less than 0.01 are kept.

                  <h3> <a name="H3K4me1">1.3 H3K4me1 </a></h3> H3K4me1 peak data for 127 tissue/cell types are obtained from Roadmap Epigenomics Project. The peaks are called by MACS2. H3K4me1 peak data are processed on 200bp window by requiring at least 50bp overlapping with 200bp window in the genome. Only peaks with q-value less than 0.01 are kept.

                  <h3> <a name="H3K4me3">1.4 H3K4me3 </a></h3> H3K4me3 peak data for 127 tissue/cell types are obtained from Roadmap Epigenomics Project. The peaks are called by MACS2. H3K4me3 peak data are processed on 200bp window by requiring at least 50bp overlapping with 200bp window in the genome. Only peaks with q-value less than 0.01 are kept.

                  <h3> <a name="H3K27me3">1.5 H3K27me3 </a></h3> H3K27me3 peak data for 127 tissue/cell types are obtained from Roadmap Epigenomics Project. The peaks are called by MACS2. H3K27me3 peak data are processed on 200bp window by requiring at least 50bp overlapping with 200bp window in the genome. Only peaks with q-value less than 0.01 are kept.


                  <br>
                  <br>
                  <h2> <a name="Methods">2. Methods</a></h2>

                  <hr> Three methods are used for identifying regions with epigenomic features specific to combinations of tissue or cell types. All methods require the definition of foreground samples and background samples by users. Foreground samples are the group of samples for which we identify specific regions. Background samples are the group of samples against which we compare foreground samples. The principle of all methods is, to define regions with features specific in foreground samples, the features should be enriched in foreground samples but depleted in background samples. 

                  <h3> <a name="Cutoff">2.1 Frequency cutoff </a></h3> For each region (in this case each 200bp genomic window), the percentages of samples having the feature in foreground samples and background samples are calculated. If the percentage of samples having the feature in the foreground samples is greater than or equal to the defined minimal foreground cutoff (default is 80%) and the percentage of samples having the feature in the background samples is less than or equal to the defined maximal background cutoff (default is 20%), then the region is defined as a positive region. These positive regions are further ranked by the difference between the percentage of samples having the feature in foreground and background samples so users can prioritize top-ranked regions. 

                  <h3> <a name="Fisher">2.2 Fisher\'s exact test </a></h3> For each 200bp window, a contingency table composed of the number of samples with or without the feature in foreground samples and background samples is calculated. Fisher’s exact test is used to examine whether the percentage of features in foreground samples is significantly greater than in background samples. The p-value is corrected by multiple hypothesis testing using the Benjamini-Hochberg procedure, and regions with q-value less than a cutoff (default is 0.01) are identified and ranked by their q-values. The statistical power of the test depends on the number of foreground and background samples and having more samples can provide more statistical power to identify more significant q-values. Therefore, when the number of foreground samples is small, investigators can use q-value as a ranking measure and obtain the top candidates by setting a higher q-value threshold.

                  <h3> <a name="Clustering">2.3 K-means clustering </a></h3> First, k-means clustering based on a Jaccard-index distance is performed on the binary data table for each feature, similar to the clustering method used in HoneyBadger2 (Roadmap Epigenomics, et al., 2015). R package flexclust is used for clustering (Leisch, 2006). We chose the optimal cluster number by the elbow method and the silhouette method (Kodinariya and Makwana, 2013). The optimal cluster number for all features is close and around 140, so we fixed the optimal cluster number to be 140. Besides providing the clustering result using the optimal cluster number, we also provided clustering results with three other cluster numbers (90, 200, 250) depending on the users’ need. Next, the percentage of regions having the feature is calculated for each cluster and defined as a feature density table (number of clusters times number of samples). Finally, a cluster specific for a tissue/cell type should have higher feature density in that tissue/cell type than in the background samples. Specifically, to identify clusters specific for foreground samples, we select clusters satisfying the following two conditions: first, the median of feature densities of foreground samples in a cluster is greater than or equal to a threshold (default is 0.4); second, it should also be greater than or equal to the highest feature density in the background samples of that same cluster (this threshold can be set to any percentile of feature densities in the background samples).

                  <br>
                  <br>
                  <h2> <a name="Output">3. Output </a></h2>

                  <hr>
                  <h3> <a name="Data">3.1 Data output </a></h3> Identified regions are displayed on a table whose columns are chr, start, end, and link to <a href="http://epigenomegateway.wustl.edu/">WashU Epigenome Browser</a> so users can visualize and compare the regions in different tissue/cell types. For Fisher’s exact test and frequency cutoff method, a summary is provided about the distribution of ranks for identified regions. Links are provided to download unmerged 200bp regions or merged regions which merge neighboring 200bp regions. A link to <a href="http://bejerano.stanford.edu/great/public/html/">GREAT</a> analysis for merged regions is also provided.

                  <h3><a name="Validation">3.2  Validation output </a></h3> 
                  <h4> <a name="Enrich">3.2.1 Enrichment for H3K27ac peaks </a></h4> Enrichment for H3K27ac peaks in foreground samples and background samples are calculated for identified regions. Enrichment is defined as below:

                  enrichment=((#bp in overlapped regions)⁄(#bp in H3K27ac sites ))/(#bp (identified regions)⁄(#bp in hg19 genome)) . When the number of foreground samples or background samples is bigger than 10, 10 random samples from foreground samples or background samples are chosen to calculate the enrichment.


                  <h4> <a name="CTM">3.2.2 Tissue enrichment index on H3K27ac </a></h4>a tissue enrichment index for identified regions is calculated using H3K27ac RPKM (Reads Per Kilobase of transcript per Million mapped reads). Identified regions are filtered using combined H3K27ac peaks from 98 samples and the tissue enrichment index is calculated for filtered regions. Tissue enrichment index has been routinely used to identify tissue-specific genes (Chang, et al., 2011; Yanai, et al., 2005). Generally, a high tissue enrichment index represents tissue-specific regions. The tissue enrichment index we use is a contribution measure (CTM) (Pan, et al., 2013). 
                  <figure><img src="ctm.png"  height="300" ></figure>


                  <br>
                  <br>

                  <h2> <a name="How">4. How to use the tool</a></h2>

                  <hr> Below lists each step of using the tool and specific requirements for each step.
                  <h3> <a name="S1">4.1 Select a feature </a></h3> Select the feature for which you plan to identify the specificity. It can be enhancers or promoters defined from 15 state or 18 state ChromHMM model, histone mark H3K27ac, H3K4me1, H3K4me1, or H3K4me3. Only one feature can be chosen.  
                  <figure><img src="f1.png"  height="200" ></figure>
                  <br>

                  <h3> <a name="S2" id="S2">4.2 Upload data </a></h3> Upload your own data for comparison analysis besides using default Roadmap data. Skip this step if you don\'t want to use your own data. You can upload one file or multiple files. The files must have only three columns (chromosome, start, end) specifying the location of the feature. The coordinates can be merged or not. The tool will map the coordinates to 200bp window by requiring at least 1bp overlapping. After uploading files, the name of each file will be listed on top of Roadmap samples for selection. Only frequency cutoff and Fisher\'s exact test can be used to analyze uploaded data while k-means clustering method cannot be used. 
                  <br>
                  <p>1.Here is a <a href="upload_test.txt">test file </a>. Download the file to your local drive.</p>
                  <br>
                  <p>2.Upload this file locally. The file will be uploaded and processed.</p>
                  <figure><img src="upload2.png"  height="200" ></figure>
                  <br>
                  <p>3.After processing, the name of uploaded file (removing suffix) will be listed as user-defined samples.</p>
                  <figure><img src="upload1.png"  height="200" ></figure>

                  <h3> <a name="S3">4.3 Select foreground samples </a></h3> Select the group of samples for which you identify specific regions. They can be chosen from Roadmap samples or uploaded samples. Click finish selection button after finishing selection. Selected sample IDs for foreground samples will be listed.
                  <h3> <a name="S4">4.4 Select background samples </a></h3> Keep selected foreground samples in step 3 unchanged and select background samples, which are the group of samples against which we compare foreground samples. <b>The selected foreground samples in step 3 must not be unselected because the tool subtracts the selection in step 3 from all selections in step 4 to obtain selected background samples </b>. Click finish selection button after finishing selection. Selected sample IDs for background samples will be listed. If background samples are not specified, the tool will identify shared enhancers for foreground samples. Only frequency cutoff and k-means clustering method can be used without background samples, while Fisher\'s exact test cannot.
                  <figure><img src="f2.png"  height="300" ></figure>
                  <br>

                  <h3> <a name="S5">4.5 Select features and samples for visualization </a></h3> Select features and samples for visualization in WashU Epigenome Browser. Click finish selection button after finishing selection. Selected sample IDs will be listed. If both features and samples are not chosen, the default values for them will be used, which are the feature selected in step 1 and foreground samples selected in step 3.
                  <figure><img src="f3.png"  height="250" ></figure>
                  <br>

                  <h3> <a name="S6">4.6 Select a method </a></h3> <p>Select frequency cutoff, Fisher\'s exact test or k-means clustering method and the parameters for each method.</p> <p>1) Frequency cutoff method: a region is defined as a positive region if the percentage of samples having the feature in the foreground samples is greater than or equal to a cutoff (default is 80%, called foreground cutoff) and the percentage of samples having the feature in the background samples is less than or equal to a cutoff (default is 20%, called background cutoff). </p> <p>2) Fisher\'s exact test method: A region is defined as a positive region if the q-value from Fisher\'s exact test is less than a cutoff (default is 0.01, called q-value cutoff). When the number of foreground samples is small, Fisher’s exact test method cannot identify any regions with q-value threshold less than 0.01. In this case, investigators can use q-value as a ranking measure and obtain the top candidates by setting a high q-value cutoff. </p> <p>3) K-means clustering method: Clusters specific for foreground samples should satisfy the following two conditions. First, the median of feature densities of foreground samples in this cluster is greater than or equal to a cutoff (default is 0.4, called foreground density cutoff); second, the median of feature densities of foreground samples is also greater than or equal to the percentile cutoff of feature densities of the background samples (default is 100%, which is the maximal feature density of the background samples, called percentile cutoff). The feature density in one cluster is the proportion of regions for one sample having the feature in the cluster. A value of 50% means half of the regions have the feature in the cluster.</p> <p><b>Fisher\'s exact test method is not applicable when background samples are not specified. K-means clustering method is not applicable for analyzing uploaded data.</b></p>
                  <figure><img src="f4.png"  height="300" ></figure>
                  <br>

                  <h3> <a name="S7">4.7 Submit </a></h3> Click submit button and start analysis. The result will be available in 1 to 3 minutes.
                  <p>This is the table of identified regions.</p>
                  <figure><img src="f5.png"  height="800" ></figure>
                  <br>
                  <p>This is the validation results: enrichment for H3K27ac peaks and tissue enrichment index on H3K27ac.</p>
                  <figure><img src="f6.png"  height="500" ></figure>
                  <figure><img src="f7.png"  height="400" ></figure>
                  <br>
                  <p>This is the visualziation in Washu Epigenome Browser for an identified region.</p>
                  <figure><img src="f8.png"  height="400" ></figure>        
                  <br>
                  <br>


                  <h2> <a name="ref">5. Reference</a></h2> <p>Chang, C.W., et al. Identification of human housekeeping genes and tissue-selective genes by microarray meta-analysis. PLoS One 2011;6(7):e22859.</p>
                  <p>Leisch. A Toolbox for K-Centroids Cluster Analysis. Computational Statistics and Data Analysis, 51 (2), 526-544, 2006.</p>
                  <p>Pan, J.B., et al. PaGenBase: a pattern gene database for the global and dynamic understanding of gene function. PLoS One 2013;8(12):e80747.</p>
                  <p> Roadmap Epigenomics, C., et al. Integrative analysis of 111 reference human epigenomes. Nature 2015;518(7539):317-330.
                  </p>
                  <p> Zhang, Y., et al. Model-based analysis of ChIP-Seq (MACS). Genome Biol 2008;9(9):R137.p>
                  <p>Yanai, I., et al. Genome-wide midrange transcription profiles reveal expression level relationships in human tissue specification. Bioinformatics 2005;21(5):650-659.</p>
                ')
            )#end of title      
        ),#end of tabPanel
        tabPanel('Contact',
            column(10,offset=1,
                HTML('
                    <p>Any questions are welcome. Please contact <b>yu.he (at) wustl.edu .</b></p>
                ')
            )
        )
    ) #end of first level tabPanel


) #end of ui




