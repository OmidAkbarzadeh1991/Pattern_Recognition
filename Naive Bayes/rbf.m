function [ rbf ] = rbf( x,c,r )
% rbf=exp(-(norm(x-c))^2/2*r^2);
rbf=exp(-sum((x-c).^2)./(2*r.^2));
end