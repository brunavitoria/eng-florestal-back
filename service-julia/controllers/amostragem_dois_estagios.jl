module AmostragemSimplesController

using DataFrames, CSV

using Genie.Requests

include("../functions/amostragem_dois_estagios.jl")

function process()
    request_data = jsonpayload()
    file_id = request_data["file_id"]
    area = request_data["area_populacao"]
    M = request_data["nro_unid_sec_prim"]
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
    N = area/10000
    #Unidade de medida da variável
    Unidade = "m³/0.25 ha"
    #Conversor para a unidade de área por hectare
    Conversor = 1/area_parcela
    #Nível de significância (α)
    alpha = 0.05

    AAS(
        area,
        M,
        alpha,
        EAR,
        Unidade,
        area_parcela,
        output_path * output_filename,
        Conversor,
        N
    )

    "Ok"
end

end