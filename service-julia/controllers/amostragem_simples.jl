module AmostragemSimplesController

using DataFrames, CSV

using Genie.Requests

include("../functions/amostragem_simples.jl")

function process()
    request_data = jsonpayload()
    file_id = request_data["file_id"]
    area = request_data["area"]
    nivel_significancia = request_data["nivel_significancia"]
    area_parcela = request_data["area_parcela"]
    erro_requerido = request_data["erro_requerido"]

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
        data.Unidades,
        data.Volume,
        N,
        nivel_significancia,
        Conversor,
        erro_requerido,
        area,
        output_path * output_filename
    )

    "Ok"
end

end