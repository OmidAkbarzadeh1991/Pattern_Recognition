function [ f ] = dsigmoid( x )
f=.5*(1+sigmoid(x)).*(1-sigmoid(x));
end

