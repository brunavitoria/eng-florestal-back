module AmostragemSistematicaController

using DataFrames, CSV

using Genie.Requests

include("../functions/amostragem_sistematica.jl")

function process()
    request_data = jsonpayload()
    file_id = request_data["file_id"]
    area = request_data["area"]
    nivel_significancia = request_data["nivel_significancia"]
    EAR = request_data["erro_requerido"]
    area_parcela = request_data["area_parcela"]

    dir_path = @__DIR__
    data_path = dir_path * "/../../files/input_data/"
    filename = file_id * ".csv"

    output_path = dir_path * "/../../files/output_data/"
    output_filename = file_id * ".xlsx"

    data = CSV.read(data_path * filename, DataFrame)

    #Número total de unidades de amostragem na população
    N = area/0.1

    #Unidade de medida da variável
    Unidade = "m³/0.1 ha" #Alterar em função do inventário
    #Conversor para a unidade de área por hectare


    Conversor=1/area_parcela

    AAS(
        area,
        nivel_significancia,
        EAR,
        area_parcela,
        N,
        Unidade,
        output_path * output_filename
    )

    "Ok"
end

end