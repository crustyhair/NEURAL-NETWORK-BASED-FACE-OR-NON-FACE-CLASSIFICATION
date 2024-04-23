
clc; clear all; close all;
inputDir = 'C:\Users\ashwi\OneDrive\Desktop\resized';  % Path to the directory containing the Caltech 101 images
outputDir = 'C:\Users\ashwi\OneDrive\Desktop\normalized';  % Path to the directory to save resized images

% Create the output directory if it doesn't exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end
% List categories
categories = dir(inputDir);
categories = categories([categories.isdir]); % filter only directories
categories = categories(~ismember({categories.name}, {'.', '..'})); % remove . and ..

% Process each category
for i = 1:length(categories)
    categoryName = categories(i).name;
    categoryPath = fullfile(inputDir, categoryName);
    outputCategoryPath = fullfile(outputDir, categoryName);
    
    % Create category directory in output if it doesn't exist
    if ~exist(outputCategoryPath, 'dir')
        mkdir(outputCategoryPath);
    end
    
    % List images in category
    images = dir(fullfile(categoryPath, '*.jpg')); % adjust if different file types
    for j = 1:length(images)
        imagePath = fullfile(categoryPath, images(j).name);
        outputImagePath = fullfile(outputCategoryPath, images(j).name);
        
        % Read, resize, and write image
        img = imread(imagePath);
        normalizedImg = double(img) / 255;
        imwrite(normalizedImg, outputImagePath);
        fprintf('Normalized and saved %s\n', images(j).name);
    end
end
