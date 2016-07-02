%ADITYA D. PAI
%SCRIPT FOR BUILDING DATABASE
function DB = makeDB(TrainingDB)

training = dir(TrainingDB);
count = 0;

for i = 1:size(training,1)
    if not(strcmp(training(i).name,'.')|strcmp(training(i).name,'..')|strcmp(training(i).name,'Thumbs.db'))
        count = count + 1; % Number of all images in the training database
    end
end

%Building 2D matrix from 1D image vectors
DB = [];
for i = 1 : count
    img = int2str(i);
    img = strcat('\',img,'.jpg');
    img = strcat(TrainingDB,img);
    
    image = imread(img);
    image = rgb2gray(image);
    
    [irow, icol] = size(image);
   
    x = reshape(image',irow*icol,1);   % Reshaping 2D images into 1D vectors
    DB = [DB x]; %Database progressively grows                   
end