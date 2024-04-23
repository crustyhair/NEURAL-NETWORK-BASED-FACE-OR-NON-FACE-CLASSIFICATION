

% Assuming neural network structure and PCA data are loaded
load('C:\Users\ashwi\Downloads\Neuralnetwork.m', 'net');  % Contains net.W1, net.b1, net.W2, net.b2
load('PCA_ReducedData.mat', 'V', 'meanImage');  % PCA components and mean image

% Define forward_pass and sigmoid if not already defined
inputDir = 'C:\Users\ashwi\OneDrive\Desktop\101_ObjectCategories';  % Adjust directory as necessary
imagePath = fullfile(inputDir, 'specific_category', 'specific_image.jpg');  % Adjust path as necessary

% Preprocess and classify one image
reducedImg = preprocessImage(imagePath, meanImage, V);
activations = forward_pass(reducedImg, net);
predictedLabel = activations.A2 > 0.5;

% Display the image and classification result
figure;
imshow(imread(imagePath));
title(['Predicted: ', num2str(predictedLabel)]);

% Supporting functions
function reducedImg = preprocessImage(imagePath, meanImage, V)
    img = imread(imagePath);
    img = imresize(img, [255 255]);
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    img = double(img(:)') / 255;
    imgCentered = img - meanImage;
    reducedImg = imgCentered * V;
end

function activations = forward_pass(X, net)
    Z1 = X * net.W1 + net.b1;
    A1 = sigmoid(Z1);
    Z2 = A1 * net.W2 + net.b2;
    A2 = sigmoid(Z2);
    activations.A2 = A2;
end

function y = sigmoid(x)
    y = 1 ./ (1 + exp(-x));
end
