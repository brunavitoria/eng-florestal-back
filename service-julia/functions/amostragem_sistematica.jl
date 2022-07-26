#Inventário Florestal🌳
#Amostragem sistemática

using DataFrames, Statistics, Distributions, CSV, XLSX #Habilitar pacotes

#Função Sistematica: amostragem sistemática
function Sistematica(area, nivel_significancia, EAR, area_parcela, N, Unidade, output_file) #Determinar função
    Conjunto_de_dados = (Conversor.*output_file)
    #Tabela com estatítica descritiva por unidade secundária/bloco
    Tabela=transform(Conjunto_de_dados, AsTable(:) .=> ByRow.([I -> count(!ismissing, I), sum, mean, var]).=>[:n, :Soma, :Média, :Variância])
    m=length(Tabela.n) #Número de faixas
    nj=first(unique((Tabela.n))) #Número de unidades
    n=(length(Tabela.n)*first(unique((Tabela.n)))) #Número de unidades amostrais totais
    (quantile(TDist(n-1), 1-alpha/2)) #Valor de t
    (1-((length(Tabela.n)*first(unique((Tabela.n))))/N)) #Fração da amostragem 
    if (1-((length(Tabela.n)*first(unique((Tabela.n))))/N)) ≥ 0.98 #f maior ou igual a 0,98 população infinita
        População = "é considerada infinita"   
            println(População)
        elseif (1-((length(Tabela.n)*first(unique((Tabela.n))))/N)) < 0.98 #f menor que 0,98 população finita
        População = "é considerada finita"    
            println(População)
            end
    mean(Tabela.Média)
    g=Matrix(output_file)
    matriz=transpose(g)
    global a = 0
    global Sx² = 0
    for i in 1:length(matriz)-1
        if i % first(unique((Tabela.n))) == 0
            continue
            end
        global a += (sum(matriz[i]-matriz[i+1])^2)
        Sx² = (a/(2*(length(Tabela.n)*first(unique((Tabela.n))))*((length(Tabela.n)*first(unique((Tabela.n))))-length(Tabela.n))))*
            (1-((length(Tabela.n)*first(unique((Tabela.n))))/N)) #Estimativa aproximada da variância da média
        end
    sqrt(Sx²) #Estimativa aproximada do erro padrão
    #Erro da amostragem
    ((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 1-alpha/2))*sqrt(Sx²)) #Absoluto
    (((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 
    1-alpha/2))*sqrt(Sx²))/mean(Tabela.Média))*1000 #Relativo
    #Limite do intervalo de confiança para média
    mean(Tabela.Média)-((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 
    1-alpha/2))*sqrt(Sx²)) #Inferior
    mean(Tabela.Média)+((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 
    1-alpha/2))*sqrt(Sx²)) #Superior  
    #Total da população
    ((N*mean(Tabela.Média))/Conversor)
    #Limite do intervalo de confiança para o total
    (((N*mean(Tabela.Média))-N*((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 
    1-alpha/2))*sqrt(Sx²)))/Conversor) #Inferior 
    (((N*mean(Tabela.Média))+N*((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 
    1-alpha/2))*sqrt(Sx²)))/Conversor) #Superior
    if (((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 1-alpha/2))*sqrt(Sx²))/mean(Tabela.Média))*100 > EAR
        Observação = "Diante do exposto, conclui-se que os resultados obtidos na amostragem não satisfazem as exigências de
        precisão estabelecidas para o inventário, ou seja, um erro de amostragem máximo de ±10% da média  para confiabilidade designada. 
        O erro estimado foi maior que o limite fixado, sendo recomendado incluir mais unidades amostrais no inventário."
        println(Observação)
        elseif (((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 1-alpha/2))*sqrt(Sx²))/mean(Tabela.Média))*100 ≤ EAR
            Observação  = "Diante do exposto, conclui-se que os resultados obtidos na amostragem satisfazem as exigências de
                precisão estabelecidas para o inventário, ou seja, um erro de amostragem máximo de ±10% da média para confiabilidade designada. 
                O erro estimado foi menor que o limite fixado, assim as unidades amostrais são suficientes para o inventário."
                println(Observação)
        end
    Resultados = DataFrames.DataFrame(Variáveis=["Média (m³/ha)", "Limite inferior do intervalo de confiança para média (m³/ha)", 
    "Limite superior do intervalo de confiança para média (m³/ha)", "Total da população (m³)", "Limite inferior do intervalo de confiança para o total (m³)", 
    "Limite superior do intervalo de confiança para o total (m³)", "Área da população (ha)", "Erro da amostragem relativo (%)", 
    "Erro padrão absoluto (m³/ha)", "Erro padrão da média (m³/ha)", "Variância da média (m³/ha)²", "Fração da amostragem", "População", 
    "Unidades amostrais possíveis", "Número de unidades amostrais totais", "Número de unidades do inventário florestal", 
    "Número de faixas do inventário florestal",  "Nível de significância (α)", "Observação"], 
    Valores=[mean(Tabela.Média), mean(Tabela.Média)-((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 
    1-alpha/2))*sqrt(Sx²)), mean(Tabela.Média)+((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 
    1-alpha/2))*sqrt(Sx²)), ((N*mean(Tabela.Média))/Conversor), (((N*mean(Tabela.Média))-N*((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 
    1-alpha/2))*sqrt(Sx²)))/Conversor), (((N*mean(Tabela.Média))+N*((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 
    1-alpha/2))*sqrt(Sx²)))/Conversor), area, (((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 
    1-alpha/2))*sqrt(Sx²))/mean(Tabela.Média))*1000, ((quantile(TDist((length(Tabela.n)*first(unique((Tabela.n))))-1), 1-alpha/2))*sqrt(Sx²)), 
    sqrt(Sx²), Sx², (1-((length(Tabela.n)*first(unique((Tabela.n))))/N)), População, N, (length(Tabela.n)*first(unique((Tabela.n)))), 
    first(unique((Tabela.n))), length(Tabela.n), alpha, Observação]) #Tabela de resultados
    
    XLSX.writetable(output_file, Dados=(collect(DataFrames.eachcol(Conjunto_de_dados)), 
        DataFrames.names(Conjunto_de_dados)), Analise_descritiva=( collect(DataFrames.eachcol(Tabela)), DataFrames.names(Tabela)),  
    Resultados=( collect(DataFrames.eachcol(Resultados)), DataFrames.names(Resultados))) #Exportar para o Excel
end 
