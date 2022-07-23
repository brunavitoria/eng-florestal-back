using Genie, Genie.Router
using Genie.Renderer, Genie.Renderer.Html, Genie.Renderer.Json

include("./controllers/amostragem_simples.jl"); 
using .AmostragemSimplesController;

include("./controllers/amostragem_estratificada.jl"); 
using .AmostragemEstratificadaController;

include("./controllers/amostragem_independente.jl"); 
using .AmostragemIndependenteController;

include("./controllers/amostragem_mult_inic_alea.jl"); 
using .AmostragemMultiplosIniciosAleatoriosController;


route("/amostragem-simples", AmostragemSimplesController.process)
route("/amostragem-estratificada", AmostragemEstratificadaController.process)
route("/amostragem-independente", AmostragemIndependenteController.process)
route("/amostragem-sistematica-com-multiplos-inicios-aleatorios", AmostragemMultiplosIniciosAleatoriosController.process)

up(8001, async = false)