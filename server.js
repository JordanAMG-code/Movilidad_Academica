const express = require('express');
const mysql = require('mysql2');
const path = require('path');
const app = express();
// 1. Mandamos a llamar la nueva librería
const session = require('express-session'); 

// 2. Configuramos la sesión (cópialo justo aquí, antes de tus rutas)
app.use(session({
    secret: 'secreto_movilidad_equipo3', // Una contraseña interna para encriptar
    resave: false,
    saveUninitialized: false,
    cookie: { 
        secure: false, // Ponemos false porque estamos en localhost sin https
        maxAge: 1000 * 60 * 60 * 2 // La sesión durará 2 horas
    }
}));

// Configuración para recibir datos de futuros formularios HTML
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Compartir de forma pública tu HTML, CSS y JS de la carpeta actual
app.use(express.static(__dirname));

// 1. Conexión a la base de datos de XAMPP
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', // XAMPP viene vacío por defecto
    database: 'Movilidad_Equipo3_Final1' // Tu base de datos principal
});

// Probar la conexión a MySQL
db.connect((err) => {
    if (err) {
        console.error('Error conectando a SQL: ' + err.stack);
        return;
    }
    console.log('¡Conectado exitosamente a la base de datos Movilidad_Equipo3_Final1!');
});

// Iniciar el servidor en el puerto 3000
app.listen(3000, () => {
    console.log('Servidor corriendo en http://localhost:3000');
});

// Ruta para procesar el inicio de sesión
app.post('/login', (req, res) => {
    const correo = req.body.correo;
    const contrasena = req.body.contrasena;

    // Tu consulta SQL actualizada
    const consultaSQL = `
        SELECT 
            l.correo,
            CASE 
                WHEN e.correoE IS NOT NULL THEN 'Estudiante'
                WHEN d.correo IS NOT NULL THEN 'Docente'
                WHEN a.correo IS NOT NULL THEN 'Administrador'
                ELSE 'Usuario sin rol asignado'
            END AS Tipo_Usuario,
            CASE 
                WHEN e.correoE IS NOT NULL THEN e.No_CuentaEstuudiante
                WHEN d.correo IS NOT NULL THEN d.No_CuentaDocente
                WHEN a.correo IS NOT NULL THEN a.matricula_admin
                ELSE NULL
            END AS Identificador_ID,
            CASE 
                WHEN e.correoE IS NOT NULL THEN e.NombresE
                WHEN d.correo IS NOT NULL THEN d.NombresD
                WHEN a.correo IS NOT NULL THEN a.NombresAd
                ELSE NULL
            END AS Nombre_Usuario
        FROM login l
        LEFT JOIN ESTUDIANTES e ON l.correo = e.correoE
        LEFT JOIN DOCENTES d ON l.correo = d.correo
        LEFT JOIN ADMINISTRADORES a ON l.correo = a.correo
        WHERE l.correo = ? AND l.contraseña = ?
    `;
    
    db.query(consultaSQL, [correo, contrasena], (error, resultados) => {
        if (error) {
            console.error("Error al consultar la base de datos:", error);
            return res.status(500).json({ exito: false, mensaje: "Error interno" });
        }

        if (resultados.length > 0) {
            const usuario = resultados[0];
            
            // Guardamos todos tus nuevos datos en la sesión
            req.session.usuarioActual = usuario.correo;
            req.session.rolUsuario = usuario.Tipo_Usuario;
            req.session.nombreUsuario = usuario.Nombre_Usuario;
            req.session.idUsuario = usuario.Identificador_ID;
            
            res.json({ exito: true, rol: usuario.Tipo_Usuario, mensaje: "Acceso concedido" });
        } else {
            res.json({ exito: false, mensaje: "Credenciales inválidas" });
        }
    });
});

/* Ruta para procesar el inicio de sesión
app.post('/login', (req, res) => {
    // Recibimos los datos que mandó el Frontend
    const correo = req.body.correo;
    const contrasena = req.body.contrasena;

    // Preparamos la consulta SQL
    const consultaSQL = "SELECT * FROM login WHERE correo = ? AND contraseña = ?";
    
    // Ejecutamos la búsqueda en la base de datos
    db.query(consultaSQL, [correo, contrasena], (error, resultados) => {
        if (error) {
            console.error("Error al consultar la base de datos:", error);
            return res.status(500).json({ exito: false, mensaje: "Error interno del servidor" });
        }

        // Si el arreglo 'resultados' tiene datos, el usuario existe y la contraseña es correcta
        if (resultados.length > 0) {
            res.json({ exito: true, mensaje: "Acceso concedido" });
        } else {
            // Si el arreglo está vacío, las credenciales no coinciden
            res.json({ exito: false, mensaje: "Credenciales inválidas" });
        }
    });
});*/


// Ruta actualizada para enviar el nombre y el ID
app.get('/api/usuario-actual', (req, res) => {
    if (req.session.usuarioActual) {
        res.json({ 
            conectado: true, 
            correo: req.session.usuarioActual, 
            rol: req.session.rolUsuario,
            nombre: req.session.nombreUsuario,    // Nuevo dato
            identificador: req.session.idUsuario  // Nuevo dato
        });
    } else {
        res.json({ conectado: false });
    }
});

// Nueva ruta para destruir la sesión
app.post('/api/logout', (req, res) => {
    // Destruye la memoria de la sesión
    req.session.destroy(err => {
        if (err) {
            return res.status(500).json({ exito: false, mensaje: "Error al cerrar sesión" });
        }
        res.clearCookie('connect.sid'); // Limpia la cookie del navegador
        res.json({ exito: true, mensaje: "Sesión cerrada correctamente" });
    });
});

// Ruta para obtener todas las carreras de movilidad
app.get('/api/convocatorias', (req, res) => {
    const sql = `
        SELECT 
            c.NombreC AS Nombre_Carrera,
            c.Tem_Carrera AS Temas_Carrera,
            f.NombreF AS Nombre_Facultad,
            u.NombreU AS Nombre_Universidad,
            u.Pais AS Pais_Universidad,
            u.Estado AS Estado_Universidad,
            m.NombreM AS Nombre_Materia,
            m.T_Materia AS Temas_Materia
        FROM CARRERA c
        INNER JOIN FACULTAD f ON c.ID_FacultadC = f.ID_Facultad
        INNER JOIN UNIVERSIDAD u ON f.No_Universidad = u.No_Universidad
        LEFT JOIN MATERIA m ON c.ID_Carrera = m.ID_CarreraM
        WHERE c.ID_Carrera IN (SELECT ID_CarreraMo FROM MOVILIDAD)
    `;

    db.query(sql, (error, resultados) => {
        if (error) {
            console.error("Error al consultar convocatorias:", error);
            return res.status(500).json({ exito: false, mensaje: "Error en la base de datos" });
        }
        res.json({ exito: true, datos: resultados });
    });
});