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
            // Reemplazamos la ruta por el link externo
            window.location.href = "https://www.ucol.mx/";
    });
}
/*===========================Inicio de Estudiante=======================//
    const botonInicioEstudiante = document.getElementById("BotonIngresar");
    if (botonInicioEstudiante) {
        botonInicioEstudiante.addEventListener("click", () => {
            window.location.href = "MenuOpciones.html";
        });
    }*/
//===========================Inicio de Estudiante=======================//
    const botonInicioEstudiante = document.getElementById("BotonIngresar");
    if (botonInicioEstudiante) {
        botonInicioEstudiante.addEventListener("click", async () => {
            // 1. Atrapamos lo que el usuario escribió en las cajas de texto
            const correoIngresado = document.getElementById("correo").value;
            const contrasenaIngresada = document.getElementById("contrasena").value;

            // 2. Validamos que no envíen el formulario vacío
            if (!correoIngresado || !contrasenaIngresada) {
                alert("Por favor, llena todos los campos antes de ingresar.");
                return;
            }

            try {
                // 3. Enviamos los datos al servidor (Node.js)
                const respuesta = await fetch('http://localhost:3000/login', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ correo: correoIngresado, contrasena: contrasenaIngresada })
                });

                // 4. Recibimos la respuesta del servidor
                const resultado = await respuesta.json();

                if (resultado.exito) {
                    // Redirección basada en el Tipo_Usuario que mandó tu SQL
                    switch(resultado.rol) {
                        case 'Estudiante':
                            window.location.href = "MenuOpciones.html";
                            break;
                        case 'Docente':
                            window.location.href = "Docente.html";
                            break;
                        case 'Administrador':
                            window.location.href = "Administrador.html";
                            break;
                        default:
                            alert("Aviso: " + resultado.rol);
                    }
                } else {
                    alert("Usuario o contraseña incorrectos. Verifica tus datos.");
                }

            } catch (error) {
                console.error("Error al conectar con el servidor:", error);
                alert("Hubo un problema de conexión con la base de datos.");
            }
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

//==========================================================================//
// NUEVAS FUNCIONES: SESIÓN Y PERFIL (Pegar al final del archivo)
//==========================================================================//

// 1. Función para pedir y mostrar los datos del usuario
function cargarDatosUsuario() {
    fetch('http://localhost:3000/api/usuario-actual')
        .then(respuesta => respuesta.json())
        .then(datos => {
            if (datos.conectado) {
                // Inyectamos los datos en el HTML
                document.getElementById('display-nombre').textContent = datos.nombre;
                document.getElementById('display-id').textContent = datos.identificador;
            } else {
                // Si no hay sesión, regresamos al inicio
                alert("Debes iniciar sesión primero");
                window.location.href = 'Inicio.html'; 
            }
        })
        .catch(error => console.error("Error al cargar usuario:", error));
}

// 2. Función para cerrar la sesión
function cerrarSesion() {
    fetch('http://localhost:3000/api/logout', {
        method: 'POST'
    })
    .then(respuesta => respuesta.json())
    .then(datos => {
        if (datos.exito) {
            window.location.href = 'Inicio.html';
        }
    })
    .catch(error => console.error("Error al cerrar sesión:", error));
}

// 3. Ejecutar la carga de datos SOLO si la página tiene el panel de perfil
document.addEventListener('DOMContentLoaded', () => {
    if (document.getElementById('display-nombre')) {
        cargarDatosUsuario();
    }
});

