% Feasibility rule with the incorporation of objective function information
for gen = 1:MaxGen
%     MatingPool = TournamentSelection(2,PopSize,[Population.con],[Population.obj]);
%     MatingPool = randperm(PopSize,PopSize);
%     MatingPool = 1:PopSize;
    Offspring  = Operator(Population,MCS);
    Population = EnvironmentalSelection(Population,Offspring);
    RecordInfo();
end
BestSol = BestInd(end);