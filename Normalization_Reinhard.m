clear all;

%% Display the results or not
verbose = 0;

%% Load preselected target image
% Specify the main directory
main_dir = './';
% Load Target image
TargetImage = imread(fullfile(main_dir, 'target/t0.tif'));

%% Load source histology images
%Get the filenames of all files under the specified folder
directory = uigetdir('','Select input subfolder (e.g. ./Training_data/Benign):');
dirs=dir(directory);%dirs structure type, including not only the file name, but also other information about the file.
dircell=struct2cell(dirs)'; %Type conversion, converted to cell type
filenames=dircell(:,1) ;%Filename is stored in the first column
%Then filter out the specified type file according to the suffix name and load

%% Reinhard stain normalization (RSN)
[n m] = size(filenames);% the number of images
out_directory = uigetdir('','Select the output subfolder (e.g. ./normalized/Training_data/Benign):');
for i = 1:n
     if ~isempty( strfind(filenames{i}, '.tif') )%Filter out tif files
         filename = filenames{i};
         filepath = fullfile(directory,filename);
         SourceImage = imread(filepath);%Read the source histology image         
         % Stain Normalisation using Reinhard's Method
         disp(['Stain Normalisation using Reinhard''s Method for SourceImage: ',filename]);         
        % Conduct Reinhard stain normalization (RSN)
         [ NormRH ] = Norm( SourceImage, TargetImage, 'Reinhard', verbose );
        % Save the normalized histology image
         [~,filename_only,~] = fileparts(filename);
         imwrite(NormRH,[out_directory,'/',filename_only,'.png'])    
     end
end

disp('The assignment is completed!')


