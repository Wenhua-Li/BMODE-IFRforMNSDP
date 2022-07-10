function New_Population = EnviornmentalSelection(Population,Offspring,state)
% ������������ѡ�µ���Ⱥ

N = length(Population);
New_Population = Population;

%% ����˼·���£�Ϊ��ȷ����Ⱥ�Ķ����ԣ�����һ��һ�滻���ơ�ֻ�к������ǿ�ڸ����Żᷢ���滻��
for i=1:N
    pcv = Population(i).con;
    ccv = Offspring(i).con;
    pf = Population(i).obj;
    cf = Offspring(i).obj;
    if (pcv == 0 && ccv == 0) % ���� feasible rules ��ѡ�½�
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

%% �˴����þ�Ӣ�������ԣ�ÿһ�ε���֮����ѡָ����������ѽ��滻���ӽ⣬���������ڸ��ʸ��ݵ������ȼ���
% objs = [New_Population.obj];
% cons = [New_Population.con];
% [~,index] = sortrows([cons' objs']);
% n = ceil((1-state)*(N/100));
% if rand>state*state/2
%     New_Population(index(end-n+1:end)) = New_Population(index(1:n));
% end

