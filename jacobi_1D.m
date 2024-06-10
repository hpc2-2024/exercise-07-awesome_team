%Berechnet x_k+1=x_k + w*D^(-1)*(b-Ax_k) mit N Gitterpunkten
%Kann Lösen bis tol oder max_it=nu (Glättungsschritte)
%Will man bis nu Schritte glätten, am besten mit tol<=0 aufrufen, dann wird
%break nie erreicht.
function [z]=jacobi_1D(x_0,N,b,w,nu,tol)

h=1/(N+1);
x_k=x_0;
for i=1:nu
    x_k=x_k+(w*(h^2)/2).*(b-poisson_mat_vek_1D(N,x_k));
    if (norm(b-poisson_mat_vek_1D(N,x_k))/norm(b)<tol)
        break;
    end
end
z=x_k;
end