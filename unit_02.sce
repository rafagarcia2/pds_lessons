// Trabalho referente a segunda unidade de PDS

// importando as funções utilizadas
getd('/home/rafael/UFRN/01_processamento_digital_sinais/pds_lessons/utils')

// Frequências
f1 = 1
f2 = 11
f3 = 112

// primeiro sinal
x_1 = sin(2*%pi*f1*linspace(0,3,2500*3))+sin(2*%pi*f2*linspace(0,3,2500*3))+sin(2*%pi*f3*linspace(0,3,2500*3))

// segundo sinal
x_2 = [sin(2*%pi*f1*linspace(0,1,2500*1)) sin(2*%pi*f2*linspace(1,2,2500*1)) sin(2*%pi*f3*linspace(2,3,2500*1))]

//para evitar o aliasing no domínio das amostras preenchemos os sinais com zeros
//x_1 = [x_1 zeros(1,7500)];
//x_2 = [x_2 zeros(1,7500)];


// a) calculando a transformada dos dois sinais

X_1 = fft(x_1); //fft do sinal 1
X_2 = fft(x_2); //fft do sinal 2


// b) calculando a transformada inversa
x1 = ifft(X_1);
x2 = ifft(X_2);

// c) valor absoluto dos espectros amostrados ???
abs_1 = abs(X_1)
abs_2 = abs(X_2)
dif = abs_1 - abs_2

// d) filtro passa faixa

//H1 = filtro_passa_faixa(7500/2,f1,f2,length(x_1))
//S1k = H1.*X_1
//s1 = ifft(S1k)
//
//H2 = filtro_passa_faixa(7500/2,f2,f3,length(x_1))
//S2k = H2.*X_1
//s2 = ifft(S2k)
//
//H3 = filtro_passa_faixa(7500/2,f3,length(x_1),length(x_1))
//S3k = H3.*X_1
//s3 = ifft(S3k)

// criando o filtro passa faixa
Hk1 = [];
Hk1 = [Hk1 zeros(1,3744)];
//passo 2, a resposta em frequência é unitária de 0 Hz até 18Hz
Hk1 = [Hk1 ones(1,6)];
//passo 3, a resposta em frequência é nula de 15Hz até 1250Hz;
Hk1 = [Hk1 zeros(1,3744)];
//passo 4, construímos o vetor Hk1 usando uma cópia refletida do mesmo
Hk1 = [Hk1 flipdim(Hk1,2)];

Yk_1 = X_1.*Hk1;
//Yk_2 = Xk_2.*Hk1;
y_1 = ifft(Yk_1);
//y_2 = ifft(Yk_2);

//plot_graph(x_1);
//t_plot = linspace(0,2500,7500);

plot2d(y_1);
