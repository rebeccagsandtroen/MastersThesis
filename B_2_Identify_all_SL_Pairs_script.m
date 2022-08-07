%% Synthetic Lethal Gene Pairs
% Analysing raw data from B_DGD_results

 load('B_DGD_results.mat');

%Prepping to collect results
B_LethalPairs = [];
B_LethalPairs.results = [];
B_LethalPairs.unsortedResults = [];
B_LethalPairs.tissues = allResults.tissues;

for i=1:3      % Iterate through the three chosen models of BRCA.   
    
%% Step 1: Remove all non-lethal pairs

M = allResults.matrices{i,1};       % Logical format
G = allResults.genes{i,1};          % Cell format

rowsToKeep = any(M,2);               % Finds Any true on each row. Returns vertical list of true(/false) if at least one 1 is found. 
rowsToDelete = ~rowsToKeep;         % Switches 0<->1

% Remove all rows with only Zeros = rowsToDelete from both the geneCombos
% and megamatrix
G1 = G;         % G1 will be the final gene list with only lethal pairs
M1 = M;         % M1 is the task list result for the lethal gene pairs

G1((rowsToDelete),:)=[];
M1((rowsToDelete),:)=[];


%% Step 2: Add up the number of failed tasks for each gene pair. = Condense results

M2 = sum(M1==true,2);           % Summarizes number of tasks failed (=weight).
LP=horzcat(G1,num2cell(M2));     % Makes a matrix with gene pair and their weight. 

% Collect result
%B_LethalPairs.results{i,1} = LP;
%save('B_LethalPairsAll','B_LethalPairs');

%% Step 3: Remove duplicates 
% Adapted from internet: https://se.mathworks.com/matlabcentral/answers/296333-how-to-remove-repeating-pair 
A=LP;                    %B_LethalPairs.results{i,1} ; 
b=arrayfun(@(x) sort(strjoin(A(x,1:2),'')),(1:size(A,1))','un',0);
[~,ii]=unique(b,'stable');
out=A(ii,:);

B_LethalPairs.results{i,1} = out;       %Collect results
B_LethalPairs.unsortedResults{i,1} = LP;    % Keep unsorted results too!! 

end 

save('B_LethalPairs_results','B_LethalPairs');



