
//exemplo de uso da fft na filtragem de sinais
tx_amost = 10000;
t_final = 1;
t_inicial = 0;
t = t_inicial:1/tx_amost:t_final
N = size(t,'*')
x = [sin(2*%pi*50*t)+sin(2*%pi*600*t)+sin(2*%pi*100*t)]+grand(1,N,'nor',0,1)
Xk = fft(x)
num=length(x)
f=tx_amost*(0:(N/2))/N;
n=size(f,'*')
//clf()
//plot(f,abs(Xk(1:n)))

//f = linspace(0,607,num)
Hk1 = filtro_passa_faixa(tx_amost/2,590,610,num);
//Hk2 = filtro_passa_faixa(600,0,20,num)
//S1k = Hk1.*Yk;
S2k = Hk1.*Xk;
//s1 = ifft(S1k);
s2 = ifft(S2k);
//plot(f,Xk)
//plot(t,s2)
