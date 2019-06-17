//exemplo de uso da fft na filtragem de sinais
tx_amost = 10000;
t_final = 1;
t_inicial = 0;
t = t_inicial:1/tx_amost:t_final
N = size(t,'*')
x = [sin(2*%pi*50*t) sin(2*%pi*600*t) sin(2*%pi*100*t)]//+grand(1,3*N,'nor',0,1)
Xk = fft(x)
num=length(x)
f=tx_amost*(0:(3*N/2))/(3*N);
n=size(f,'*')
//clf()
//plot(f,abs(Xk(1:n)))
Hk = filtro_passa_faixa(tx_amost/2,60,140,num)
S1k = Hk.*Xk
s1 = ifft(S1k)
plot(s1)
