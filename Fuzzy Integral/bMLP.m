function [g]=bMLP(x)
x(:,1)=(x(:,1)-min(x(:,1)))/(max(x(:,1))-min(x(:,1)));
x(:,2)=(x(:,2)-min(x(:,2)))/(max(x(:,2))-min(x(:,2)));
x(:,3)=1; %ones for bias activation
hl=10; % number of nodes in the hidden layer
load MLPd
g=(sigmoid([sigmoid(x(:,1:3)*v) ones(length(x),1)]*w));
for i = 1 : length(g)
    g(i,:)=exp(g(i,:))./sum(exp(g(i,:)));
end
end