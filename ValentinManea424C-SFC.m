P=40; % perioada semnalului x
D=10; % durata semnalului 

w0=2*pi/P; % se declara pulsatia semnalului
t1=0:0.02:D; 
x1= sawtooth((pi/2)*t1,0.5)/2+0.5; % se genereaza semnalul triunghiular
vect = 0:0.02:P; % se declara vectorul de timp 
x = zeros(1,length(vect)); % se initializarea vectorul x
x(vect<=D)=x1; 

for k=-50:50
    xt = x1;
    xt = xt .* exp(-j*k*w0*t1); 
    X(k+51)=0; % se initializeaza coeficientul Xk
    for i = 1: length(t1)-1
        X(k+51) = X(k+51) + (t1(i+1)-t1(i))* (xt(i)+xt(i+1))/2; % se integreaza 
    end
end 

for i = 1: length(vect)
    final(i) = 0;% se initializeaza vectorul in care se va reconstrui semnalul
    for k=-50:50
        final(i) = final(i) + (1/P)*X(k+51)*exp(j*k*w0*vect(i)); 
    end
end
    
figure (1);
plot(vect,x,vect,final,'--'); % se afiseaza semnalul initial si semnalul reconstruit pe acelasi grafic cu semnalul original

figure(2);
w=-50*w0:w0:50*w0; % generarea vectorului de pulsatii corespunzatoare coeficientilor Xk pentru a se putea realiza afisarea spectrului
stem(w/(2*pi),abs(X)); % se afiseaza spectrul


% Semnalul generat in final va deosebi de cel initial deoarece alegand un numar de coeficienti spectrul semnalului
% se micsoreaza. Ceea ce inseamna ca daca ne dorim ca forma semnalului reconstruit sa fie cat mai aproape de forma
% semnalului initial  trebuie sa marim numarul de coeficienti din suma.
