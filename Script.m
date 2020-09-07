clear all;
close all;
clc;
tic
% Input data from KTX and OTX
Data_ktx = uigetfile('*.ktx');
Data_otx=uigetfile('*.otx');
% Data_ktx='Basic.ktx';
% Data_otx='Adaptive90%.otx';
% function for read Data_ktx and domain
ktx=readktx(Data_ktx);
otx=readotx(Data_otx);

disp(ktx)