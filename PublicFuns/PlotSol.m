% close all
% figure
hold on

%% 连线
AdjMat = BestSol.decs;
for i=1:MCS.N
    for j=1:i
        if AdjMat(i,j)
           x = MCS.POS([i,j],1); y = MCS.POS([i,j],2);
           h4=line(x,y,'color','k','linestyle','-.','linewidth',1);
        end
    end
end

%% 背景画图
for i=1:MCS.N
   if MCS.K(i) == 1
       h1=scatter(MCS.POS(i,1),MCS.POS(i,2),60,'b','o','filled','MarkerEdgeColor','k');
   elseif MCS.K(i) == 2
       h2=scatter(MCS.POS(i,1),MCS.POS(i,2),60,'g','s','filled','MarkerEdgeColor','k');
   else
       h3=scatter(MCS.POS(i,1),MCS.POS(i,2),60,'r','^','filled','MarkerEdgeColor','k');
   end
   text(MCS.POS(i,1)+0.2,MCS.POS(i,2),num2str(i))
end

% legend([h1,h2,h3,h4],{'I类节点','II类节点','III类节点','预设线路'},'Location','northoutside','Orientation','horizontal')
% legend([h1,h2,h3,h4],{'Type-I','Type-II','Type-III','Pre-set circuit'},'Location','northoutside','Orientation','horizontal')

grid on
box on
xlim([0,10])
ylim([0,10])
xlabel('$\mathbf{X}$','interpreter','latex')
ylabel('$\mathbf{Y}$','interpreter','latex','rotation',0)
ax=gca;
ax.FontSize = 12;