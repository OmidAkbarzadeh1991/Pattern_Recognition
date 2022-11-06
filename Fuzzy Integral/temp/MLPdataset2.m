% simulating MLP for Dataset2 using batch learning method
% p294 fausett
clc
clear all
close all
tic
load dataset2
Data=Data(randperm(length(Data)),:);
Data(:,4)=not(Data(:,3));
Data(:,3:4)=1.4*Data(:,3:4)-.7 ;
Data(:,1)=(Data(:,1)-min(Data(:,1)))/(max(Data(:,1))-min(Data(:,1)));
Data(:,2)=(Data(:,2)-min(Data(:,2)))/(max(Data(:,2))-min(Data(:,2)));

s=Data(:,1:2); %samples
s(:,3)=1; %ones for bias activation
t=Data(:,3:4);% targets

n=10;
hl=10; % number of nodes in the hidden layer

% initial values for [w1 w2 ~w10 b] and [v1 v2 ~ v10 b]
% are chosen as a ranodm number between -.5 and .5
v=rand(3,hl)-.5;
w=rand(hl,2)-.5;
w=[w;[1 1]];
% load weights;
sc=1; % stopping condition
err=[];

while sc==1
    % feedforward
    zin=s*v;
    z=[sigmoid(zin),ones(length(t),1)];
    yin=z*w;
    y=sigmoid(yin);
    
    % Backpropagation of error
    if y==t
        sc=0;
    else
        d1=(t-y).*dsigmoid(yin);
        dw=n*z'*d1/length(t);  % averege of weight changes for the entire samples in an epoch
        din=d1*w(1:end-1,:)';
        d2=din.*dsigmoid(zin);
        dv=n*s'*d2/length(t);
        w=w+dw;
        v=v+dv;
    end
    err=[err;abs(t'-y')]; % each row of "err" represents absolute value of
    %     deviation of outputs from targets in a specific epoch
    if sum(err(end,:))<77, sc=0; end
    
    %     save ('weights' , 'v','w')
    %     if sum(err(end,:))<sum(err(end-1,:)
    n=.999*n;
    plot(sum(err'))
    drawnow
end

v
w

zin=s*v;
z=[sigmoid(zin),ones(length(t),1)];
yin=z*w;
y=sigmoid(yin);

c(1,1)=sum(sign(y(:,1)-y(:,2))==1 & t(:,1)==.7);
c(1,2)=sum(sign(y(:,1)-y(:,2))==1 & t(:,1)==-.7);
c(2,1)=sum(sign(y(:,1)-y(:,2))==-1 & t(:,1)==.7);
c(2,2)=sum(sign(y(:,1)-y(:,2))==-1 & t(:,1)==-.7);
disp('The Confusion Matrix is: ')
c

accuracy=(c(1,1)+c(2,2))/(c(1,1)+c(1,2)+c(2,1)+c(2,2))
% :D  there might be a very tiny possiblity of miscalcultaion in finding
% accuracy and confustion matrix , due to the sign function (when sign(.)
% gives zero)


xlabel('Epochs')
ylabel('Error (deviation from target)')

figure
hold on
for i = 1: size (s)
    if t(i)==.7
        scatter (s(i,1),s(i,2),'b','x')
    else
        scatter(s(i,1),s(i,2),'r')
    end
end
syms x y
ezplot(sigmoid([sigmoid([x , y ,1]*v) 1]*w(:,1)),[0 1])
title('Training Data')
toc