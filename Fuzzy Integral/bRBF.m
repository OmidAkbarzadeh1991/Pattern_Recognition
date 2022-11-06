function [g]=bRBF(x)
[p n]=size(x);
m=30; %number of nodes in midlayer;
load RBFd
for i = 1: p
    for j=1:m
        H(i,j)=rbf(x(i,:),c(j,:),r(j));
    end
end
g=H*w;
for i = 1 : length(g)
    g(i,:)=exp(g(i,:))./sum(exp(g(i,:)));
end

end