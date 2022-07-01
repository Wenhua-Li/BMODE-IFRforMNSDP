function Population = Init(PopSize,pID)
% 本函数用于构造初始解
global MCS b
pop.decs=[];
pop.obj=[];
pop.con=[];
pop.detail=[];
Population = repmat(pop,1,PopSize);

[a,b] = sort(MCS.DIST,2);
nP=9;
switch MCS.N
    case 20
        nP=11;
    case 50
        nP=12;
    case 80
        nP=14;
    case 100
        nP=16;
end

for i=1:PopSize
%     decs = round(0.6.*rand(MCS.N,MCS.N));
    decs = zeros(MCS.N);
    for j=1:MCS.N
%         index = b(j,randperm(max(5,round(MCS.N/4)),4)+1);
        index = b(j,randperm(nP,9-pID)+1);
        decs(j,index) = 1;
    end
    
    for j=1:MCS.N
        for k=1:j
            if j==k
                decs(j,k) = 0;
            end
           decs(j,k) = decs(k,j);
        end
    end
    Population(i).decs = decs;
end

Population = CalObj(Population);
