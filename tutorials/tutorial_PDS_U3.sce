clear
//Dada a taxa de amostragem de 2500 Hz, e usando como exemplo f_1=9 e f_2=400
f_1 = 9;
f_2 = 400;
//especificamos w_1, w_2 de acordo
w_1 = 2*%pi*f_1;
w_2 = 2*%pi*f_2;
//Usaremos agora um laço para simular o comportamento em tempo real do sistema:
for k=1:7500
//nosso filtro é representado por uma equação diferença, assim, devemos escolher
//polos e zeros tal que o comportamento do filtro seja como desejamos
//para um filtro ressonador digital, temos H(z) = (1-z^{-2})/1-2rcos(w_0)z^{-1}+r^2z^{-2}
//o valor de r determina quão amplificada será a frequência w_0 em relação às demais
//escolhemos w_0 como sendo a frequência correspondente a f_1, cos(2*%pi*9/1250)
//para realçar o efeito do filtro, utilizamos 3 filtros iguais em cascata
x_1(k) = sin(w_1*k/2500)+sin(w_2*k/2500);
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


    
end

//plot(t,y_1)
plot(t,y_3)


