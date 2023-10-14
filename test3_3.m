clear;
lk=0;error=0;
Result_Mean=0;
for lk=1:1000
P = 100;W = 3;J = 8;errort=0;
s = ceil(randi([1 100],[1,P])); %real score
s_real = [1:100;s]; %real score
s = s_real';Result=rand(1000,1);
SIGMA = 1;
r = ceil(randi([1 10],[P,1])); %real rank
p = 0.2;  %reject percent
m = (log(2)+log(W/P))/log(1-p);  %times
h = 0.6 + (0.9-0.6).*rand([J 1]);
iter = 1;
for i=1:m
    v=zeros(J,1);
    indices = crossvalind('Kfold',P,J);
    score_j = [];
    for j=1:J
        temp = 1;
        for i=1:P
            if indices(i)==j
                score_j(temp,2*j)=normrnd(s(i,2),SIGMA);
                score_j(temp,2*j-1)=s(i,1);
                temp = temp+1;
            end
        end
    end
    for j=1:J
        score_j(:,2*j-1:2*j)=sortrows(score_j(:,2*j-1:2*j),2);
    end
    u=score_j(max([floor(p*P/J),1]),2:2:end);
    score_j(1:ceil(p*P/J),:)=[];
    P = size(score_j,1)* size(score_j,2)/2;
    s = reshape(score_j',2,P);s=s';
    v=max(score_j(end,2:2:end))-u;
    x=v/sum(v);
    C_1=sum(x.*v);
    C=max(score_j(end,:))-C_1;
    s(find(s(:,2)<C),:)=[];
    s=sortrows(s,2);
    P = length(s);
    iter = iter+1;
    if length(s)<=J
        break;
    end
end
Result(Result<=0.042)=16;Result(Result<=0.38)=17;
Result(Result<=0.8)=18;Result(Result<=0.98)=19;
Result(Result<=0.998)=20;Result(Result<=1)=21;
s = sortrows(s,2);
disp(['the index of the best paper is']);
for i =1:W
    disp(num2str(s(end-W+i,1)));
end

s_real_2 = sortrows(s_real',2);
disp(['the index of the best paper is']);
for i =1:2*W
    disp(num2str(s_real_2(end-2*W+i,1)));
end
Result_Mean=Result_Mean+Result(lk)/1000;
Result_Max=max(max(Result));Result_Min=min(min(Result));
lk=lk+1;
[max_a,indexa]=max(s_real,[],2);s_real(2,indexa(2))=0;
[max_b,indexb]=max(s_real,[],2);s_real(2,indexb(2))=0;
[max_c,indexc]=max(s_real,[],2);s_real(2,indexc(2))=0;
A=[indexa(2);indexb(2);indexc(2)];B=[s(end-2,1);s(end-1,1);s(end,1)];
for ii=1:W
[max_A,indexA]=max(A);[max_B,indexB]=max(B);
if (max_A-max_B)==0
A(indexA)=0;B(indexB)=0;errort=errort+1;
end
end
if errort~=3 
   error=error+1;
end
end


