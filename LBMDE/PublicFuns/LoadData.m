% load(['datFile_50_' num2str(2) '.mat']);
% global MCS
% % % 
% % MCS.N = N;
% % MCS.K = K;
% % MCS.POS = POS;
% % MCS.DG = DG;
% % MCS.LOAD = LOAD;
% % MCS.DIST = roundn(pdist2(MCS.POS,MCS.POS),-3);
% % clear
% return

for i=1:5 %随机生成5个场景
    N = 80;
    K = randi([1,1],1,N); % 随机生成
    POS = 10.*rand(N,2);
    % DG = roundn(50+30.*(rand(1,N)),0);
    LOAD = roundn(20+30.*(rand(1,N)),0);
    K(randperm(N,round(N/2))) = 2;
    K(randperm(N,round(N/4))) = 3;
    DG=(1.2+i/10).*LOAD;
    
    MCS=[];
    MCS.N = N;
    MCS.K = K;
    MCS.POS = POS;
    MCS.DG = DG;
    MCS.LOAD = LOAD;
    MCS.DIST = roundn(pdist2(MCS.POS,MCS.POS),-3);
    str=['datFile_' num2str(N) '_' num2str(i) '.mat'];
    save(str,'MCS')
    
%     return
    %% write CPLEX data file
    file=['cp_' num2str(N) '_' num2str(i) '.dat'];
    fid = fopen(file,'wt+');
    fprintf(fid,'N=%d;\n',N);
    fprintf(fid,'nK1=%d;\n',sum(K==1));
    fprintf(fid,'nK2=%d;\n',sum(K==2));
    fprintf(fid,'nK3=%d;\n',sum(K==3));
    for j=1:3
        p=find(K==j);
        fprintf(fid,['K' num2str(j) '=[']);
        for k=1:numel(p)
            fprintf(fid,'%d \t',p(k));
        end
        fprintf(fid,'];\n');
    end
    fprintf(fid,'DG=[');
    fprintf(fid,'%d\t',DG);
    fprintf(fid,'];\n');
    
    fprintf(fid,'LOAD=[');
    fprintf(fid,'%d\t',LOAD);
    fprintf(fid,'];\n');
    
    fprintf(fid,'DIST=[');
    DIST = pdist2(MCS.POS,MCS.POS);
    for j=1:N
        fprintf(fid,'[');
        fprintf(fid,'%.3f\t',DIST(j,:));
        fprintf(fid,']\n');
    end
    fprintf(fid,'];');
    
    fclose(fid);
end