%% Essential gene analysis based on Metabolic Tasks
% Performs a SGD analysis.

%% About the checkTasksGenes function.: 
% Performs a set of simulations as defined in a task file (57 essential tasks for viability). This function
%    is identical to "checkTasks", except it allows for the determination of
%    essential genes, rather than essential reactions.
% This function is used for defining a set of tasks for a model to
%    perform. The tasks are defined by defining constraints on the model,
%    and if the problem is feasible, then the task is considered successful.

% Determine essential genes for each task.      

%  !! Runtime 30 min PER model !!!


 
load('C:\Users\Rebecca\Documents\Data\5. klasse MTKJ\0. MASTEROPPGAVE\Koding\Master\Chosen_models\chosen_models.mat');

models = my_models.models(:);
essentialTasks = parseTaskList('C:\Users\Rebecca\Documents\Data\5. klasse MTKJ\0. MASTEROPPGAVE\Koding\Human-GEM-1.10.0\data\metabolicTasks/metabolicTasks_Essential.xlsx');
  
  % iterate through the different models
 parfor i = 1:length(models)
    
    m = models{i};
    
    % determine essential genes for each task
    [~,essentialGenes] = checkTasksGenes(m,[],false,false,true,essentialTasks); 
    
    % collect results
    tissues{i,1} = m.id;
    geneList{i,1} = m.genes;
    allEssentials{i,1} = essentialGenes;
    
    
end

% gather results into eGenes structure
eGenes = {};
eGenes.taskList = {essentialTasks(:).description}';
eGenes.tissues = tissues;
eGenes.geneList = geneList;
eGenes.essentialGenes = allEssentials;



% save the result
save('CheckTaskGenes_results', 'eGenes');


% Sound when the code has finished running.
load gong.mat;
sound(y,2*Fs);

