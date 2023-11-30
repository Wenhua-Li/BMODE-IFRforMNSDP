obj = [Population.obj]; % Get the objective values of the population
cons = [Population.con]; % Get the constraint violation of the population

%% Record iteration process information
min_obj = min(obj); [min_cons] = min(cons); mean_obj = mean(obj); mean_cons = mean(cons);
if min_obj < Gb
   Gb = min_obj; 
end
ConvergenceF(1,gen) = Gb; ConvergenceCV(1,gen) = min_cons;
ConvergenceF(2,gen) = mean_obj; ConvergenceCV(2,gen) = mean_cons;
[~, index] = sortrows([cons' obj']);
BestInd(gen) = Population(index(1));

%% Display running information
if gen > 1 && mod(gen,100) == 0
    disp(['Iteration number: ', num2str(gen), ', Minimum constraint violation: ', num2str(BestInd(gen).con), ...
        ', Best objective value: ', num2str(BestInd(gen).obj)]);
    if plt || gen == MaxGen
        yyaxis left
        plot(1:gen, ConvergenceCV(2,1:gen), '-b', 'linewidth', 2)
        ylabel('Degree of constraint violation')
        xlim([0, MaxGen])
        ylim([0, inf]);
        hold on
        yyaxis right
        ylabel('Objective function value')
        plot(1:gen, ConvergenceF(2,1:gen), '-r', 'linewidth', 2);
        plot(1:gen, [BestInd(1:gen).obj], '-c', 'linewidth', 2)
        xlabel('Iteration number')
        legend('Average constraint violation','Average objective value','Best solution objective value', ...
            'location', 'north', 'Orientation', 'vertical')
        drawnow;
        hold off
        grid on
    end
end
