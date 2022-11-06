% Mohsen Ghofrani5
% RBFNN for dataset1
clc
clear all
close all
load Dataset2
tic
% Data=Data(randperm(length(Data)),:);
Data(:,4)=not(Data(:,3));
Data(:,3:4)=2*Data(:,3:4)-1;
s=Data(:,1:end-2);%samples
t=Data(:,end-1:end);% targets

err=0;
% matlabpool open local 2;
[rows cols]=size(s);
m=30; %number of nodes in midlayer;

r=[600*rand(m,1) 350*rand(m,1)];
c=[600*rand(m,1) 350*rand(m,1)];

for i = 1: rows
    for j=1:m
        H(i,j)=rbf(s(i,:),c(j,:),r(j));
    end
end
w=(inv(H'*H))*H'*t;

hold on
for i = 1: size (s)
    if t(i)==1
        scatter (s(i,1),s(i,2),'b','x')
    else
        scatter(s(i,1),s(i,2),'r')
    end
end
syms x1 x2
for j=1:m
    h(j)=rbf([x1 x2],c(j,:),r(j));
end
y1=h*w(:,1);
% y2=h*w(:,2);
ezplot(y1,[150 450 0 350])
% ezplot(y2,[150 450 0 350])
title('Training Data')

clear H
cm=zeros(2,2);
for i=1:length(s)
    for j=1:m
        H(i,j)=rbf(s(i,1:2),c(j,:),r(j));        
    end
end

% Confusion Matrix
out=sign(H*w);
cm(1,1)=sum(and(t(:,1)==1 , out(:,1)==1)); 
cm(1,2)=sum(and(t(:,1)==1 , out(:,1)==-1));
cm(2,1)=sum(and(t(:,1)==-1 , out(:,1)==1));
cm(2,2)=sum(and(t(:,1)==-1 , out(:,1)==-1));
accuracy=(length(s)-cm(1,2)-cm(2,1))/length(s)
cm
toc