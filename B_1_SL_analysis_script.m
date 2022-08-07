%% Synthetic lethalities

parpool


%% preparing necessary files and settings


% Load the COBRA toolbox
initCobraToolbox                  %(false);
changeCobraSolver('gurobi','all');
setRavenSolver('gurobi');

%    Load my chosen models. 
% Must use RAVEN model format for the checkTasksGenes function. (COBRA version lacks model.metComps)
% Variable name is my_models
load('chosen_models.mat');  %RAVEN models

%    Load essential tasks list. 
% From Human 1 github collection. RAVEN function 'parseTaskList'. Saved the output as '57essentialTasks_cobra' of this function and will be
% loading this instead of running it every time. Variable name is  'essentialTasks'. 
% Husker ikke hvorfor jeg kalte den _cobra ??? Ser uansett lik ut..
    % essentialTasks = parseTaskList('metabolicTasks_Essential.xlsx');  
load('57essentialTasks_cobra');


%       Load known essential genes
% Result from running the function checkTasksGenes for the models.
% Gives the variable "LethalGenes57", including a tissue list and a list of
% lethal genes (same as essential genes. "Lethal if deleted". )
load('A_LethalGenes_57_results.mat'); 

allResults=[];          % For collecting the results at the end
temp_results =[];       % For collecting temporary results

%% Run Analysis


%Iterate through all tissue models ( OR the chosen 3 models)
for i = 1:3    %or 'length(my_models.models)' for all 15 models
  %i=1;
    model = my_models.models{i,1};
    eGenes = LethalGenes57.lethal{i,1};                         % List of essential genes in model number i. 
    non_eGenes = model.genes (~ismember(model.genes,eGenes));   % List of non-essential genes in model i. 
    [modelA] = removeGenesFromModel(model,eGenes);              % Remove all -known- essential genes from model
 

 geneColumns = cell(numel(non_eGenes),2);
 boolMatrixColumns = cell(numel(non_eGenes),1);
    

%% Run   Brute force version

    environment = getEnvironment();
    parfor j = 1:length(non_eGenes)     % Same length as modelA.genes
        restoreEnvironment(environment);
        [modelB]= deleteModelGenes(modelA, non_eGenes{j,1});    % Gene deletion, fluxes set to 0.
        [modelB] = removeGenesFromModel(modelB,[non_eGenes{j,1} '_deleted']);   %Removes gene_deleted from gene list.
        [~,essentialGenes] = checkTasksGenes(modelB,[],false,false,true,essentialTasks);    % Second gene deletion, checks ALL genes in model.
                    %essentialGenes=ones(2245,57);   For testing the script
     
        geneColumns(j,:) = {cellstr(repmat(non_eGenes{j,1},length(modelB.genes),1)), modelB.genes};
        boolMatrixColumns{j,1} = essentialGenes;
    end
    

  temp_results.geneCol{i,1}=geneColumns;
  temp_results.boolMatrixCol{i,1}=boolMatrixColumns;
save('Temporary_results','temp_results', '-v7.3');


% geneCombinations = cell(numel(non_eGenes) * numel(non_eGenes),2);     %
% Blir for mange rader, fordi hver rad må ha -1 pga ett gen slettes hver
% gang. 
geneCombinations = cell(numel(non_eGenes) * numel(non_eGenes)-numel(non_eGenes),2);   % Creating an empty list for all gene combinations. A+B, A+C, etc..
    %Minus antall gener vi tester fordi hver liste mangler 1 gen, nemlig
    %det som slettes manuelt
geneCombinations(:,1) = vertcat(geneColumns{:,1});      % List of manually deleted genes
geneCombinations(:,2) = vertcat(geneColumns{:,2});      % List of all genes, from 'essentialGenes' result
boolMatrix = vertcat(boolMatrixColumns{:});             % The essentialGenes result matrix

allResults.genes{i,1}= geneCombinations; 
allResults.matrices{i,1}= boolMatrix;
allResults.tissues{i,1} = my_models.id{i,1}; 

save('B_DGD_results', 'allResults', '-v7.3');


end






