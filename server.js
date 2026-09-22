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

// ========================================================
// RUTAS PARA EL PANEL DE ADMINISTRADOR
// ========================================================

// 1. Obtener métricas (Conteo de alumnos y docentes)
app.get('/api/metricas', (req, res) => {
    const sql = `
        SELECT 
            (SELECT COUNT(*) FROM ESTUDIANTES) AS Total_Estudiantes,
            (SELECT COUNT(*) FROM DOCENTES) AS Total_Docentes
    `;
    db.query(sql, (error, resultados) => {
        if (error) return res.status(500).json({ exito: false, mensaje: "Error en BD" });
        res.json(resultados[0]);
    });
});

// 2. Obtener lista de Alumnos

// ==========================================
// RUTA: OBTENER DOCENTES
// ==========================================
/*app.get('/api/docentes', async (req, res) => {
    try {
        const pool = await poolPromise; 
        const query = `
            SELECT 
                d.No_CuentaDocente,
                d.NombresD AS Nombre_Docente,
                c.NombreC AS Carrera,
                f.NombreF AS Facultad,
                u.NombreU AS Universidad
            FROM DOCENTES d
            INNER JOIN CARRERA c ON d.ID_CarreraD = c.ID_Carrera
            INNER JOIN FACULTAD f ON c.ID_FacultadC = f.ID_Facultad
            INNER JOIN UNIVERSIDAD u ON f.No_Universidad = u.No_Universidad;
        `;
        const result = await pool.request().query(query);
        res.json(result.recordset);
    } catch (err) {
        console.error("Error en SQL Docentes:", err);
        res.status(500).send('Error al obtener docentes');
    }
});*/

app.get('/api/docentes', (req, res) => {
    const query = `
            SELECT 
                d.No_CuentaDocente,
                d.NombresD AS Nombre_Docente,
                c.NombreC AS Carrera,
                f.NombreF AS Facultad,
                u.NombreU AS Universidad
            FROM DOCENTES d
            INNER JOIN CARRERA c ON d.ID_CarreraD = c.ID_Carrera
            INNER JOIN FACULTAD f ON c.ID_FacultadC = f.ID_Facultad
            INNER JOIN UNIVERSIDAD u ON f.No_Universidad = u.No_Universidad;
        `;

    db.query(query, (err, results) => {
        if (err) {
            console.error('Error en SQL Docentes:', err);
            return res.status(500).json({ error: 'Error al obtener docentes' });
        }
        res.json(results);
    });
});

// ==========================================
// RUTA: OBTENER ALUMNOS (CON TODOS LOS CAMPOS)
// ==========================================
/*app.get('/api/alumnos', async (req, res) => {
    try {
        const pool = await poolPromise; 
        const query = `
            SELECT 
                e.No_CuentaEstuudiante,
                CONCAT(e.NombresE, ' ', e.P_ApellidoE, ' ', e.S_ApellidoE) AS Nombre_Completo,
                e.Domicilio,
                e.Nacionalidad,
                e.Semestre,
                e.Num_telefono AS No_Telefono,
                g.nombre_grupo AS Grupo,
                c_orig.NombreC AS Carrera_Origen,
                f_orig.NombreF AS Facultad_Origen,
                u_orig.NombreU AS Universidad_Origen,
                m.ID_Movilidad,
                m.Ciclo_Escolar,
                m.Analisis_Movilidad,
                m.Gastos,
                m.Idioma,
                m.Nivel_Idioma,
                CONCAT(m.NombresCE, ' ', m.P_ApellidoCE, ' ', m.S_ApellidoCE) AS Nombre_Contacto_Emergencia,
                m.Numero_ContactoEmergencia,
                u_dest.NombreU AS Universidad_Movilidad,
                f_dest.NombreF AS Facultad_Movilidad,
                c_dest.NombreC AS Carrera_Movilidad,
                cal.Calificaciones AS Calificacion_Total
            FROM ESTUDIANTES e
            INNER JOIN GRUPOS g ON e.id_grupoE = g.id_grupo
            INNER JOIN CARRERA c_orig ON e.id_CarreraE = c_orig.ID_Carrera
            INNER JOIN FACULTAD f_orig ON c_orig.ID_FacultadC = f_orig.ID_Facultad
            INNER JOIN UNIVERSIDAD u_orig ON f_orig.No_Universidad = u_orig.No_Universidad
            LEFT JOIN ESTUDIANTE_MOVILIDAD em ON e.No_CuentaEstuudiante = em.No_CuentaEstuudianteEM
            LEFT JOIN MOVILIDAD m ON em.ID_MovilidadEM = m.ID_Movilidad
            LEFT JOIN UNIVERSIDAD u_dest ON m.No_UniversidadM = u_dest.No_Universidad
            LEFT JOIN FACULTAD f_dest ON m.ID_FacultadMo = f_dest.ID_Facultad
            LEFT JOIN CARRERA c_dest ON m.ID_CarreraMo = c_dest.ID_Carrera
            LEFT JOIN CALIFICACIONES cal ON e.No_CuentaEstuudiante = cal.No_CuentaEstuudiante;
        `;
        const result = await pool.request().query(query);
        res.json(result.recordset);
    } catch (err) {
        console.error("Error en SQL Alumnos:", err);
        res.status(500).send('Error al obtener alumnos');
    }
});*/

