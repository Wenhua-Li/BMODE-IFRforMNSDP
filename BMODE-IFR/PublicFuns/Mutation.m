function X = Mutation(X)
% ���������ڸ���ı���
n = length(X);
global MCS b
% [a,b] = sort(MCS.DIST,2);
PM = 2/(n*n-2*n); %�������

for i=1:n-1
    for j=i+1:n
        if rand<PM && b(i,j)<20
            X(i,j) = ~X(i,j);
            X(j,i) = X(i,j);
        end
    end
end

end
