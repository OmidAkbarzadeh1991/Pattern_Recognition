function [L]=bRBF(x)
[p n]=size(x);
m=30; %number of nodes in midlayer;
load RBFd
for i = 1: p
    for j=1:m
        H(i,j)=rbf(x(i,:),c(j,:),r(j));
    end
end
L=sign(H*w);
L(:,2)=[];
L(L==-1)=2;
end