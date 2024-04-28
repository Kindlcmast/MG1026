clc
clear
clf
format long
a=input('alfa ');
b=input('beta ');
y=0.003;
T1=250;
T2=input('T2 ');
m=0.0096;
Q=2.5;
Cp=@(T)a+(b*T)+(y*(T.^2));
dh=integral(Cp,T1,T2);

disp('svar')
a=(dh*m)/1000
b=(Q/a)

disp('swisha 30kr')

