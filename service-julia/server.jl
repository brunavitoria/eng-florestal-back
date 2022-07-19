using Genie, Genie.Router
using Genie.Renderer, Genie.Renderer.Html, Genie.Renderer.Json

include("./controllers/amostragem_simples.jl"); 
using .AmostragemSimplesController;

route("/amostragem-simples",  method = POST, AmostragemSimplesController.process)

up(8001, async = false)