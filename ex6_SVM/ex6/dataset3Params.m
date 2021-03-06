function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and
%   sigma. You should complete this function to return the optimal C and
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example,
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using
%        mean(double(predictions ~= yval))
%

lambda_all = [0.01 0.03 0.1 0.3 1 3 10 30];
len_all = size(lambda_all,2);
error = zeros(len_all,len_all);

for  i = 1:len_all
  now_C = lambda_all(i);
  for j = 1:len_all
    now_sigma = lambda_all(j);
    model= svmTrain(X, y, now_C, @(x1, x2) gaussianKernel(x1, x2, now_sigma));
    p = svmPredict(model,Xval);
    error(i,j) = mean(double(p ~= yval));
  end
end

ans_min = min(min(error));
[C_index, sigma_index] = find(error == ans_min);

C = lambda_all(C_index);
sigma = lambda_all(sigma_index);







% =========================================================================

end
