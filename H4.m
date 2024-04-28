
clc
clf
format long 
P=0.08
x=[0.0233
0.0424415
0.073750
0.123353];

V=[0.0010017
    0.0010043
    0.0010078
    0.0010121];
T=[20
    30
    40
    50];
h=[83.862
125.66
167.45
209.26];

Ct=polyfit(x,T,3);
Cv=polyfit(x,V,3);
Ch=polyfit(x,h,3);


polyval(Ct,P)
polyval(Cv,P)
polyval(Ch,P)

spline(x,T,P)
spline(x,V,P)
spline(x,h,P)

