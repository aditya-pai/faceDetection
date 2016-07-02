%ADITYA D. PAI
%MAIN SCRIPT FOR FACE RECOGNITION
clear all
clc
disp('CHOOSE TRAINING DIRECTORY FOLLOWED BY TESTING DIRECTORY');
TrainingDB = uigetdir('CHOOSE TRAINING DIRECTORY' );
TestingDB = uigetdir('CHOOSE TEST DIRECTORY');
clc
DB = makeDB(TrainingDB);
[x, y, ef] = efEngine(DB);
proj_vecs = [];
count = size(ef,2);
for i = 1 : count
    temp = ef'*y(:,i); % Projection of centered images into facespace
    proj_vecs = [proj_vecs temp]; 
end
disp('CHOOSE TEST SPECIMEN BY NAME');
specimen = {'Please enter specimen ID:'};
img  = inputdlg(specimen,'Face Recognition System',1,{'1'});
img = strcat(TestingDB,'\',char(img),'.jpg');
img1 = imread(img);
clc
% Transforming test image
input = imread(img);
temp = input(:,:,1);
[irow, icol] = size(temp);
input1 = reshape(temp',irow*icol,1);
diff = double(input1)-x; % Centered test image
proj_test = ef'*diff; % Test image feature vector

%calculate Euclidean Distance
Euc_dist = [];
for i = 1 : count
    q = proj_vecs(:,i);
    temp = ( norm( proj_test - q ) )^2;
    Euc_dist = [Euc_dist temp];
end

%find index of image from database with least distance to test specimen
[~ , rec_index] = min(Euc_dist);
matchedimage = strcat(int2str(rec_index),'.jpg');
image = strcat(TrainingDB,'\',matchedimage);
image = imread(image);

figure(1)
subplot(1,2,1)
imshow(img1)
title('Specimen');
subplot(1,2,2)
imshow(image);
title('Match from Database');

output = strcat('Matched Image from Database:  ',matchedimage);
disp(output)
