% Fuzzy IntegralCombination
% Mohsen Ghofrani

clc
clear all
close all
load Dataset2;
L=4; % number of classifiers
x=Data(:,1:2);
T=Data(:,3);
T(T==0)=2;

% Computing Discriminant Function values for each class & each Classifier
gRBF=bRBF(x);
gMLP=bMLP(x);
gPNN=bPNN(x);
gLVQ=bLVQ(x);

% values of strength for single cardinality subsets of Ensemble
gi=[.6 .5 .4 .4];

% Calculating the value of 
lambda=lambda_fi(gi);

for i= 1: size (T)
    DP=[gRBF(i,:); gMLP(i,:); gPNN(i,:); gLVQ(i,:)];
    DP=[DP gi'];
    for k = 1 : 2        
        % Sorting in ascening ways
        DP=sortrows(DP,k) ;
        % fliping upside down to have descending sort based on kth column
        DP=flipud(DP);
        gt(1)=DP(1,3);
        for t= 2 : L
            gt(t)=DP(t,3)+gt(t-1)+lambda*DP(t,3)*gt(t-1);
            % sugeno Fuzzy integral method
        end
        mu(i,k)=max(min(DP(:,k),gt'));        
    end
end

for i = 1: size(T)
    label(i,:)=(mu(i,1)>mu(i,2))*1+(mu(i,1)<mu(i,2))*2;
end

sum(label==T)/length(T)