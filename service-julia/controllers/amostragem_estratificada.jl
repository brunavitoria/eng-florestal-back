module AmostragemEstratificadaController

using DataFrames, CSV

include("../functions/amostragem_estratificada.jl")

function process()
    
    dir_path = @__DIR__
    data_path = dir_path * "/../../files/input_data/"
    filename = "amostragem_estratificada.csv"
    data = CSV.read(data_path * filename, DataFrames)
    #Informações necessárias
    #Área da população
    Área = 45
    #Número total de unidades de amostragem na população
    N = Área/0.1 
    #Nível de significância (α)
    alpha = 0.05
    EAR = 10 #Erro da amostragem requerido
    #Unidade de medida da variável
    Unidade = "m³/0.1 ha" #Alterar em função do inventário
    #Conversor para a unidade de área por hectare
    Área_da_parcela=0.1
    Conversor=1/Área_da_parcela
    #Número potencial de Unidades por estrato
    nh1=7 #estrato I
    nh2=8 #estrato II
    nh3=7 #estrato III
    #Estratificada(Estrato, Unidade, Volume)
    Estratificada(Dados.Estrato, Dados.Unidade, Dados.Volume) #Saída dos dados

    "Teste Amostragem Estratificada Controller!"
end

end