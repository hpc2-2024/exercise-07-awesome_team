
%Berechnet z=A*r mit N Gitterpunkten; A ist diskrete Poissonmatrix in 1D
function [z]=poisson_mat_vek_1D(N,r)

z=zeros(N,1);

h=1/(N+1);
for i=2:N-1
    z(i)=(1/h)^2*(-r(i-1) + 2*r(i) - r(i+1));
end

%Rand
z(1)=(1/h)^2*(2*r(1)-r(2));
z(N)=(1/h)^2*(2*r(N)-r(N-1));