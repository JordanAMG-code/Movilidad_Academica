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
            window.location.href = "ExplorarConvoca.html";
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

// =========================================================
// FUNCIONES PARA EXPLORAR CONVOCATORIAS
// =========================================================

function cargarConvocatorias() {
    fetch('http://localhost:3000/api/convocatorias')
        .then(res => res.json())
        .then(respuesta => {
            if (!respuesta.exito) return;

            const datos = respuesta.datos;
            const contenedor = document.getElementById('contenedor-convocatorias');
            contenedor.innerHTML = ''; // Limpiamos antes de cargar

            // 1. Agrupar los datos (porque una carrera trae varias filas de materias)
            const carrerasAgrupadas = {};
            datos.forEach(fila => {
                // Creamos una clave única usando la carrera y la universidad
                const idUnico = fila.Nombre_Carrera + '-' + fila.Nombre_Universidad;
                
                if (!carrerasAgrupadas[idUnico]) {
                    carrerasAgrupadas[idUnico] = {
                        carrera: fila.Nombre_Carrera,
                        temasCarrera: fila.Temas_Carrera,
                        facultad: fila.Nombre_Facultad,
                        universidad: fila.Nombre_Universidad,
                        pais: fila.Pais_Universidad,
                        estado: fila.Estado_Universidad,
                        materias: []
                    };
                }
                // Si hay una materia, la agregamos al arreglo
                if (fila.Nombre_Materia) {
                    carrerasAgrupadas[idUnico].materias.push({
                        nombre: fila.Nombre_Materia,
                        temas: fila.Temas_Materia
                    });
                }
            });

            // 2. Diccionario de banderas (Ajusta los nombres de tus imágenes aquí)
            const banderas = {
                'México': 'Carpetadeimagenes/mxBandera.png',
                'Canadá': 'canada.png',
                'Italia': 'italia.png',
                'Colombia': 'colombia.png',
                'Japón': 'japon.png',
                'Filipinas': 'filipinas.png',
                'Argentina': 'Bandera_Argentina.jpg',
                'España': 'Bandera_Espania.jpg'
                //Estados Unidos
                //Argentina Bandera_Espania
                
            };

            // 3. Generar el HTML para cada tarjeta
let index = 0;
// Definimos el diccionario una sola vez
const mapaBanderas = {
    'México': 'Carpetadeimagenes/mxBandera.png',
    'Canadá': 'Carpetadeimagenes/Flag_of_Canada.png',
    'Italia': 'Carpetadeimagenes/Bandera-Italia.jpg',
    'Colombia': 'Carpetadeimagenes/BanderaColombia.jpg',
    'Japón': 'Carpetadeimagenes/JaponBandera.png',
    'Filipinas': 'Carpetadeimagenes/flagPhilippinas.jpg',
    'Argentina': 'Carpetadeimagenes/Bandera_Argentina.jpg',
    'España': 'Carpetadeimagenes/Bandera_Espania.jpg'
    //Carpetadeimagenes/brasilBandera.png
    //Carpetadeimagenes/ChinaBandera.jpg
};

for (const key in carrerasAgrupadas) {
    const info = carrerasAgrupadas[key];
    const idDetalle = `detalle-${index}`;
    
    // Obtenemos la ruta, si no existe ponemos una por defecto
    const imagenBandera = mapaBanderas[info.pais] || 'Carpetadeimagenes/default.png';

    // Lista de materias en formato HTML
    const listaMateriasHTML = info.materias.map(m => 
        `<li><strong>${m.nombre}</strong> <br><small>Temas: ${m.temas}</small></li>`
    ).join('');

    const tarjeta = `
        <div style="background: #e8f5e9; border: 2px solid #cddc39; border-radius: 8px; width: 80%; padding: 15px; cursor: pointer; box-shadow: 0 4px 6px rgba(0,0,0,0.1); margin-bottom: 10px;" onclick="toggleDetalles('${idDetalle}')">
            <div style="display: flex; align-items: center; gap: 20px;">
                <img src="${imagenBandera}" alt="Bandera ${info.pais}" style="width: 100px; border: 1px solid #ccc;">
                <div>
                    <h3 style="margin: 0; color: #2e7d32;">${info.carrera}</h3>
                    <p style="margin: 5px 0 0 0; font-size: 1.1rem;"><strong>${info.universidad}</strong> - ${info.pais}</p>
                </div>
            </div>

            <div id="${idDetalle}" style="display: none; margin-top: 15px; padding-top: 15px; border-top: 1px solid #2e7d32;">
                <p><strong>Facultad:</strong> ${info.facultad}</p>
                <p><strong>Ubicación:</strong> ${info.estado}, ${info.pais}</p>
                <p><strong>Enfoque de la Carrera:</strong> ${info.temasCarrera}</p>
                
                <h4 style="margin-bottom: 5px; color: #1b5e20;">Materias Disponibles:</h4>
                <ul style="margin-top: 0;">
                    ${listaMateriasHTML || '<li>No hay materias registradas aún.</li>'}
                </ul>
            </div>
        </div>
    `;
    contenedor.innerHTML += tarjeta;
    index++;
}
        })
        .catch(error => console.error("Error al cargar datos:", error));
}

// Función para mostrar/ocultar el panel de detalles al darle clic
function toggleDetalles(id) {
    const panel = document.getElementById(id);
    if (panel.style.display === "none") {
        panel.style.display = "block";
    } else {
        panel.style.display = "none";
    }
}

// Ejecutar automáticamente si estamos en la página de Explorar
document.addEventListener('DOMContentLoaded', () => {
    if (document.getElementById('contenedor-convocatorias')) {
        cargarConvocatorias();
    }
});

