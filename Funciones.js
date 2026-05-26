// Esperamos a que el DOM (el HTML) esté completamente cargado
document.addEventListener("DOMContentLoaded", () => {
//================================Inicio==============================//
    const botonEstudiante = document.getElementById("BotonEstudiante");
    if (botonEstudiante) {
        botonEstudiante.addEventListener("click", () => {
            window.location.href = "InicioEstudiante.html";
        });
    }
    
    const botonVisitante = document.getElementById("BotonVisitante");
    if (botonVisitante) {
        botonVisitante.addEventListener("click", () => {
            window.location.href = "ExplorarConvoca.html"

        })
    }
//===========================Inicio de Estudiante=======================//
    const botonInicioEstudiante = document.getElementById("BotonIngresar");
    if (botonInicioEstudiante) {
        botonInicioEstudiante.addEventListener("click", () => {
            window.location.href = "MenuOpciones.html";
        });
    }
//=============================Menú de opciones==========================//
    // Seleccionamos el botón por su ID
    const botonConvocatorias = document.getElementById("btn-explorar");

    // Verificamos que el botón exista en la página actual para evitar errores
    if (botonConvocatorias) {
        botonConvocatorias.addEventListener("click", () => {
            // Redirigimos al archivo de convocatorias
            window.location.href = "ExplorarConvoca.html";
        });
    }

    const botonsolicitud = document.getElementById("btn-explorar1");


    if (botonsolicitud) {
        botonsolicitud.addEventListener("click", () => {
            // Redirigimos al archivo de convocatorias
            window.location.href = "Solicitud.html";
        });
    }

    const botoncontrol = document.getElementById("btn-explorar2");

    if (botoncontrol) {
        botoncontrol.addEventListener("click", () => {
            window.location.href = "ControlSeguimiento.html";
        });
    }


});
