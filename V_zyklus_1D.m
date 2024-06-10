%Mehrgitter V-Zyklus
%N: Gitterpunkte
%b: rechte Seite
%u_0: Startwert
%L: Anzahl Level
%nu1: Anzahl Schritte Vorglättung
%nu2: Anzahl Schritte Nachglättung
function [u]=V_zyklus_1D(N,b,u_0,L,nu1,nu2)

%Daten für die versch. Gitter; Als cell, da alle unterschiedlich "lang"
NN=cell(1,L);
NN{1}=N;
for i=2:L
    NN{i}=(NN{i-1}-1)/2;
    if (mod(NN{i},2)==0)
        NN{i}
        i
        fprintf('NN darf auf keinem Level gerade sein! Dem Programm fehlen die Fallunterscheidungen!\n');
        return;
    end
end
%Rechte Seiten
bb=cell(1,L);
bb{1}=b;

%Dämpfungsparameter omega für Jacobi
w=0.6;

%Lösungen auf den Leveln
u_l=cell(1,L);
u_l{1}=u_0;

%Residuen
r=cell(1,L);

%Matrix für das gröbste Gitter (bei L, in der Vorlesung 0)
A_L=2*speye(NN{L},NN{L});
for i=1:NN{L}-1
   A_L(i,i+1)=-1;
   A_L(i+1,i)=-1;
end
hL=1/(NN{L}+1);
A_L=(1/(hL*hL)).*A_L;

for i=1:L-1
    %Vorglättung
    u_l{i}=jacobi_1D(u_l{i},NN{i},bb{i},w,nu1,0.0);
    
    %Residuum
    r{i}=bb{i}-poisson_mat_vek_1D(NN{i},u_l{i});
    
    %Restriktion
    r{i+1}=restr(r{i});
    
    %Setze Werte für nächsten Level
    bb{i+1}=r{i+1};
    u_l{i+1}=zeros(NN{i+1},1);
end

%Lösen auf gröbstem Gitter
u_l{L}=A_L\r{L};


for i=1:L-1
    %Prolongiere und korrigiere
    u_l{L-i}=u_l{L-i}+prol(u_l{L-i+1});
    %Nachglättung
    u_l{L-i}=jacobi_1D(u_l{L-i},NN{L-i},bb{L-i},w,nu2,0.0);
end

u=u_l{1};

    
    
    

