%% Single gene deletion analysis, with Biomass production as ObFunc.



% Load neccecary stuff
load('chosen_models.mat');
models = my_models.models;

       
%% Set constraints for Hams medium

bModels=[];     %bound Models list

for i = 1:15
    model = models{i,1};
    exchModel = setHamsMedium(model);       % setHamsMedium.m was made by Robinson et.al, "An Atlas of human metabolism", Science (2020).
        bModels{i,1} = exchModel;
end

%% Verify that the objective function is biomass_human

% By default, the model objective is set to 'biomass_human'. Verifying that the objective is set to the biomass production:
%'biomass_human':

for i=1:length(bModels)
objectiveAbbr = checkObjective(bModels{i,1});  
    if objectiveAbbr{1,1} == 'biomass_human'
        continue; 
    else
        disp('ERROR: Objective is not biomass_human. Please fix this before continuing.')
        return 
    end
end




%% Wrap to COBRA format for single gene deletion
bModelsC=[];        % bound Models Cobra-format
for j = 1 : length(bModels)
    newModel = ravenCobraWrapper(bModels{j,1});
    bModelsC{j,1} = newModel ;
end



%% Execute singleGeneDeletion

for i = 1 : length(bModelsC)
    
    m = bModelsC{i,1};
    
     [grRatio, grRateKO, grRateWT] = singleGeneDeletion(m,'FBA'); 
    
      
    % collect results
    tissues{i,1} = m.modelID;
    geneList{i,1} = m.genes;
    
    all_grRatio {i,1} = grRatio;
    all_grRateKO {i,1} = grRateKO;
    all_grRateWT {i,1} = grRateWT;
    
    
    
end

% gather results into all_SGD_results structure
    all_SGD_results = {};
    all_SGD_results.tissues = tissues;
    all_SGD_results.geneList = geneList;
    all_SGD_results.grRatio = all_grRatio ;
    all_SGD_results.grRateKO = all_grRateKO;
    all_SGD_results.grRateWT = all_grRateWT;
    
%% Find essential genes. 
% Defined as KOs that has a relative growth rate of less than 50% of the
% wild type

limit = 0.5; 

% Making a struct to collect results, called LethalGenes_sgd. 
LethalGenes_sgd = {};
LethalGenes_sgd.lethal = {} ; 
LethalGenes_sgd.tissues = {} ;
for i = 1: 15   
    LethalGenes_sgd.lethal{i,1} = all_SGD_results.geneList{i,1} (find(all_SGD_results.grRatio{i,1} < limit));
	% LethalGenes_sgd.tissues{i,1} = all_SGD_results.tissues{i} ;
end

all_SGD_results.essentialGenes = LethalGenes_sgd.lethal; 

   
% Save the result
save('A_SGD_bound_results', 'all_SGD_results');

% Play a sound when script is finished
load gong.mat;
sound(y,2*Fs);







