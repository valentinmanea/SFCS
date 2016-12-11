
P=40; % perioada semnalului x
D=4; % durata semnalului x_tr(triunghiular)

w0=2*pi/P; % pulsatia semnalului x
t_tr=0:0.02:D; % vectorul de timp pentru partea de triunghi a semnalului
x_tr= sawtooth((pi/2)*t_tr,0.5)/2+0.5; % generarea partii de triunghi a semnalului
t = 0:0.02:P; % vectorul de timp pe o perioada
x = zeros(1,length(t)); % initializarea vectorului x
x(t<=D)=x_tr; % adaugarea partii triunghiulare a semnalului
figure(1);
plot(t,x); % afisarea semnalului x(t)
title('x(t)(linie solida) si reconstructia folosind N coeficienti (linie punctata)');
hold on;


for k=-50:50
    x_t = x_tr;
    x_t = x_t .* exp(-j*k*w0*t_tr); % vectorul ce trebuie integrat
    X(k+51)=0; % initializarea coeficientului Xk
    for i = 1: length(t_tr)-1
        X(k+51) = X(k+51) + (t_tr(i+1)-t_tr(i))* (x_t(i)+x_t(i+1))/2; % integrare folosind metoda dreptunghiurilor
    end
end
    


for i = 1: length(t)
    x_finit(i) = 0;% initializarea elementelor vectorului reconstruit
    for k=-50:50
        x_finit(i) = x_finit(i) + (1/P)*X(k+51)*exp(j*k*w0*t(i)); % calcularea sumei
    end
end
plot(t,x_finit,'--'); % afisarea semnalului reconstruit cu linie punctata pe acelasi grafic cu semnalul original

figure(2);
w=-50*w0:w0:50*w0; % generarea vectorului de pulsatii corespunzatoare coeficientilor Xk
stem(w/(2*pi),abs(X)); % afisarea spectrului


% Semnalul reconstrui cu cei 50 de coeficienti nu este identic cu cel original deoarece prin 
% selectarea unui numar finit de coeficienti se limiteaza spectrul semnalului. Semnalele periodice pot fi
% descrise prin suma a unei infinitati de componenete sinus si cosinus care sunt inmultite cu coeficienti 
% corespunzatori si de frecvente diferite (multipli ai frecventei semnalului). Forma de unda a semanlului 
% reconstrui va fi cu atat mai apropiata de cea originala cu cat adaugam mai multi coeficienti in suma,
% cu cat dorim ca forma semnalului sa fie mai abrupta (timpul de crestere si descrestere sa fie mai mic)
% cu atat suntem nevoiti sa luam in calcul mai multi coeficienti ai seriei fourier.
