
%Restriktion in 1D
function y=restr(x)

N=size(x,1);
NN=(N-1)/2;

y=zeros(NN,1);

for i=1:NN
    y(i)=0.25*(x(2*i-1) + 2*x(2*i) + x(2*i+1));
end