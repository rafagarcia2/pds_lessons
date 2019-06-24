// TRABALHO UNIDADE 2

// frequencia utilizadas
f1 = 1;
f2 = 112;

Fs = 2500; // Frequencia de amostragem

//especificamos w1, w2
w1 = 2*%pi*f1 / Fs;
w2 = 2*%pi*f2 / Fs;

M1 = 110;
n = 0:M1;

// Defini a passagem delta_w = 0.03 * 5pi

// Usarei a janela de Hamming

wp1 = w1 + 0.01*%pi;
ws1 = w1 + 0.04*%pi;

wc1 = (wp1 + ws1)/2;

wp2 = w2 +0.01*%pi;
ws2 = w2 + 0.04*%pi;

wc2 = (wp2 + ws2)/2;

//Usaremos agora um laço para simular o comportamento em tempo real do sistema:
for k=1:7500
//nosso filtro é representado por uma equação diferença, assim, devemos escolher
//polos e zeros tal que o comportamento do filtro seja como desejamos
//para um filtro ressonador digital, temos H(z) = (1-z^{-2})/1-2rcos(w_0)z^{-1}+r^2z^{-2}
//o valor de r determina quão amplificada será a frequência w_0 em relação às demais
//escolhemos w_0 como sendo a frequência correspondente a f_1, cos(2*%pi*9/1250)
//para realçar o efeito do filtro, utilizamos 3 filtros iguais em cascata

// primeiro sinal
x_1(k) = sin(2*%pi*f1*(k/Fs))+sin(2*%pi*f2*(k/Fs));

// segundo sinal
x_2 = [3*sin(2*%pi*f1*k*linspace(0,1.5,Fs*1.5)) 3*sin(2*%pi*f2*k*linspace(1.5,3,Fs*1.5))];

// para f_2 = 400, temos cos(w_0) = cos(2*%pi*400/1250), e utilizamos apenas um dispositivo
//if k==1
//y_1(k) = x_1(k);
//end
//if k==2
//y_1(k) = x_1(k)- 0.8089807*y_1(k-1);
//end
//if k>=3
//y_1(k) = x_1(k)-x_1(k-2)- 0.8089807*y_1(k-1)-0.9025*y_1(k-2);
//end


// Aplicando o filtro
// filtro ressonador digital, temos H(z) = (1-z^{-2})/1-2rcos(w_0)z^{-1}+r^2z^{-2}
// r = 0.95 -> nos devemos escolher esse valor, se baseando na frequencia que desejamos filtrar
// w_0 = 2*%pi*f1 / 1250
w_0 = 2*%pi*f1 / 1250;
r = 0.95;

//H(k) = (1-k^-2)/1-2*r*cos(w_0)*k^-1+r^2*k^-2


    


end

// ESSE FILTRO AQUI É UM PASSA FAIXA QUE ISOLA F2
for i = 0:M1
    if i <> M1/2
    H(i+1) = (sin(wc2 * (i - M1/2))/ (%pi * (i - M1/2))) - (sin(wc1 * (i - M1/2)) / (%pi * (i - M1/2)));
    H(i+1) = H(i+1) * (0.54 - 0.46 * cos(2*%pi * (i)/M1));
    else
    H(i+1) = 0 ;
end
end


// AGORA PARA ISOLAR F1

//especificamos w1, w2
w1 = 2*%pi*f1 / Fs;
w2 = 2*%pi*f2 / Fs;

M = 3300;
n = 0:M;

// Defini a passagem delta_w = 0.001 * 5pi

// Usarei a janela de Hamming

wp1 = w1 - 0.002*%pi;
ws1 = w1 - 0.001*%pi;

wc1 = (wp1 + ws1)/2;

wp2 = w1 +0.001*%pi;
ws2 = w1 + 0.002*%pi;

wc2 = (wp2 + ws2)/2;


// ESSE FILTRO AQUI É UM PASSA FAIXA QUE ISOLA F2
for i = 0:M
    if i <> M/2
    H1(i+1) = (sin(wc2 * (i - M/2))/ (%pi * (i - M/2))) - (sin(wc1 * (i - M/2)) / (%pi * (i - M/2)));
    H1(i+1) = H1(i+1) * (0.54 - 0.46 * cos(2*%pi * (i)/M));
    else
    H1(i+1) = 0 ;
end
end

// ISOLANDO F1 DE X_1
//plot(linspace(0,3,3*Fs + M)', conv(x_1, H1));
 
// ISOLANDO F2 DE X_1

plot(linspace(0,3,3*Fs + M1)', conv(x_1, H));
