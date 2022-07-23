module AmostragemMulController

using DataFrames, CSV

include("../functions/amostragem_mult_inic_alea.jl")

function process()
    
    dir_path = @__DIR__
    data_path = dir_path * "/../../files/input_data/"
    filename = "amostragem_mult_inic_alea.csv"
    data = CSV.read(data_path * filename, DataFrames)
    #Informações necessárias
    #Área da população
    area = 13000
    N = 6.500 
    ##Nível de significância (α)
    alpha = 0.05 
    EAR = 10 #Erro da amostragem requerido
    #Unidade de medida da variável
    Unidade = "m³/0.25 ha" #Alterar em função do inventário
    #Conversor para a unidade de área por hectare
    Área_da_parcela=0.25
    Conversor=1/Área_da_parcela
    #function Multiplos_inicios_aleatorios(Dados)
    Multiplos_inicios_aleatorios(Dados) #Saída dos dados

    "Teste Amostragem Sistemática com Múltiplos Inicios Aleatórios Controller!"
end

end