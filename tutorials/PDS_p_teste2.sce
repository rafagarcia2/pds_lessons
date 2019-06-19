function Hk = filtro_passa_faixa(f_max,f_c_min,f_c_max,num)
    res_f = 2*f_max/num
    Hk1 = [zeros(1,f_c_min/res_f) ones(1,(f_c_max-f_c_min)/res_f) zeros(1,(f_max-f_c_max)/res_f)]
    Hk = [Hk1 Hk1(length(Hk1):-1:1)];
    odd=1;
    while length(Hk)<num
       if odd==1
       Hk(length(Hk)+1) = 0    
       end
       if odd==-1
       Hk = [0 Hk] 
       end
       odd=-odd
    end
    while length(Hk)>num
       if odd==1
       Hk(length(Hk)) = []    
       end
       if odd == -1
       Hk(1) = [];
       end
       odd = -odd
    end
endfunction



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
