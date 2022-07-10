function Population = CalObj(Population)
% 本函数用于计算种群个体的目标函数值
Nn = length(Population);
global MCS
K = MCS.K;
N = MCS.N;
DG = MCS.DG;
LOAD = MCS.LOAD;
DIST = MCS.DIST;

for index=1:Nn
    x = Population(index).decs;
    
    %% 计算目标函数值
    f = sum(sum(x.*DIST));
    
    %% 计算约束违反情况
    allDG = sum(x.*DG,2)'; allLOAD=sum(x.*LOAD,2)';
    con = 0;
    detail = '';
    for i=1:N % 基本思路：对于每一个节点，遍历所有可能情况，看是否违反约束
        tmp = allDG(i)-allLOAD(i)-LOAD(i);
        
        if tmp < 0
            con = con+1;
            %                 detail = [detail num2str(i) ';'];
        end
        if K(i) == 2 % II类节点
            nPi = find(x(i,:)==1);
            for Pj=1:numel(nPi)
                j = nPi(Pj);
                if tmp + LOAD(j) - DG(j) < 0
                    con = con+1;
                    %                     detail = [detail num2str([i j]) ';'];
                end
            end
        elseif K(i) == 3 % III类节点
            for j=1:N-1
                for k=j+1:N
                    if x(i,k)||x(i,j)
                    if tmp+x(i,j)*LOAD(j)+x(i,k)*LOAD(k)-(x(i,j)*DG(j)+x(i,k)*DG(k)) < 0
                        con = con+1;
                        %                             detail = [detail num2str([i j k]) ';'];
                    end
                    end
                end
            end
        end
        
%         if K(i) >= 2 % II类节点
%             for j=1:N
%                 if x(i,j) && i~=j % 二类节点
%                     if allDG(i) - allLOAD(i) + x(i,j)*LOAD(j) - x(i,j)*DG(j) < LOAD(i)
%                         con = con+1;
%                         %                     detail = [detail num2str([i j]) ';'];
%                     end
%                     for k=j+1:N
%                         if x(i,k) && i~=k % 三类节点
%                             if allDG(i)-allLOAD(i)+x(i,j)*LOAD(j)+x(i,k)*LOAD(k) ...
%                                     -(x(i,j)*DG(j)+x(i,k)*DG(k)) < LOAD(i)
%                                 con = con+1;
%                                 %                             detail = [detail num2str([i j k]) ';'];
%                             end
%                         end
%                     end
%                     
%                 end
%             end
%         end
        
    end
    
    %% 封装数据
    Population(index).obj = f;
    Population(index).con = con;
    Population(index).detail = detail;
end