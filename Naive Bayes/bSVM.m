function [L]=bSVM(x)
[p n]=size(x); % p: number of samples, n: number of features,
load SVMd
L=svmclassify(svmStruct,x);
L(L==0)=2;
end