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
        tmp = allDG(i)-allLOAD(i)-LOAD(i);
        
        if tmp < 0
            con = con+1;
            %                 detail = [detail num2str(i) ';'];
        end
        if K(i) == 2 % II��ڵ�
            nPi = find(x(i,:)==1);
            for Pj=1:numel(nPi)
                j = nPi(Pj);
                if tmp + LOAD(j) - DG(j) < 0
                    con = con+1;
                    %                     detail = [detail num2str([i j]) ';'];
                end
            end
        elseif K(i) == 3 % III��ڵ�
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
        
%         if K(i) >= 2 % II��ڵ�
%             for j=1:N
%                 if x(i,j) && i~=j % ����ڵ�
%                     if allDG(i) - allLOAD(i) + x(i,j)*LOAD(j) - x(i,j)*DG(j) < LOAD(i)
%                         con = con+1;
%                         %                     detail = [detail num2str([i j]) ';'];
%                     end
%                     for k=j+1:N
%                         if x(i,k) && i~=k % ����ڵ�
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
    
    %% ��װ����
    Population(index).obj = f;
    Population(index).con = con;
    Population(index).detail = detail;
end