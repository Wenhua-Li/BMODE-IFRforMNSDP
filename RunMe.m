clear; clc; close all
addpath(genpath(pwd));

nP = 20; % Number of nodes, options: 10, 20, 50, 80, 100
pID = 1; % Dataset ID, range: 1-5
timer = tic;
%% Problem parameter settings
load(['MNSDP-LIB\MNSDP_' num2str(nP) '_' num2str(pID) '.mat']);

%% Parameter settings
PopSize = min(10*MCS.N,500); % Population size
MaxGen = 50*MCS.N; % Maximum number of generations
plt = 1; % Whether to draw real-time optimization graphs during execution, default is off (can greatly improve running speed)

%% Initialization
Population = Init(PopSize,pID,MCS);
ConvergenceF = zeros(2,PopSize);
ConvergenceCV = zeros(2,PopSize);
Gb=inf;

%% Start optimization and solving
fprintf('Number of nodes: %3d, Dataset ID: %d\n', nP, pID)
BMODE();

%% Optimization completed
timer = toc(timer);
disp(['Time used: ' num2str(timer) ' seconds']);
BestSol = BestInd(end);

figure
PlotSol() % Plot solution
