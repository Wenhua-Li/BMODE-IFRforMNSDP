function Offspring = Operator(Population,MCS)
% Differential evolution in FROFI

%------------------------------- Copyright --------------------------------
% Copyright (c) 2021 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
N=length(Population);
[~,B] = min([Population.obj]);
PB = Population(B).decs;
n = size(PB,1);

for i=1:N
    P1 = Population(i).decs;
    P2 = Population(randi([1,N],1)).decs;
    points = find(rand(1,n)<4/n);
    for j=1:numel(points)
        index1 = rand(1,n)<0.8;
        index2 = ~index1 & rand(1,n)<0.1;
        P1(points(j),index1) = P2(points(j),index1);
        P1(index1,points(j)) = P2(index1,points(j));
        P1(points(j),index2) = PB(points(j),index2);
        P1(index2,points(j)) = PB(index2,points(j));
    end
    P1 = Mutation(P1,MCS);
    
    Population(i).decs = P1;
end
Offspring = CalObj(Population,MCS);