app.get('/api/alumnos', (req, res) => {
    const query = `
            SELECT 
                e.No_CuentaEstuudiante,
                CONCAT(e.NombresE, ' ', e.P_ApellidoE, ' ', e.S_ApellidoE) AS Nombre_Completo,
                e.Domicilio,
                e.Nacionalidad,
                e.Semestre,
                e.Num_telefono AS No_Telefono,
                g.nombre_grupo AS Grupo,
                c_orig.NombreC AS Carrera_Origen,
                f_orig.NombreF AS Facultad_Origen,
                u_orig.NombreU AS Universidad_Origen,
                m.ID_Movilidad,
                m.Ciclo_Escolar,
                m.Analisis_Movilidad,
                m.Gastos,
                m.Idioma,
                m.Nivel_Idioma,
                CONCAT(m.NombresCE, ' ', m.P_ApellidoCE, ' ', m.S_ApellidoCE) AS Nombre_Contacto_Emergencia,
                m.Numero_ContactoEmergencia,
                u_dest.NombreU AS Universidad_Movilidad,
                f_dest.NombreF AS Facultad_Movilidad,
                c_dest.NombreC AS Carrera_Movilidad,
                cal.Calificaciones AS Calificacion_Total
            FROM ESTUDIANTES e
            INNER JOIN GRUPOS g ON e.id_grupoE = g.id_grupo
            INNER JOIN CARRERA c_orig ON e.id_CarreraE = c_orig.ID_Carrera
            INNER JOIN FACULTAD f_orig ON c_orig.ID_FacultadC = f_orig.ID_Facultad
            INNER JOIN UNIVERSIDAD u_orig ON f_orig.No_Universidad = u_orig.No_Universidad
            LEFT JOIN ESTUDIANTE_MOVILIDAD em ON e.No_CuentaEstuudiante = em.No_CuentaEstuudianteEM
            LEFT JOIN MOVILIDAD m ON em.ID_MovilidadEM = m.ID_Movilidad
            LEFT JOIN UNIVERSIDAD u_dest ON m.No_UniversidadM = u_dest.No_Universidad
            LEFT JOIN FACULTAD f_dest ON m.ID_FacultadMo = f_dest.ID_Facultad
            LEFT JOIN CARRERA c_dest ON m.ID_CarreraMo = c_dest.ID_Carrera
            LEFT JOIN CALIFICACIONES cal ON e.No_CuentaEstuudiante = cal.No_CuentaEstuudiante;
        `;

    db.query(query, (err, results) => {
        if (err) {
            console.error('Error en SQL Alumnos:', err);
            return res.status(500).json({ error: 'Error al obtener alumnos' });
        }
        res.json(results);
    });
});

// ========================================================
// FUNCIONALIDAD: AGREGAR Y ELIMINAR ALUMNOS
// ========================================================

