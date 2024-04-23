# NEURAL-NETWORK-BASED-FACE-OR-NON-FACE-CLASSIFICATION
# classifying the an image whether it has face or not face using a fully connected neural network. training using the back propagation algorithm. without using any inbuilt libraries and in MATLAB.
# When we flatten a 255x255 image we get 65,025 values. It is highly ineffecient to feed it to our neural network.
# Hence we use the Principle component analysis. This is well known method. But there is a very critical and important arises that is how do we know the dimensions of our reduced data? does our reduced data effectively represents the dominant values in the original data? is our new dimensions enough or do we need more to effectively represent it. Usually it is done by guessing which may or maynot be perfect. 
# Bur we can solve this problem by choosing the k value with explained variance. in my code I have chosen values which represent the 95 % of the values. That means we are getting rid of 5% of the data responsible for the variance (in signal processing we call this energy). 
# Now my reduced data is only 330 values. 
