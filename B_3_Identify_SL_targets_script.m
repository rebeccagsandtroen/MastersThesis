%% Find SL-targets unique to cancer tissues

% ur = unsorted results, meaning duplicates are still in this list. 

load('B_LethalPairs_results.mat');


NT_ur =  B_LethalPairs.unsortedResults{1,1};      % All gene pairs with SL effect. Duplicates included.
TM_ur =  B_LethalPairs.unsortedResults{2,1}; 
TP_ur =  B_LethalPairs.unsortedResults{3,1}; 

     
%% For the UNSORTED results (includes duplicates A+B and B+A)

A = cellstr(NT_ur(:,1:2));      % Convert cell array to character array. Excludes weight!
B = cellstr(TM_ur(:,1:2));
C = cellstr(TP_ur(:,1:2));

% Merge gene columns together. Makes every gene combo unique by name, like AB and BA.       
A1 = strcat(A(:,1),A(:,2)); 
B1 = strcat(B(:,1),B(:,2));
C1 = strcat(C(:,1),C(:,2));


boolVec1 = ismember(B1,A1);          % TM versus NT
boolVec2 = ismember(C1,A1);          % TP versus NT

TM_only_raw= TM_ur;
TM_only_raw((boolVec1),:)= [];

TP_only_raw= TP_ur;
TP_only_raw((boolVec2),:)= [];

CancerUniqueSLpairs = [];
CancerUniqueSLpairs.TP_only_raw = TP_only_raw ;
CancerUniqueSLpairs.TM_only_raw = TM_only_raw ;


% PS: Duplicates are still included!

%% Remove duplicates from tissue-specific SL-target list
% Algorithm adapted from: https://se.mathworks.com/matlabcentral/answers/296333-how-to-remove-repeating-pair 

A = TP_only_raw ;
b=arrayfun(@(x) sort(strjoin(A(x,1:2),'')),(1:size(A,1))','un',0) ;
[~,ii]=unique(b,'stable');
TP_only = A(ii,:);

A = TM_only_raw ;
b=arrayfun(@(x) sort(strjoin(A(x,1:2),'')),(1:size(A,1))','un',0) ;
[~,ii]=unique(b,'stable');
TM_only = A(ii,:);

% Save results
CancerUniqueSLpairs.TP_only = TP_only;
CancerUniqueSLpairs.TM_only = TM_only;

save('B_CancersOnly_SLpairs','CancerUniqueSLpairs');





