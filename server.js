const express = require('express');
const mysql = require('mysql2');
const path = require('path');
const app = express();

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