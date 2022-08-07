%% Check that models can perform all 57 essential metabolic tasks 

initCobraToolbox(false);
changeCobraSolver('gurobi','all');
setRavenSolver('gurobi');
load('chosen_models.mat');  
load('57essentialTasks_cobra');


for i=1:length(my_models.models)
    checkTasks(my_models.models{i,1},[],true,false,false,essentialTasks);
end

   


