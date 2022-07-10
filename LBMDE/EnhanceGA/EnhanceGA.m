for gen = 1:MaxGen
%     MatingPool = TournamentSelection(2,PopSize,[Population.con],[Population.obj]); %挑选父代
    MatingPool = 1:PopSize;
%     MatingPool = randperm(PopSize,PopSize);
    Offspring = GA(Population(MatingPool)); %进行交叉变异操作
    Population = EnviornmentalSelection(Population,Offspring,gen/MaxGen); %挑选子代
    RecordInfo(); % 记录迭代优化信息
end