// ========================================================
// FUNCIONALIDAD: AGREGAR ALUMNOS (TRANSACCIÓN)
// ========================================================
app.post('/api/alumnos', (req, res) => {
    const { 
        correo, contrasena, no_cuenta, contrasenaE, nombres, p_apellido, s_apellido, 
        fecha_nacimiento, domicilio, nacionalidad, semestre, telefono, id_grupo, 
        id_carrera, id_movilidad, id_calificacion, id_materia 
    } = req.body;

    db.beginTransaction(err => {
        if (err) return res.status(500).json({ exito: false, mensaje: "Error al iniciar" });

        db.query(`INSERT INTO login (correo, contraseña) VALUES (?, ?)`, [correo, contrasena], (err) => {
            if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));

            const sqlEst = `INSERT INTO ESTUDIANTES (No_CuentaEstuudiante, contraseñaE, NombresE, P_ApellidoE, S_ApellidoE, Fecha_Nacimiento, Domicilio, Nacionalidad, Semestre, Num_telefono, id_grupoE, id_CarreraE, correoE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
            db.query(sqlEst, [no_cuenta, contrasenaE, nombres, p_apellido, s_apellido, fecha_nacimiento, domicilio, nacionalidad, semestre, telefono, id_grupo, id_carrera, correo], (err) => {
                if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));

                db.query(`INSERT INTO ESTUDIANTE_MOVILIDAD (No_CuentaEstuudianteEM, ID_MovilidadEM) VALUES (?, ?)`, [no_cuenta, id_movilidad], (err) => {
                    if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));

                    db.query(`INSERT INTO CALIFICACIONES (id_calificacion, parcial_uno, parcial_dos, parcial_tres, Calificaciones, No_CuentaEstuudiante, ID_MateriaC) VALUES (?, 0, 0, 0, 0, ?, ?)`, [id_calificacion, no_cuenta, id_materia], (err) => {
                        if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));

                        db.commit(err => {
                            if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));
                            res.json({ exito: true, mensaje: "Alumno guardado" });
                        });
                    });
                });
            });
        });
    });
});

// Eliminar Alumno
app.delete('/api/alumnos/:id', (req, res) => {
    const idAlumno = req.params.id;
    const sql = 'DELETE FROM ESTUDIANTES WHERE No_CuentaEstuudiante = ?';

    db.query(sql, [idAlumno], (err, result) => {
        if (err) {
            console.error("Error al eliminar alumno:", err);
            return res.status(500).json({ exito: false, mensaje: "No se pudo eliminar. Verifica si tiene una movilidad asignada." });
        }
        res.json({ exito: true, mensaje: "Alumno eliminado correctamente" });
    });
});


// ========================================================
// FUNCIONALIDAD: AGREGAR Y ELIMINAR DOCENTES
// ========================================================

// ========================================================
// FUNCIONALIDAD: AGREGAR DOCENTES (TRANSACCIÓN)
// ========================================================
app.post('/api/docentes', (req, res) => {
    const { 
        correo, contrasena, no_cuenta, contrasenaD, nombres, p_apellido, s_apellido, 
        id_carrera, id_materia, nombre_materia, tipo_materia, id_grupo 
    } = req.body;

    db.beginTransaction(err => {
        if (err) return res.status(500).json({ exito: false, mensaje: "Error al iniciar" });

        db.query(`INSERT INTO login (correo, contraseña) VALUES (?, ?)`, [correo, contrasena], (err) => {
            if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));

            const sqlDoc = `INSERT INTO DOCENTES (No_CuentaDocente, ContraseñaD, NombresD, P_ApellidoD, S_ApellidoD, ID_CarreraD, correo) VALUES (?, ?, ?, ?, ?, ?, ?)`;
            db.query(sqlDoc, [no_cuenta, contrasenaD, nombres, p_apellido, s_apellido, id_carrera, correo], (err) => {
                if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));

                const sqlMat = `INSERT INTO MATERIA (ID_Materia, NombreM, T_Materia, ID_CarreraM, No_CuentaDocenteM) VALUES (?, ?, ?, ?, ?)`;
                db.query(sqlMat, [id_materia, nombre_materia, tipo_materia, id_carrera, no_cuenta], (err) => {
                    if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));

                    db.query(`INSERT INTO Docente_Grupo (No_CuentaDocenteDG, id_grupo) VALUES (?, ?)`, [no_cuenta, id_grupo], (err) => {
                        if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));

                        db.query(`INSERT INTO MATERIA_DOCENTE (No_CuentaDocenteMD, ID_MateriaMD) VALUES (?, ?)`, [no_cuenta, id_materia], (err) => {
                            if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));

                            db.commit(err => {
                                if (err) return db.rollback(() => res.status(500).json({ exito: false, error: err.message }));
                                res.json({ exito: true, mensaje: "Docente guardado" });
                            });
                        });
                    });
                });
            });
        });
    });
});

// Eliminar Docente
app.delete('/api/docentes/:id', (req, res) => {
    const idDocente = req.params.id;
    const sql = 'DELETE FROM DOCENTES WHERE No_CuentaDocente = ?';

    db.query(sql, [idDocente], (err, result) => {
        if (err) {
            console.error("Error al eliminar docente:", err);
            return res.status(500).json({ exito: false, mensaje: "Error al eliminar el docente" });
        }
        res.json({ exito: true, mensaje: "Docente eliminado correctamente" });
    });
});

