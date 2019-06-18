function x=plot_graph(signal)
    taxa_amostragem=7500;
    t = 0:1/taxa_amostragem:0.6; //vetor tempo
    N=size(t,'*'); //numero de amostras
    
    f=taxa_amostragem*(0:(N/2))/N; //vetor de frequencias
    n=size(f,'*')
    clf()
    plot(f,abs(signal(1:n)))
endfunction
