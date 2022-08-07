%% A_ Find BP-target genes

load('A_SGD_bound_results.mat');

%% Breast invasive carcinoma (BRCA)
% 1 BRCA NT  Normal tissue
% 2 BRCA TM  Tumor metastatic (spredning)
% 3 BRCA TP  Tumor primary



% BRCA_NT
a = all_SGD_results.essentialGenes{1,1};

% BRCA_TM 
b = all_SGD_results.essentialGenes{2,1};

% BRCA_TP
c = all_SGD_results.essentialGenes{3,1};


% Unique e-genes for Metastatic Tumor compared to NT
BRCA_TM_BPtargetGene= b (~ismember(b,a));    
% ~ismember finds the e-genes in the TM that are -not- in the e-genes of 
% normal. Returns a list of these genes.   

% Unique e-genes for Primary Tumor compared to NT
BRCA_TP_BPtargetGene = c (~ismember(c,a));    
% ~ismember finds the e-genes in the TP that are -not- in the e-genes of
% normal. Returns a list of these genes 


%% Cervical squamous cell carcinoma and endocervical adenocarcinoma (CESC)

% 4 CESC NT  Normal tissue
% 5 CESC TM  Tumor metastatic (spredning)
% 6 CESC TP  Tumor primary



% CESC_NT_57 
a = all_SGD_results.essentialGenes{4,1};

% CESC_TM_57 
b = all_SGD_results.essentialGenes{5,1};

% CESC_TP_57
c = all_SGD_results.essentialGenes{6,1};


% Unique e-genes for Metastatic Tumor compared to NT
CESC_TM_BPtargetGene= b (~ismember(b,a));    
% ~ismember finds the e-genes in the TM that are -not- in the e-genes of 
% normal. Returns a list of these genes.   

% Unique e-genes for Primary Tumor compared to NT
CESC_TP_BPtargetGene = c (~ismember(c,a));    
% ~ismember finds the e-genes in the TP that are -not- in the e-genes of
% normal. Returns a list of these genes 


%%  Lung adenocarcinoma (LUAD)
% 7 LUAD NT  Normal tissue
% 9 LUAD TR  Tumor Recurring
% 8 LUAD TP  Tumor primary



% LUAD_NT_57 
a = all_SGD_results.essentialGenes{7,1};

% LUAD_TR_57 
b = all_SGD_results.essentialGenes{9,1};

% LUAD_TP_57
c = all_SGD_results.essentialGenes{8,1};


% Unique e-genes for Recurring Tumor compared to NT
LUAD_TR_BPtargetGene = b (~ismember(b,a));    
% ~ismember finds the e-genes in the TR that are -not- in the e-genes of 
% normal. Returns a list of these genes.   

% Unique e-genes for Primary Tumor compared to NT
LUAD_TP_BPtargetGene = c (~ismember(c,a));    
% ~ismember finds the e-genes in the TP that are -not- in the e-genes of
% normal. Returns a list of these genes 


%% Pancreatic adenocarcinoma (PAAD)
% 10 PAAD NT  Normal tissue
% 11 PAAD TM  Tumor metastatic (spredning)
% 12 PAAD TP  Tumor primary



% PAAD_NT_57 
a = all_SGD_results.essentialGenes{10,1};

% PAAD_TM_57 
b = all_SGD_results.essentialGenes{11,1};

% PAAD_TP_57
c = all_SGD_results.essentialGenes{12,1};


% Unique e-genes for Metastatic Tumor compared to NT
PAAD_TM_BPtargetGene= b (~ismember(b,a));    
% ~ismember finds the e-genes in the TM that are -not- in the e-genes of 
% normal. Returns a list of these genes.   

% Unique e-genes for Primary Tumor compared to NT
PAAD_TP_BPtargetGene = c (~ismember(c,a));    
% ~ismember finds the e-genes in the TP that are -not- in the e-genes of
% normal. Returns a list of these genes 




%% 	Prostate adenocarcinoma (PRAD)

% 13 PRAD NT  Normal tissue
% 14 PRAD TM  Tumor metastatic (spredning)
% 15 PRAD TP  Tumor primary



% PRAD_NT_57 
a = all_SGD_results.essentialGenes{13,1};

% PRAD_TM_57 
b = all_SGD_results.essentialGenes{14,1};

% PRAD_TP_57
c = all_SGD_results.essentialGenes{15,1};


% Unique e-genes for Metastatic Tumor compared to NT
PRAD_TM_BPtargetGene= b (~ismember(b,a));    
% ~ismember finds the e-genes in the TM that are -not- in the e-genes of 
% normal. Returns a list of these genes.   

% Unique e-genes for Primary Tumor compared to NT
PRAD_TP_BPtargetGene = c (~ismember(c,a));    
% ~ismember finds the e-genes in the TP that are -not- in the e-genes of
% normal. Returns a list of these genes 

save('A_BP_targetGenes','BRCA_TM_BPtargetGene','BRCA_TP_BPtargetGene','CESC_TM_BPtargetGene','CESC_TP_BPtargetGene','LUAD_TR_BPtargetGene', 'LUAD_TP_BPtargetGene','PAAD_TM_BPtargetGene', 'PAAD_TP_BPtargetGene', 'PRAD_TM_BPtargetGene', 'PRAD_TP_BPtargetGene');

