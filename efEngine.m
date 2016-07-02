%ADITYA D. PAI
%SCRIPT FOR GENERATING EIGENFACE
function [x, y, ef] = efEngine(DB)

x = mean(DB,2); % Computing the average face image m = (1/P)*sum(Tj's)    (j = 1 : P)
count = size(DB,2);

% Calculating the variance
y = [];  
for i = 1 : count
    temp = double(DB(:,i)) - x; % Computing the difference image for each image in the training set Ai = Ti - m
    y = [y temp]; % Merging all centered images
end



C = y'*y; % C is the surrogate of covariance matrix C=y*y'.
[e_vecs e_vals] = eig(C); % Diagonal elements are the eigenvalues for both L=A'*A and C=A*A'.

% Sort and eliminate eigenvalues based on threshold

C_ev = [];
for i = 1 : size(e_vecs,2) 
    if( e_vals(i,i)>1 )
        C_ev = [C_ev e_vecs(:,i)];
    end
end

% Determine the eigenvectors of covariance matrix 'C'

ef = y * C_ev; % A: centered image vectors