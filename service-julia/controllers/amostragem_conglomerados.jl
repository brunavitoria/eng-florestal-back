module AmostragemConglomeradosController

using DataFrames, CSV

using Genie.Requests

include("../functions/amostragem_conglomerados.jl")

function process()
    request_data = jsonpayload()
    file_id = request_data["file_id"]
    area = request_data["area_populacao"]
    alpha = request_data["nivel_significancia"]
    EAR = request_data["erro_requerido"]
    area_parcela = request_data["area_parcela"]

    #Número potencial de unidades populacionais 
    N = area
    #Unidade de medida da variável
    Unidade = "m³/0.25 ha" #Alterar em função do inventário

    Conversor=1/area_parcela

    dir_path = @__DIR__
    data_path = dir_path * "/../../files/input_data/"
    filename = file_id * ".csv"

    output_path = dir_path * "/../../files/output_data/"
    output_filename = file_id * ".xlsx"

    data = CSV.read(data_path * filename, DataFrame)

    AAS(
        area,
        alpha,
        EAR,
        area_parcela,
        N,
        Unidade,
        output_path * output_filename,
        Conversor,
    )

    "Ok"
end

end