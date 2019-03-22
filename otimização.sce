clc
mc=[            //matriz dos coeficientes
1 -4 -2 -2 0 0 0;
0 1 1 2 1 0 4; 
0 4 -5 3 0 1 30;  
]
x=zeros(1,(size(mc)(2)-2))

disp(mc)
/* INICIALIZAÇÃO DA MATRIZ E DO VETOR DE VARIAVEIS*/
var_maximi=2

var_parada=0
mc_original=mc
passos=0
//RECURSIVIDADE
while var_parada==0
valor_menor=mc(1,2)
var_maximi=2
var_parada=1 
var_obj=zeros(2)
quo=10^9
//ENCONTRANDO AS VARIÁVEIS NÃO BÁSICAS E A VARIÁVEL A SER MAXIMIZADA(QUE VAI ENTRAR NA BASE)
contador=1
    for i=2:size(mc)(2)-1
        if (i~=2 & mc(1,i)<valor_menor)
            valor_menor=mc(1,i)
            var_maximi=i
        end
    end
//ENCONTRANDO A EQUAÇÃO DA VARIÁVEL A SER MAXIMIZADA DE ACORDO COM O MENOR QUOCIENTE
    for i=2:(size(mc)(1))
        if(mc(i,var_maximi)~=0 & ((mc(i,size(mc)(2))/mc(i,var_maximi))<quo) & mc(i,var_maximi)>0) then
            quo=mc(i,size(mc)(2))/mc(i,var_maximi)
            num_eq=i
        end
    end
//MANTENDO O COEFICIENTE DA VÁRIAVEL A SER MAXIMIZADA IGUAL A 1
     if  mc(num_eq,var_maximi)~=1 then
        for i=1:(size(mc)(2))
            if (i~=var_maximi) then
                mc(num_eq,i)=mc(num_eq,i)/(mc(num_eq,var_maximi))
            end
        end
    end
mc(num_eq,var_maximi)=1

//FAZENDO AS OPERAÇÕES NAS LINHAS DA MATRIZ PARA ZERAR OS COEFICIENTES DA VARIÁVEL A SER MAXIMIZADA NAS OUTRAS EQUAÇÕES
    for i=1:(size(mc)(1))
        for j=1:(size(mc)(2))
            if(i~=num_eq & j~=var_maximi) then
                mc(i,j)=mc(i,j)-(mc(i,var_maximi)*mc(num_eq,j))         
            end
        end
    end

    for i=1:(size(mc)(1))
        if(i~=num_eq & mc(i,var_maximi)~=0) then
                mc(i,var_maximi)=0         
        end
    end

//PARANDO O WHILE AO ENCONTRAR A SOLUÇÃO ÓTIMA    
    for i=2:size(mc)(2)-1
       if(mc(1,i)<0) then
          var_parada=0
       end        
    end
    for i=2:size(mc)(2)-1
        if  mc(1,i)~=0 then
            var_obj(contador)=i
            contador=contador+1
        end
    end
passos=passos+1
pause
end

//ENCONTRANDO OS VALORES DO VETOR DE VARIÁVEIS PARA A SOLUÇÃO ÓTIMA x(1...n)
for i=2:size(mc)(1)
    for j=2:size(mc)(2)-1
        if (mc(i,j)~=0 & j~=var_obj(1) & j~=var_obj(2)) then
            x(j-1)=mc(i,size(mc)(2))/mc(i,j)           
        end
    end
end
disp ("Para o sistema:")
disp(mc_original)
sol_otima=mc(1,size(mc)(2))
disp(sol_otima, "A solução ótima é:")
disp(x,"Encontrados a partir do vetor de variáveis abaixo:")
disp(x(1),"No qual x1 é igual a:")
disp(x(2),"E x2 é igual a:")



