function Population = CalObj(Population)
% ���������ڼ�����Ⱥ�����Ŀ�꺯��ֵ
Nn = length(Population);
global MCS
K = MCS.K;
N = MCS.N;
DG = MCS.DG;
LOAD = MCS.LOAD;
DIST = MCS.DIST;

for index=1:Nn
    x = Population(index).decs;
    
    %% ����Ŀ�꺯��ֵ
    f = sum(sum(x.*DIST));
    
    %% ����Լ��Υ�����
    allDG = sum(x.*DG,2)'; allLOAD=sum(x.*LOAD,2)';
    con = 0;
    detail = '';
    for i=1:N % ����˼·������ÿһ���ڵ㣬�������п�����������Ƿ�Υ��Լ��
        nPi = find(x(i,:)==1); % i����ھӽڵ�
        if isempty(nPi)
            con = con+1;
            detail = [detail num2str(i) '����;'];
            continue;
        end
        if K(i) == 1 % I��ڵ�
            if allDG(i) - allLOAD(i) < LOAD(i)
                con = con+1;
                detail = [detail num2str(i) ';'];
            end
        elseif K(i) == 2 % II��ڵ�
            if allDG(i) - allLOAD(i) < LOAD(i) %����Ҫ����һ��ڵ�
                con = con+1;
                detail = [detail num2str(i) ';'];
            end
            
            for j=1:numel(nPi) %�ֱ���㵱�ھӽڵ���ֹ���ʱ�Ƿ��ܹ�����
                Pj = nPi(j);
                if allDG(i)+allDG(Pj)-DG(i)-DG(Pj) < allLOAD(i)+allLOAD(Pj)
                    con = con+1;
                    detail = [detail num2str([i Pj]) ';'];
                end
            end
            
        elseif K(i) == 3 % III��ڵ�
            for Pj = 1:N-1
                for Pk = Pj+1:N
                    if x(i,Pj)==0 && x(i,Pk)==0
                        if allDG(i) - allLOAD(i) < LOAD(i) %����Ҫ����һ��ڵ�
                            con = con+1;
                            detail = [detail num2str(i) ';'];
                        end
                    elseif x(i,Pj)==1 && x(i,Pk)==1
                        if allDG(i)+allDG(Pj)+allDG(Pk)-(2*DG(i)+(1+x(Pj,Pk)*(DG(Pj)+DG(Pk)))) <...
                                allLOAD(i)+allLOAD(Pj)+allLOAD(Pk)-(2*LOAD(i)+(1+x(Pj,Pk))*(LOAD(Pj)+LOAD(Pk)))
                            con = con+1;
                        end
                    elseif x(i,Pj)==1 && x(i,Pk)==0 && x(Pj,Pk)==0
                        if allDG(i)+allDG(Pj)-DG(i)-DG(Pj) < allLOAD(i)+allLOAD(Pj)
                            con = con+1;
                        end
                    elseif x(i,Pj)==1 && x(i,Pk)==0 && x(Pj,Pk)==1
                        if allDG(i)+allDG(Pj)+allDG(Pk)-DG(i)-2*DG(Pj)-DG(Pk) <...
                                allLOAD(i)+allLOAD(Pj)+allLOAD(Pk)-LOAD(Pj)
                            con = con+1;
                        end
                    end
                end
            end
            
            
%             if allDG(i) - allLOAD(i) < LOAD(i) %����Ҫ����һ��ڵ�
%                 con = con+1;
%                 detail = [detail num2str(i) ';'];
%             end
%             
%             if numel(nPi)==1 %��ǰ�ڵ�ֻ��һ���ھ�
%                 Pj = nPi;
%                 nPj = find(x(Pj,:)==1);
%                 if numel(nPj)==1 %i���ھӵ��ھ�ֻ��i
%                     con = con+1;
%                     detail = [detail num2str([i Pj]) ';'];
%                 else
%                     for k=1:numel(nPj)
%                         Pk = nPj(k);
%                         if Pk==i continue; end
%                         if allDG(Pj)+allDG(Pk)-sum(DG([i Pj Pk])) < sum(LOAD([i Pk]))+allLOAD(Pk)
%                             con = con+1;
%                             detail = [detail num2str([i Pj Pk]) ';'];
%                         end
%                     end
%                 end
%             else %��ǰ�ڵ��������ھ�
%                 for nj=1:numel(nPi)-1
%                     Pj = nPi(nj);
%                     for nk=nj+1:numel(nPi)
%                         Pk = nPi(nk);
%                         if allDG(i)+allDG(Pj)+allDG(Pk)-(2*DG(i)+(1+x(Pj,Pk)*(DG(Pj)+DG(Pk)))) < allLOAD(i)+allLOAD(Pj)+allLOAD(Pk)-LOAD(i)-x(Pj,Pk)*(LOAD(Pj)+LOAD(Pk))
%                             con = con+1;
%                             detail = [detail num2str([i Pj Pk]) ';'];
%                         end
%                     end
%                 end
%             end
        end
    end
    
    %% ��װ����
    Population(index).obj = f;
    Population(index).con = con;
    Population(index).detail = detail;
end