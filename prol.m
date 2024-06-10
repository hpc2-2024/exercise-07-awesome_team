%Prolongation in 1D

function y=prol(x)

N=size(x,1);
NN=2*N+1;

y=zeros(NN,1);

for i=1:N
    y(2*i)=x(i);
end

for i=1:N-1
    y(2*i+1)=0.5*(x(i)+x(i+1));
end
% Randwerte
y(1)=0.5*x(1);
y(NN)=0.5*x(N);