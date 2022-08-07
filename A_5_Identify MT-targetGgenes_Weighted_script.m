%% Identify MT-target-genes and their weights
% This script uses the output from the SGD_MetabolicTasks_script, called
% 'LethalGenes57', to find what essential genes (e-genes) are found ONLY in
% in the tumor and NOT in normal tissue (NT), i.e the TARGET-genes. 



%% Finding essential genes unique to a model
% Goal: Finding the essential genes (e-genes) that only appear in the
% tumor models' set of e-genes and not the normal tissues' e-genes, and how
% many essential tasks they fail.


% The Logic:
% Need to search through tumor e-genes and exclude all that are also found
% in normal tissue e-genes. What is left are the target-genes that, if deleted,
% are only fatal to the tumor. 



%Load MT SGD results 
    load('C:\Users\Rebecca\Documents\Data\5. klasse MTKJ\0. MASTEROPPGAVE\Koding\Master\Results\A_LethalGenes_57_results.mat');


%% Breast invasive carcinoma (BRCA)
% 1 BRCA NT  Normal tissue
% 2 BRCA TM  Tumor metastatic (spredning)
% 3 BRCA TP  Tumor primary



% BRCA_NT_57 
a = LethalGenes57.lethalAndWeight{1,1}(:,1);

% BRCA_TM_57 
b = LethalGenes57.lethalAndWeight{2,1}(:,1);
b2 = LethalGenes57.lethalAndWeight{2,1}(:,2);
% BRCA_TP_57
c = LethalGenes57.lethalAndWeight{3,1}(:,1);
c2 = LethalGenes57.lethalAndWeight{3,1}(:,2);

% Unique e-genes for Metastatic Tumor compared to NT
BRCA_57_TM_vs_NT_egenes = [(b (~ismember(b,a))) (b2 (~ismember(b,a)))];  % DENNE FUNKER!!!!!!! 
% ~ismember finds the e-genes in the TM that are -not- in the e-genes of 
% normal. Returns a list of these genes.   

% Unique e-genes for Primary Tumor compared to NT
BRCA_57_TP_vs_NT_egenes = [(c (~ismember(c,a))) (c2 (~ismember(c,a)))];     
% ~ismember finds the e-genes in the TP that are -not- in the e-genes of
% normal. Returns a list of these genes 


%% Cervical squamous cell carcinoma and endocervical adenocarcinoma (CESC)

% 4 CESC NT  Normal tissue
% 5 CESC TM  Tumor metastatic (spredning)
% 6 CESC TP  Tumor primary



% CESC_NT_57 
a = LethalGenes57.lethalAndWeight{4,1}(:,1);

% CESC_TM_57 
b = LethalGenes57.lethalAndWeight{5,1}(:,1);
b2 = LethalGenes57.lethalAndWeight{5,1}(:,2);

% CESC_TP_57
c = LethalGenes57.lethalAndWeight{6,1}(:,1);
c2 = LethalGenes57.lethalAndWeight{6,1}(:,2);

% Unique e-genes for Metastatic Tumor compared to NT
CESC_57_TM_vs_NT_egenes = [(b (~ismember(b,a))) (b2 (~ismember(b,a)))];  
% ~ismember finds the e-genes in the TM that are -not- in the e-genes of 
% normal. Returns a list of these genes.   

% Unique e-genes for Primary Tumor compared to NT
CESC_57_TP_vs_NT_egenes = [(c (~ismember(c,a))) (c2 (~ismember(c,a)))];   
% ~ismember finds the e-genes in the TP that are -not- in the e-genes of
% normal. Returns a list of these genes 


%%  Lung adenocarcinoma (LUAD)
% 7 LUAD NT  Normal tissue
% 9 LUAD TR  Tumor Recurring
% 8 LUAD TP  Tumor primary



% LUAD_NT_57 
a = LethalGenes57.lethalAndWeight{7,1}(:,1);

% LUAD_TR_57 
b = LethalGenes57.lethalAndWeight{9,1}(:,1);
b2 = LethalGenes57.lethalAndWeight{9,1}(:,2);

% LUAD_TP_57
c = LethalGenes57.lethalAndWeight{8,1}(:,1);
c2 = LethalGenes57.lethalAndWeight{8,1}(:,2);

% Unique e-genes for Recurring Tumor compared to NT
LUAD_57_TR_vs_NT_egenes =[(b (~ismember(b,a))) (b2 (~ismember(b,a)))];   
% ~ismember finds the e-genes in the TR that are -not- in the e-genes of 
% normal. Returns a list of these genes.   

% Unique e-genes for Primary Tumor compared to NT
LUAD_57_TP_vs_NT_egenes = [(c (~ismember(c,a))) (c2 (~ismember(c,a)))];    
% ~ismember finds the e-genes in the TP that are -not- in the e-genes of
% normal. Returns a list of these genes 


%% Pancreatic adenocarcinoma (PAAD)
% 10 PAAD NT  Normal tissue
% 11 PAAD TM  Tumor metastatic (spredning)
% 12 PAAD TP  Tumor primary



% PAAD_NT_57 
a = LethalGenes57.lethalAndWeight{10,1}(:,1);

% PAAD_TM_57 
b = LethalGenes57.lethalAndWeight{11,1}(:,1);
b2 = LethalGenes57.lethalAndWeight{11,1}(:,2);
% PAAD_TP_57
c = LethalGenes57.lethalAndWeight{12,1}(:,1);
c2 = LethalGenes57.lethalAndWeight{12,1}(:,2);

% Unique e-genes for Metastatic Tumor compared to NT
PAAD_57_TM_vs_NT_egenes = [(b (~ismember(b,a))) (b2 (~ismember(b,a)))];    
% ~ismember finds the e-genes in the TM that are -not- in the e-genes of 
% normal. Returns a list of these genes.   

% Unique e-genes for Primary Tumor compared to NT
PAAD_57_TP_vs_NT_egenes = [(c (~ismember(c,a))) (c2 (~ismember(c,a)))];     
% ~ismember finds the e-genes in the TP that are -not- in the e-genes of
% normal. Returns a list of these genes 




%% 	Prostate adenocarcinoma (PRAD)

% 13 PRAD NT  Normal tissue
% 14 PRAD TM  Tumor metastatic (spredning)
% 15 PRAD TP  Tumor primary



% PRAD_NT_57 
a = LethalGenes57.lethalAndWeight{13,1}(:,1);

% PRAD_TM_57 
b = LethalGenes57.lethalAndWeight{14,1}(:,1);
b2 = LethalGenes57.lethalAndWeight{14,1}(:,2);

% PRAD_TP_57
c = LethalGenes57.lethalAndWeight{15,1}(:,1);
c2 = LethalGenes57.lethalAndWeight{15,1}(:,2);

% Unique e-genes for Metastatic Tumor compared to NT
PRAD_57_TM_vs_NT_egenes = [(b (~ismember(b,a))) (b2 (~ismember(b,a)))];   
% ~ismember finds the e-genes in the TM that are -not- in the e-genes of 
% normal. Returns a list of these genes.   

% Unique e-genes for Primary Tumor compared to NT
PRAD_57_TP_vs_NT_egenes =[(c (~ismember(c,a))) (c2 (~ismember(c,a)))];    
% ~ismember finds the e-genes in the TP that are -not- in the e-genes of
% normal. Returns a list of these genes 


save('Unique e-genes for tissues_Weighted');









