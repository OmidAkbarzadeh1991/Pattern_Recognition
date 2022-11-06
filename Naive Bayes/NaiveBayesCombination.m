% Naive Bayes Combination
clc
clear all
close all
load Dataset2
x=Data(:,1:2);
T=Data(:,3);
T(T==0)=2;

lSVM=bSVM(x);
lRBF=bRBF(x);
lMLP=bMLP(x);
lPNN=bPNN(x);
lLVQ=bLVQ(x);


% experts={'RBF','MLP','LVQ','PNN','SVM'};
Ensemble=[lRBF,lMLP];
[N L]=size (Ensemble);

for i = 1:L
    cm(1,1)=sum(and(Ensemble(:,i)==1 , T(:,1)==1));
    cm(1,2)=sum(and(Ensemble(:,i)==2 , T(:,1)==1));
    cm(2,1)=sum(and(Ensemble(:,i)==1 , T(:,1)==2));
    cm(2,2)=sum(and(Ensemble(:,i)==2 , T(:,1)==2));
    CM(i)={cm};
end

Label=zeros(N,1);
for i = 1 : N
    mu1=1;
    mu2=1;
    for j = 1 :L
        cm=cell2mat(CM(j));
        mu1=mu1*cm(1,Ensemble(i,j));
        mu2=mu2*cm(2,Ensemble(i,j));
    end
    if mu1>mu2 ;  Label(i)=1 ; else Label(i)=2; end
end

accuracy= sum(T==Label)/N
