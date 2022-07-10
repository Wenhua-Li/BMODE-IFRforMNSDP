clear;clc;close all
clear global MCS
addpath(genpath(pwd));
global MCS

% parfor i=1:30
%     runexp(i);
% end
% 
% 
% function runexp(runID)
for nP=50%20%[10,20,50]%,80,100]
    for pID=4%:4
        timer = tic;
        %% 问题参数设置
        load(['data\datFile_' num2str(nP) '_' num2str(pID) '.mat']);
        
        %% 参数设置
        PopSize = 10*MCS.N;
        MaxGen=10;
        MaxGen = 50*MCS.N;
        plt = 0; % 运行过程是否实时画迭代优化图，默认关闭(可极大提高运行速度)
        
        %% 初始化
        Population = Init2(PopSize,pID);
        ConvergenceF = zeros(2,PopSize);
        ConvergenceCV = zeros(2,PopSize);
        
        %% 开始优化求解
        fprintf('节点个数：%3d，数据集编号：%d\n',nP,pID)
        % FROFI1();
        FROFI2();
        % EnhanceGA();
        
        %% 优化结束
        timer = toc(timer);
        disp(['用时:' num2str(timer) '秒']);
        BestSol = BestInd(end);
        
        save(['result\result_' num2str(nP) '_' num2str(pID) '.mat'],'BestSol','timer','ConvergenceF','ConvergenceCV')
%         save(['result\result_' num2str(nP) '_' num2str(pID) '_' num2str(runID) '.mat'],'BestSol','timer','ConvergenceF','ConvergenceCV','Population')
        % return
    end
end
plt=1;
RecordInfo
AnaResult
% end



% figure
% PlotSol()