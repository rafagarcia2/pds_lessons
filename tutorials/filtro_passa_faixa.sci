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
       if odd==-1
       Hk(1) = [];
       end
       odd=-odd
    end
endfunction

BasebandFrequency = 10e3;
SamplingFrequency = 1e6;
BufferLength = 200;
n = 0:(BufferLength - 1);
BasebandSignal = sin(2*%pi*n / (SamplingFrequency/BasebandFrequency));


BasebandDFT = fft(BasebandSignal);
BasebandDFT_magnitude = abs(BasebandDFT);
plot(BasebandDFT_magnitude)
