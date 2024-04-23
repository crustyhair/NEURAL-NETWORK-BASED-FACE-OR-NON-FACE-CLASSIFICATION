clc; clear; close all;

inputDir = 'C:\Users\ashwi\OneDrive\Desktop\resized';
categories = dir(inputDir);
categories = categories([categories.isdir]); % filter only directories
categories = categories(~ismember({categories.name}, {'.', '..'})); % remove . and ..

% Initialize the image matrix
imageMatrix = [];

% Process each category
for i = 1:length(categories)
    categoryName = categories(i).name;
    categoryPath = fullfile(inputDir, categoryName);
    images = dir(fullfile(categoryPath, '*.jpg'));

    for j = 1:length(images)
        imagePath = fullfile(categoryPath, images(j).name);
        img = imread(imagePath);
        imgVector = img(:);  % Flatten the image into a vector
        imageMatrix = [imageMatrix; imgVector'];  % Append each image vector to the matrix
    end
end
imageMatrix = double(imageMatrix);
meanImage = mean(imageMatrix, 1);  % Compute the mean of each column
centeredImageMatrix = imageMatrix - meanImage;

[U, S, V] = svd(centeredImageMatrix, 'econ');  % Perform SVD
singularValues = diag(S);  % Extract singular values
explainedVariances = cumsum(singularValues.^2) / sum(singularValues.^2);  % Calculate explained variance
k = find(explainedVariances >= 0.95, 1);  % Find the number of components to retain 95% of the variance
reducedData = centeredImageMatrix * V(:, 1:k);  % Project data onto the first 'k' principal components

save('PCA_ReducedData.mat', 'reducedData');  % Save the reduced data