// Trabalho referente a segunda unidade de PDS


// primeiro sinal
x_1 = sin(3*linspace(0,3,2500*3))+sin(35*linspace(0,3,2500*3))+sin(358*linspace(0,3,2500*3))

// segundo sinal
x_2 = [sin(1*linspace(0,1,2500*1)) sin(11*linspace(1,2,2500*1)) sin(112*linspace(2,3,2500*1))]


// calculando a transformada dos dois sinais
taxa_amostragem=1000;
t = 0:1/taxa_amostragem:0.6; //vetor tempo
N=size(t,'*'); //numero de amostras

y=fft(x_1); //fft do sinal

f=taxa_amostragem*(0:(N/2))/N; //vetor de frequencias
n=size(f,'*')
clf()
plot(f,abs(y(1:n)))
