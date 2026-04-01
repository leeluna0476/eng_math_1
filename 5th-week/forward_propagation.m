x1 = [1; 2; 1; 3]
W1 = [.1 .2 .1 .2; .3 .4 .3 .4; .5 .6 .5 .6];

x2 = sigmoid(W1 * x1)
W2 = [.1 .3 .7; .2 .4 .2; .5 .5 .3; .7 .6 .1];

x3 = sigmoid(W2 * x2)
W3 = [.7 .5 .1 .3; .8 .6 .2 .4];

y = sigmoid(W3 * x3)

function y = sigmoid(z)
    y = 1 ./ (1 + exp(-z));
end