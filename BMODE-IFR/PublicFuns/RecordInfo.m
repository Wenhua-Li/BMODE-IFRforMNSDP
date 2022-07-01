obj = [Population.obj]; %获取种群的目标值
cons = [Population.con]; %获取种群违反约束的情况

%% 记录迭代过程信息
min_obj = min(obj); [min_cons]=min(cons); mean_obj = mean(obj); mean_cons = mean(cons);
ConvergenceF(1,gen) = min_obj; ConvergenceCV(1,gen) = min_cons;
ConvergenceF(2,gen) = mean_obj; ConvergenceCV(2,gen) = mean_cons;
[~,index] = sortrows([cons' obj']);
BestInd(gen) = Population(index(1));

%% 显示运行信息
if gen > 1 && mod(gen,10)==0
    disp(['迭代次数: ', num2str(gen), ', 最小违反约束: ', num2str(BestInd(gen).con), ...
        ', 最佳目标值: ', num2str(BestInd(gen).obj)]);
    if plt %|| gen==MaxGen
        yyaxis left
        plot(1:gen, ConvergenceCV(2,1:gen),'-b','linewidth',2)
        ylabel('违反约束程度')
        xlim([0,MaxGen])
        ylim([0, inf]);
        hold on
        yyaxis right
        ylabel('目标函数值')
        plot(1:gen, ConvergenceF(2,1:gen),'-r','linewidth',2);
        plot(1:gen, [BestInd(1:gen).obj],'-c','linewidth',2)
        xlabel('迭代次数')
        legend('平均违反约束','平均目标值','最佳解目标值','location','northoutside','Orientation','horizontal')
        drawnow;
        hold off
    end
end