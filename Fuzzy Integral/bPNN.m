function [g]=bPNN(x)

for i = 1: length(x)
    x(i,1:2)=x(i,1:2)/norm(x(i,1:2));
end

load PNNd
mA=length(classA);[mB n]=size(classB);
sigma=.55;
% g=zeros(length(x),2);
for i = 1 : length (x)
    fA=0;fB=0;
    for j = 1:mA
        zin=x(i,1:2)*classA(j,1:2)';
        fA=fA+exp((zin-1)/(sigma^2));
    end
    for j = 1:mB
        zin=x(i,1:2)*classB(j,1:2)';
        fB=fB+exp((zin-1)/(sigma^2));
    end
   g(i,:)=[fB fA]; 
end

for i = 1 : length(g)
    g(i,:)=exp(g(i,:))./sum(exp(g(i,:)));
end

end