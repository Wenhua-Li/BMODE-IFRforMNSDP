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
        %% �����������
        load(['data\datFile_' num2str(nP) '_' num2str(pID) '.mat']);
        
        %% ��������
        PopSize = 10*MCS.N;
        MaxGen=10;
        MaxGen = 50*MCS.N;
        plt = 0; % ���й����Ƿ�ʵʱ�������Ż�ͼ��Ĭ�Ϲر�(�ɼ�����������ٶ�)
        
        %% ��ʼ��
        Population = Init2(PopSize,pID);
        ConvergenceF = zeros(2,PopSize);
        ConvergenceCV = zeros(2,PopSize);
        
        %% ��ʼ�Ż����
        fprintf('�ڵ������%3d�����ݼ���ţ�%d\n',nP,pID)
        % FROFI1();
        FROFI2();
        % EnhanceGA();
        
        %% �Ż�����
        timer = toc(timer);
        disp(['��ʱ:' num2str(timer) '��']);
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