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
H1 = filtro_passa_faixa(7500/2,f1,f2,length(x_1))
S1k = H1.*X_1
s1 = ifft(S1k)

H2 = filtro_passa_faixa(7500/2,f2,f3,length(x_1))
S2k = H2.*X_1
s2 = ifft(S2k)

H3 = filtro_passa_faixa(7500/2,f3,length(x_1),length(x_1))
S3k = H3.*X_1
s3 = ifft(S3k)

plot_graph(s3);
