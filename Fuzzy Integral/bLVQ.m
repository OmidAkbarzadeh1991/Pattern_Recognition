function [g]=bLVQ(x)
[p n]=size(x); % p: number of samples, n: number of features,
m=2; % m: number of classes, (output nodes)
load LVQd
g=zeros(p,m);
for i=1:p
    for j=1:m
        EuDis(j)=norm(x(i,:)-w(:,j)');
    end
    g(i,:)=EuDis; % determine the winner node
    g(i,:)=exp(g(i,:))./sum(exp(g(i,:)));
end
% g=[g(:,2) g(:,1)];
end

