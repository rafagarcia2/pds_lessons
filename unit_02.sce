// Trabalho referente a segunda unidade de PDS

// importando as funções utilizadas
getd('/home/rafael/UFRN/01_processamento_digital_sinais/pds_lessons/utils')

// Frequências
f1 = 1
f2 = 11
f3 = 112

// primeiro sinal
x_1 = sin(1*linspace(0,3,2500*3))+sin(11*linspace(0,3,2500*3))+sin(112*linspace(0,3,2500*3))

// segundo sinal
x_2 = [sin(1*linspace(0,1,2500*1)) sin(11*linspace(1,2,2500*1)) sin(112*linspace(2,3,2500*1))]


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
H1 = [ones(1, 11) zeros(1,2489)];

H2 = [zeros(1,11) ones(1, 112) zeros(1,2500)];

// H3 = [zeros(1,n) ones(1,x) zeros(1,y) ones(1,x) zeros(1,n)];

// Yk_1 = X_1.*H1;

plot_graph(X_1);
