
//Dada a taxa de amostragem de 2500 Hz, e usando como exemplo f_1=9,f_2=39 e f_3=399
f_1 = 9;
f_2 = 39;
f_3 = 399;
//especificamos w_1, w_2 e w_3 de acordo
w_1 = 2*%pi*f_1;
w_2 = 2*%pi*f_2;
w_3 = 2*%pi*f_3;
//construimos um vetor de tempo para x_1 e 3 vetores de tempo para x_2
t_1 = linspace(0,3,7500);
t_21 = linspace(0,1,2500);
t_22 = linspace(1,2,2500);
t_23 = linspace(2,3,2500);
//construímos x_1 usando w_1, w_2 e w_3 e o vetor de tempo t_1
x_1 = sin(w_1*t_1)+sin(w_2*t_1)+sin(w_3*t_1);
//construímos x_2 usando w_1, w_2 e w_3 e os vetores de tempo t_21, t_22 e t_23
x_2 = [sin(w_1*t_21) sin(w_2*t_22) sin(w_3*t_23)];

//para evitar o aliasing no domínio das amostras preenchemos os sinais com zeros
x_1 = [x_1 zeros(1,7500)];
x_2 = [x_2 zeros(1,7500)];

//Devemos especificar os filtros no dominio da frequencia, dada a taxa de amostragem f_a
//temos um mapeamento das frequencias de f_a = 0 a f_a = 2500Hz para f = 0 a f=1/2
//adicionalmente, devemos levar em conta o efeito do vazamento de frequencias
//isto é, como o sinal foi observado durante um intervalo de tempo finito a 
//o sinal se encontra distribuido em torno das frequencias f_1, f_2 e f_3
//e não concentrado especificamente em cada uma delas.

//para especificar os filtros fazemos nota da relação entre o número de amostras
//e a frequência de amostragem, 2500Hz/15000 amostras nos dá 1Hz/6 amostras
//o primeiro filtro, Hk1, deve admitir a frequencia f_1=9 e rejeitar f_2 e f_3
//desta forma, uma determinada faixa em torno de f_1 deve ser selecionada
//vamos selecionar esta faixa como sendo delta = 6 Hz, assim, nosso filtro deve
//admitir entre 3Hz e 15 Hz, vamos construir o filtro passo a passo:

//passo 1, a resposta em frequência é nula até 3 Hz
Hk1 = [zeros(1,18)];
//passo 2, a resposta em frequência é unitária de 3 Hz até 15Hz
Hk1 = [Hk1 ones(1,72)];
//passo 3, a resposta em frequência é nula de 15Hz até 1250Hz;
Hk1 = [Hk1 zeros(1,7410)];
//passo 4, construímos o vetor Hk1 usando uma cópia refletida do Hk1 que construimos até agora
//especificamente, as amostras 0 a 7500 correspondem as frequencias 0 a 1250
//as amostras de 7501 até 15000 correspondem as frequencias -1250 a 0
//além disso, o filtro deve ser simétrico em relação às frequências(par).
Hk1 = [Hk1 flipdim(Hk1,2)];

//Agora, passamos a filtragem offline, primeiro transformando os sinais x_1 e x_2
Xk_1 = fft(x_1);
Xk_2 = fft(x_2);

//Para observar o efeito do filtro, fazemos a multiplicação elemento a elemento
//desta forma obtemos os espectros dos sinais na saída do filtro

Yk_1 = Xk_1.*Hk1;
Yk_2 = Xk_2.*Hk1;

//então, obtemos os sinais na saída através da transformada inversa:

y_1 = ifft(Yk_1);
y_2 = ifft(Yk_2);

//como realizamos o zero padding, vamos criar um novo vetor de tempo para plotar estes
//sinais
t_plot = linspace(0,6,15000);

//finalmente, executamos a plotagem:
figure(1);
plot(t_plot,x_1);
figure(2)
plot(t_plot,x_2);
figure(3);
plot(t_plot,y_1);
figure(4)
plot(t_plot,y_2);

//Agora, tendo obtido nossos resultados, observamos o efeito do vazamento de frequencia
//como as frequências estão suficientemente afastadas, vamos aumentar a faixa de admissão
//do filtro Hk1 para observar os resultados:

//Hk1 = [];
//passo 2, a resposta em frequência é unitária de 0 Hz até 18Hz
//Hk1 = [Hk1 ones(1,108)];
//passo 3, a resposta em frequência é nula de 15Hz até 1250Hz;
//Hk1 = [Hk1 zeros(1,7392)];
//passo 4, construímos o vetor Hk1 usando uma cópia refletida do mesmo
//Hk1 = [Hk1 flipdim(Hk1,2)];

//Yk_1 = Xk_1.*Hk1;
//Yk_2 = Xk_2.*Hk1;
//y_1 = ifft(Yk_1);
//y_2 = ifft(Yk_2);
//plot(t_plot,y_2);













