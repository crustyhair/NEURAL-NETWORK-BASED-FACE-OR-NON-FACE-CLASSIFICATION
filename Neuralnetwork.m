
input_size = size(reducedData,2);
disp('inputsize: ')
disp(input_size)%
hidden_size = 10;                   % Arbitrary number of hidden neurons
output_size = 1;                    % Binary classification

% Initialize the network
net = initialize_network(input_size, hidden_size, output_size);


activations = forward_pass(reducedData, net);

% Display output from the network
disp('Network output:');


plot(activations.A3,'*')
xlim([0,850]);
ylim([0,1]);
grid on;
title('Neural Network output before training');


net = initialize_network(input_size, hidden_size, output_size);
function cost = quadraticCost(y_true, y_pred)
    % y_true: vector of true values
    % y_pred: vector of predicted values
    
    % Calculate squared differences
    differences = y_true - y_pred;
    squaredDifferences = differences .^ 2;
    
    % Compute the mean of these squared differences
    cost = 0.5 * mean(squaredDifferences);
end





function net = initialize_network(input_size, hidden_size, output_size)
    net.W1 = 0.01 * randn(input_size, hidden_size);  % Weights from input to first hidden layer
    net.b1 = zeros(1, hidden_size);                  % Biases for the first hidden layer
    net.W2 = 0.01 * randn(hidden_size, hidden_size); % Weights from first hidden layer to second hidden layer
    net.b2 = zeros(1, hidden_size);                  % Biases for the second hidden layer
    net.W3 = 0.01 * randn(hidden_size, output_size); % Weights from second hidden layer to output layer
    net.b3 = zeros(1, output_size);                  % Biases for the output layer
end

function activations = forward_pass(X, net)
    % Input to first hidden layer
    Z1 = X * net.W1 + repmat(net.b1, size(X, 1), 1);
    A1 = sigmoid(Z1);  % First hidden layer activations

    % First hidden layer to second hidden layer
    Z2 = A1 * net.W2 + repmat(net.b2, size(A1, 1), 1);
    A2 = sigmoid(Z2);  % Second hidden layer activations

    % Second hidden layer to output layer
    Z3 = A2 * net.W3 + repmat(net.b3, size(A2, 1), 1);
    A3 = sigmoid(Z3);  % Output layer activation (final output)

    % Store activations in a structure
    activations.A1 = A1;
    activations.A2 = A2;
    activations.A3 = A3;  % A3 is the final output of the network
end

function y = sigmoid(x)
    y = 1 ./ (1 + exp(-x));
end

