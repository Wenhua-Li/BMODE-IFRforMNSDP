function New_Population = EnviornmentalSelection(Population,Offspring,state)
% 本函数用来挑选新的种群

N = length(Population);
New_Population = Population;

%% 基本思路如下：为了确保种群的多样性，采用一对一替换机制。只有后代表现强于父代才会发生替换。
for i=1:N
    pcv = Population(i).con;
    ccv = Offspring(i).con;
    pf = Population(i).obj;
    cf = Offspring(i).obj;
    if (pcv == 0 && ccv == 0) % 采用 feasible rules 挑选新解
        if pf < cf
            New_Population(i) = Population(i);
        else
            New_Population(i) = Offspring(i);
        end
    else
        if pcv < ccv
            New_Population(i) = Population(i);
        else
            New_Population(i) = Offspring(i);
        end
    end
end

%% 此处采用精英保留策略，每一次迭代之后，挑选指定数量的最佳解替换最劣解，其中数量于概率根据迭代进度计算
% objs = [New_Population.obj];
% cons = [New_Population.con];
% [~,index] = sortrows([cons' objs']);
% n = ceil((1-state)*(N/100));
% if rand>state*state/2
%     New_Population(index(end-n+1:end)) = New_Population(index(1:n));
% end

