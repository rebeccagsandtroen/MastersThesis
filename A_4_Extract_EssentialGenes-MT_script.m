%% Extracting lists of MT essential genes 
% This script refines the result from the SGD analysis with MT. 
% Any gene that fails any of the 57 essential genes are considered
% essential for cell viability.
% Goal: Make a list of the MT essential genes for each model

%        Make sure current directory is set to "Results" before running


% Load file containing eGenes struct
load('C:\Users\Rebecca\Documents\Data\5. klasse MTKJ\0. MASTEROPPGAVE\Koding\Master\Results\CheckTaskGenes_results.mat');


% Collect results in a struct LethalGenes, that describes which genes, if
% deleted, are fatal to the cell by disrupting one or more of the 57
% essential reactions. 
LethalGenes57 = {};

for i = 1:length(eGenes.tissues)  % Iterate through all models 

m = eGenes.essentialGenes{i,1};  %Her er matrisen for essential genes. 

% Condensed version
boolVec_essentialGenes{i,1} = any(m,2);    % Gives a column with true/false if any elements in row is true (1)

% Weighted version 
weight_essentialGenes{i,1}=sum(m,2);    % Summarizes elements in every row


%Cross reference with gene list of current model, create a list of only the essential genes.
% Gene list of current model *times* the boolean vector where 1 = essential gene. All 0 elements (non-essential/non-lethal) genes removed
% Result = List of genes that are essential for cell vitality
LethalGenes57.lethal{i,1} = eGenes.geneList{i,1} (boolVec_essentialGenes{i,1});   
LethalGenes57.tissues{i,1} = eGenes.tissues{i,1} ;


% Lethal genes and their weights, meaning how many essential tasks the gene 
% knocks out if removed. 
vekt = weight_essentialGenes{i,1} (boolVec_essentialGenes{i,1}) ;   % List of all weights that are non-zero. Corresponding to the essential genes. 
vektAsCell = num2cell(vekt);        % vekt is a list of ca300x1 double. Must make it to ca300x1 cell, by num2cell function, to be compatible for the next steps.
LethalGenes57.lethalAndWeight{i,1} =  [LethalGenes57.lethal{i,1} vektAsCell]     % creates this format: [ e-genes list, corresponding weight ]

end


save('A_LethalGenes_57_results','LethalGenes57');



