using Genie, Genie.Router
using Genie.Renderer, Genie.Renderer.Html, Genie.Renderer.Json

include("./controllers/amostragem_simples.jl"); 
using .AmostragemSimplesController;

<<<<<<< HEAD
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
=======
route("/amostragem-simples",  method = POST, AmostragemSimplesController.process)
>>>>>>> 18c3e61f2315ffe3a9708bdf40a1d20767348ba9

up(8001, async = false)