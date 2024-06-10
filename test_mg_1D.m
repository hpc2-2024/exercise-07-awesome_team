
%N Gitterpunkte in die eine Raumrichtung
function test_mg_1D(N,L)

h=1/(1+N);
%rechte Seite; der Einfachheit halber mit 1'en gefuellt
b=ones(N,1);

%direkter Löser nur bis gewisser Größe
if (N<200000)
%Zum Vergleich erstmal das System direkt gelöst; geht in 1D auch eigentlich
%am schnellsten, müsste man nicht extra die Matrix bauen.
A=2*speye(N,N);
for i=1:N-1
    A(i,i+1)=-1;
    A(i+1,i)=-1;
end
A=1/(h^2).*A;


%Direktes Lösen; x dient uns jetzt als Referenzlösung.
x=A\b;
end

%Mehrgitter Algorithmus
%----------------------

%zufälliger Startwert u
u=rand(N,1);
u0=u;
tiledlayout(2,1)
ax1=nexttile;
plot(ax1,h:h:1-h,u0)

%Anzahl Level/Gitter L; Die Software funktioniert nur, wenn N auf allen
%Leveln ungerade ist. Das Input N muss also zu L passen. Konstruktion: man
%überlegt sich ein ungerades N für das gröbste Level und rechnet dann L-mal N=2N+1.
k_mg=0; % Iterationszähler der MG Iterationen
e_mg=[];
%500 ist unser Maxiter. In 1D werden wir nie so viele Iterationen brauchen.
tic;
for i=1:500
    k_mg=k_mg+1;
    u0=u;
    %Aufruf V-zyklus
    u=V_zyklus_1D(N,b,u,L,5,5);

    %Relativer Fehler zur direkten Lösung (falls vorhanden). Sonst
    %Update...
    if (N<200000)
        e_mg(i)=norm(x-u)/norm(x);
    else
        e_mg(i)=norm(u-u0)/norm(b);
    end
    
    
    %Abbruchtoleranz 1e-8
    if (e_mg(i)<1e-8)
        break;
    end
end
tmg=toc;
ax2= nexttile;
plot(ax2,[h:h:1-h],u);

fprintf('Mehrgitter konvergiert in %i Schritten und %.2fs Sekunden für %i Unbekannte \n',k_mg,tmg,N);




    