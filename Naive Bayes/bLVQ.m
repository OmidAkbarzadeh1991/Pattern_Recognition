function [L]=bLVQ(x)

[p n]=size(x); % p: number of samples, n: number of features,
m=2; % m: number of classes, (output nodes)
load LVQd
L=zeros(p,1);
for i=1:p
    for j=1:m
        EuDis(j)=norm(x(i,:)-w(:,j)');
    end
    L(i,1)=find(EuDis==max(EuDis)); % determine the winner node
    
end
end