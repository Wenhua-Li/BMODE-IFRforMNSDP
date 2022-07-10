function Offspring = GA(Population)

N = length(Population);
Offspring = Population;
% for i=1:floor(N/2)
%     P1 = Population(2*i-1).decs;
%     P2 = Population(2*i).decs;
%     
%     [C1,C2] = Crossover(P1,P2);
%     if rand > 0.8
%         C1 = Mutation(C1);
%         C2 = Mutation(C2);
%     end
%     
%     Offspring(2*i-1).decs = C1;
%     Offspring(2*i).decs = C2;
% end
% index = randperm(N,N);
for i=1:N
    P1 = Population(i).decs;
    P2 = Population(randperm(N,1)).decs;
    
    [C1,C2] = Crossover(P1,P2);
    if rand > 0.8
        C1 = Mutation(C1);
%         C2 = Mutation(C2);
    end
    
    Offspring(i).decs = C1;
%     Offspring(index(2*i)).decs = C2;
end
% [a,b] = sort(index,'ascend');
% Offspring = Offspring(b);

Offspring = CalObj(Offspring);
