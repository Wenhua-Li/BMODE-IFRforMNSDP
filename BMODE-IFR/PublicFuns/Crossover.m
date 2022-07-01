function [C1, C2] = Crossover(P1, P2)
% ������������Ⱥ�Ľ��棬�ܹ�������ֽ������
n = length(P1);
C1 = P1; C2 = P2;
if rand > 0.8
    pos = randperm(n,5); %����ÿ�ν���ֻ��ѡһ��λ��
    for i=1:numel(pos)
        C1(pos(i),:) = P2(pos(i),:);
        C1(:,pos(i)) = P2(pos(i),:)';
        
        C2(pos(i),:) = P1(pos(i),:);
        C2(:,pos(i)) = P1(pos(i),:)';
    end
else
    for i=1:randi([n,2*n],1)
        pos = randperm(n,2);
%         pos=randi([1,n],1,2);
        C1(pos(1),pos(2)) = P2(pos(1),pos(2));
        C1(pos(2),pos(1)) = P2(pos(1),pos(2));
        C2(pos(1),pos(2)) = P1(pos(1),pos(2));
        C2(pos(2),pos(1)) = P1(pos(1),pos(2));
    end
end

end
