function [L]=bMLP(x)
x(:,1)=(x(:,1)-min(x(:,1)))/(max(x(:,1))-min(x(:,1)));
x(:,2)=(x(:,2)-min(x(:,2)))/(max(x(:,2))-min(x(:,2)));
x(:,3)=1; %ones for bias activation
hl=10; % number of nodes in the hidden layer
load MLPd
L=sign(sigmoid([sigmoid(x(:,1:3)*v) ones(length(x),1)]*w));
L(L==-1)=2;
end