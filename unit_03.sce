// TRABALHO UNIDADE 2

// frequencia utilizadas
f1 = 1;
f2 = 112;

//especificamos w1, w2
w1 = 2*%pi*f1;
w2 = 2*%pi*f2;

//Usaremos agora um laço para simular o comportamento em tempo real do sistema:
for k=1:7500
//nosso filtro é representado por uma equação diferença, assim, devemos escolher
//polos e zeros tal que o comportamento do filtro seja como desejamos
//para um filtro ressonador digital, temos H(z) = (1-z^{-2})/1-2rcos(w_0)z^{-1}+r^2z^{-2}
//o valor de r determina quão amplificada será a frequência w_0 em relação às demais
//escolhemos w_0 como sendo a frequência correspondente a f_1, cos(2*%pi*9/1250)
//para realçar o efeito do filtro, utilizamos 3 filtros iguais em cascata

// primeiro sinal
x_1(k) = sin(w1*k/2500)+sin(w2*k/2500);

// segundo sinal
x_2 = [3*sin(w1*k*linspace(0,1.5,2500*1.5)) 3*sin(w2*k*linspace(1.5,3,2500*1.5))]

t(k) = k/2500;
if k==1
y_1(k) = x_1(k);
y_2(k) = y_1(k);
y_3(k) = y_2(k);
end
if k==2
y_1(k) = x_1(k)+1.8980561*y_1(k-1);
y_2(k) = y_1(k)+1.8980561*y_2(k-1);
y_3(k) = y_2(k)+1.8980561*y_3(k-1);
end
if k>=3
y_1(k) = x_1(k)-x_1(k-2)+1.8980561*y_1(k-1)-0.9025*y_1(k-2);
y_2(k) = y_1(k)-y_1(k-2)+1.8980561*y_2(k-1)-0.9025*y_2(k-2);
y_3(k) = y_2(k)-y_2(k-2)+1.8980561*y_3(k-1)-0.9025*y_3(k-2);
end
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
w_0 = 2*%pi*f1 / 1250
r = 0.95

H(k) = (1-k^-2)/1-2*r*cos(w_0)*k^-1+r^2*k^-2

// Hk1 = [Hk1 zeros(1,3744)];
//passo 2, a resposta em frequência é unitária de 0 Hz até 18Hz
Hk1 = [Hk1 ones(1,12)];
//passo 3, a resposta em frequência é nula de 15Hz até 1250Hz;
Hk1 = [Hk1 zeros(1,3738)];
//passo 4, construímos o vetor Hk1 usando uma cópia refletida do mesmo
Hk1 = [Hk1 flipdim(Hk1,2)];



end

//plot(t,y_3)
plot2d(x_2)


