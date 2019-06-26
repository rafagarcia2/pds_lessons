// TRABALHO UNIDADE 2

// frequencia utilizadas
f1 = 1;
f2 = 112;

//especificamos w1, w2
w1 = 2*%pi*f1;
w2 = 2*%pi*f2;

// coeficientes 
r = 0.95;

C1 = 2 * r * cos(2*%pi*f_1/1250);
C2 = 2 * r * cos(2*%pi*f_2/1250);

//Usaremos agora um laço para simular o comportamento em tempo real do sistema:
for k=1:7500

    // primeiro sinal
    x_1(k) = sin(w1*k/2500)+sin(w2*k/2500);
    
    // segundo sinal
    x_2 = [3*sin(w1*k*linspace(0,1.5,2500*1.5)) 3*sin(w2*k*linspace(1.5,3,2500*1.5))]
    
    t(k) = k/2500;
    
    // filtro para f1 de x_1
    if k==1
        y_1(k) = x_1(k);
        y_2(k) = y_1(k);
        y_3(k) = y_2(k);
    end
    if k==2
        y_1(k) = x_1(k)+C1*y_1(k-1);
        y_2(k) = y_1(k)+C1*y_2(k-1);
        y_3(k) = y_2(k)+C1*y_3(k-1);
    end
    if k>=3
        y_1(k) = x_1(k)-x_1(k-2)+C1*y_1(k-1)-0.9025*y_1(k-2);
        y_2(k) = y_1(k)-y_1(k-2)+C1*y_2(k-1)-0.9025*y_2(k-2);
        y_3(k) = y_2(k)-y_2(k-2)+C1*y_3(k-1)-0.9025*y_3(k-2);
    end

    // filtro para f1 de x_1
    if k==1
        y2_1(k) = x_1(k);
    end
    if k==2
        y2_1(k) = x_1(k) - C2*y2_1(k-1);
    end
    if k>=3
        y2_1(k) = x_1(k)-x_1(k-2)- C2*y2_1(k-1)-0.9025*y2_1(k-2);
    end


    // filtro para f1 de x_2
    if k==1
        y3_1(k) = x_2(k);
        y3_2(k) = y3_1(k);
        y3_3(k) = y3_2(k);
    end
    if k==2
        y3_1(k) = x_2(k)+C1*y3_1(k-1);
        y3_2(k) = y3_1(k)+C1*y3_2(k-1);
        y3_3(k) = y3_2(k)+C1*y3_3(k-1);
    end
    if k>=3
        y3_1(k) = x_2(k)-x_2(k-2)+C1*y3_1(k-1)-0.9025*y3_1(k-2);
        y3_2(k) = y3_1(k)-y3_1(k-2)+C1*y3_2(k-1)-0.9025*y3_2(k-2);
        y3_3(k) = y3_2(k)-y3_2(k-2)+C1*y3_3(k-1)-0.9025*y3_3(k-2);
    end

    // filtro para f1 de x_2
    if k==1
        y4_1(k) = x_2(k);
    end
    if k==2
        y4_1(k) = x_2(k) - C2*y4_1(k-1);
    end
    if k>=3
        y4_1(k) = x_2(k)-x_2(k-2)- C2*y4_1(k-1)-0.9025*y4_1(k-2);
    end

    
end

//plot2d(t,y_1)
plot2d(t, y3_3)
