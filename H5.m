% H5 Pumpkraftverket
format longg
clear all, close all, clc

%% Data
gravity = 9.81; %[m/s2]
H = 100; %[m] z2-z1 (konstant)
L = 7000; %[m]
C = 80; %[bar]
d = 5; %[m]
f1 = 0.03; %friktionsfaktorn
densitet_vatten = 1000; %[kg/m3]
verkningsgrad_pump = 0.65; % Cven motorn
verkningsgrad_turbin = 0.8;
elpris_pumpdrift = 0.4; %kronor / kWh

A = pi*d^2/4; % [m2] tvC$rsnittsarean pC% rC6ret
%Pumpen anses C$ven vara isentropisk

%% Kontinuitetsekvationen, bevarande av massflC6de
%m_prick = konstant ==> m_prick_
% w_hastighet = V_prick/A;


%TryckC$ndringen C6ver pC% pumpen i bar, C C$r en konstant
% och V_prick C$r volymflC6det genom pumpen i m^3/s.
%EJ TURBINDRIFT
% delta_p_pump = (C - (0.3*V_prick) - (0.02*V_prick^2))*1e5;

% delta_p_friktion = (f1*densitet_vatten*w_hastighet^2*L/d)*1e5;

%Bernoullis ekvation kompletterad med en term fC6r att ta
%hC$nsyn till tillfC6rd energi

%% VolymflC6det  vid pumpdrift 
F = @(x) x^2*(0.02*1e5 + ((f1*densitet_vatten*L)/(d*A^2))) + 0.3*1e5*x + gravity*densitet_vatten*H -C*1e5;

x0 = 0; %Startgissning
fzero(F, x0); %[Detta C$r volymflC6det alltsC% V_prick]

V_prick = 51.0148715636835; %[m3/s]

w = V_prick/A;

delta_p_friktion = f1*densitet_vatten*w^2*L/d;



%% tryckC$ndring C6ver pump 
% genom dimanalys blir effekten tryckskillnaden C6ver pumpen mult. med
% volymflC6det + hC$nsyn till den elektriska verkningsgraden

delta_p_pump = (C - (0.3*V_prick) - (0.02*V_prick^2))*1e5;

pump_effekt = V_prick*delta_p_pump/verkningsgrad_pump;

%% BortfC6rt arbete vid turbindrift

e_is = gravity*H*densitet_vatten - delta_p_friktion;
turbin_effekt = V_prick*e_is*verkningsgrad_turbin;


%% VattenfC6rbrukning per vecka vid turbindrift

Vatten_forbrukning = V_prick*60*3600*1000; %[L/vecka]

%% Kostnad per vecka fC6r pumpen

kostnad_pump = pump_effekt*60*1e-9*elpris_pumpdrift; %[Mkr]

%% Elpriset fC6r turbinen

elpris_turbin = kostnad_pump*1e9/(turbin_effekt*60); %[kr/kWh]







