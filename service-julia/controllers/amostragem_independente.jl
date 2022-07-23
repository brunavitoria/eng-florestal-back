module AmostragemEstratificadaController

using DataFrames, CSV

include("../functions/amostragem_independente.jl")

function process()
    
    dir_path = @__DIR__
    data_path = dir_path * "/../../files/input_data/"
    filename = "amostragem_Independente.csv"
    data = CSV.read(data_path * filename, DataFrames)
    #Informações necessárias
    #Área da população na primeira ocasião
    N1 = 1500
    #Área da população na segunda ocasião
    N2 = 1500
    #Nível de significância (α)
    alpha = 0.05
    #Unidade de medida da variável
    Unidade = "m³/1 ha" #Alterar em função do inventário
    #Conversor para a unidade de área por hectare
    Área_da_parcela=1
    Conversor=1/Área_da_parcela
    #function Independente(n, Ocasiao_1, Ocasiao_2)
    Independente(Dados.n, Dados.Ocasiao_1, Dados.Ocasiao_2) #Saída dos dados


    "Teste Amostragem Independente Controller!"
end

end