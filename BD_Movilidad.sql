------------------------------------------------------------------------------------------------------

Create Database Movilidad_Equipo3_Final1;

Use Movilidad_Equipo3_Final1

CREATE TABLE login(
    correo VARCHAR(50) PRIMARY KEY not null,
    contraseña VARCHAR(255)  
);

Create Table UNIVERSIDAD(
	No_Universidad varchar(7) primary key not null,
	NombreU varchar(100) not null,
	Estado varchar(30) not null,
	Pais varchar(40) not null
);

Create Table FACULTAD(
	ID_Facultad varchar(7) primary key not null,
	NombreF varchar(100) not null,
	No_Universidad varchar(7) not null,
	CONSTRAINT fk_No_UniversidadF 
        FOREIGN KEY (No_Universidad) 
        REFERENCES UNIVERSIDAD(No_Universidad)
);

Create Table CARRERA(
	ID_Carrera varchar(7) primary key not null,
	NombreC varchar(100) not null,
        Tem_Carrera varchar(30) not null,
	ID_FacultadC varchar(7) not null,
	CONSTRAINT fk_ID_FacultadC 
        FOREIGN KEY (ID_FacultadC) 
        REFERENCES FACULTAD(ID_Facultad)
);

Create Table DOCENTES(
	No_CuentaDocente varchar(7) Primary key not null,
        ContraseñaD varchar(10) not null,
	NombresD varchar(17) not null,
	P_ApellidoD varchar(15) not null,
	S_ApellidoD varchar(15) not null,
	ID_CarreraD varchar(7) not null,
    correo VARCHAR(50) not null, 
	CONSTRAINT fk_ID_CarreraD 
        FOREIGN KEY (ID_CarreraD) 
        REFERENCES CARRERA(ID_Carrera),
        CONSTRAINT fk_correo FOREIGN KEY (correo) REFERENCES login(correo)

); 

Create Table MATERIA(
	ID_Materia varchar(7) primary key not null,
	NombreM varchar(40) not null,
	T_Materia varchar(40) not null,
	ID_CarreraM varchar(7) not null,
    No_CuentaDocenteM VARCHAR(7) NOT NULL,
	CONSTRAINT fk_ID_CarreraM FOREIGN KEY (ID_CarreraM) REFERENCES CARRERA(ID_Carrera),
    CONSTRAINT fk_No_CuentaDocenteM FOREIGN KEY (No_CuentaDocenteM) REFERENCES DOCENTES(No_CuentaDocente)
);

CREATE TABLE MOVILIDAD (
    ID_Movilidad varchar(7) PRIMARY KEY NOT NULL,
    Ciclo_Escolar varchar(10) NOT NULL,
    Analisis_Movilidad int,
    Gastos VARCHAR(15) NOT NULL,
    Idioma VARCHAR(20), 
    Nivel_Idioma VARCHAR(3),
    NombresCE varchar(17) not null,
    P_ApellidoCE varchar(15) not null,
    S_ApellidoCE varchar(15) not null,
    Numero_ContactoEmergencia varchar(10) not null, 
    No_UniversidadM varchar(7) NOT NULL,
    ID_FacultadMo varchar(7) NOT NULL,
    ID_CarreraMo varchar(7) NOT NULL,
    No_CuentaDocenteMo varchar(7) NOT NULL,

    CONSTRAINT fk_No_UniversidadM 
        FOREIGN KEY (No_UniversidadM) 
        REFERENCES UNIVERSIDAD(No_Universidad),

    CONSTRAINT fk_ID_CarreraMo 
        FOREIGN KEY (ID_CarreraMo) 
        REFERENCES CARRERA(ID_Carrera),

    CONSTRAINT fk_No_CuentaDocenteMo 
        FOREIGN KEY (No_CuentaDocenteMo) 
        REFERENCES DOCENTES(No_CuentaDocente),

    CONSTRAINT fk_ID_FacultadMo
        FOREIGN KEY (ID_FacultadMo) 
        REFERENCES FACULTAD(ID_Facultad)
);

CREATE TABLE GRUPOS(
    id_grupo VARCHAR(7)  PRIMARY KEY not null,
    nombre_grupo VARCHAR(50),
    semestre INT,
    ID_Materia varchar(7) not null,
    CONSTRAINT fk_ID_Materia  FOREIGN KEY (ID_Materia) REFERENCES MATERIA(id_materia)
);

CREATE TABLE ADMINISTRADORES(
    matricula_admin VARCHAR(7) PRIMARY KEY,
    contraseña VARCHAR(30),
    NombresAd varchar(17) not null,
    P_ApellidoAd varchar(15) not null,
    S_ApellidoAd varchar(15) not null,
    correo VARCHAR(50),
    FOREIGN KEY (correo) REFERENCES login(correo)
);

Create Table Docente_Grupo(
        No_CuentaDocenteDG varchar(7) not null, 
        id_grupo VARCHAR(7) not null,
        PRIMARY KEY (No_CuentaDocenteDG, id_grupo),
        FOREIGN KEY (No_CuentaDocenteDG) REFERENCES DOCENTES(No_CuentaDocente),
        FOREIGN KEY (id_grupo) REFERENCES GRUPOS(id_grupo)
);



Create Table MATERIA_DOCENTE(
	No_CuentaDocenteMD varchar(7) not null,
	ID_MateriaMD varchar(7) not null,
	CONSTRAINT pk_MateriaDocente PRIMARY KEY (No_CuentaDocenteMD, ID_MateriaMD),
	CONSTRAINT fk_No_CuentaDocenteMD 
        FOREIGN KEY (No_CuentaDocenteMD) 
        REFERENCES DOCENTES(No_CuentaDocente),
	CONSTRAINT fk_ID_MateriaMD 
        FOREIGN KEY (ID_MateriaMD) 
        REFERENCES MATERIA(ID_Materia)

);

CREATE TABLE ESTUDIANTES(
    No_CuentaEstuudiante varchar(7) primary key NOT NULL,
    contraseñaE VARCHAR(10) not null,
    NombresE varchar(17) NOT NULL,
    P_ApellidoE varchar(15) NOT NULL,
    S_ApellidoE varchar(15) NOT NULL,
    Fecha_Nacimiento DATETIME,
    Domicilio VARCHAR(60) not null,
    Nacionalidad varchar(50) not null,
    Semestre int,
    Num_telefono varchar(10), 
    id_grupoE varchar(7) NOT NULL,
    id_CarreraE varchar(7) NOT NULL,
    correoE VARCHAR(50) not null,  

    CONSTRAINT fk_ID_CarreraE FOREIGN KEY (ID_CarreraE) REFERENCES CARRERA(ID_Carrera),
    CONSTRAINT fk_id_grupoE FOREIGN KEY (id_grupoE) REFERENCES GRUPOS(id_grupo),
    CONSTRAINT fk_correoE FOREIGN KEY (correoE) REFERENCES login(correo)

);

Create Table ESTUDIANTE_MOVILIDAD(
	No_CuentaEstuudianteEM varchar(7) not null,
	ID_MovilidadEM varchar(7) not null,
	CONSTRAINT pk_ESTUDIANTE_MOVILIDAD PRIMARY KEY (No_CuentaEstuudianteEM, ID_MovilidadEM),
	
        CONSTRAINT fk_No_CuentaEstuudianteEM FOREIGN KEY (No_CuentaEstuudianteEM) REFERENCES ESTUDIANTES(No_CuentaEstuudiante),
	
        CONSTRAINT fk_ID_MovilidadEM FOREIGN KEY (ID_MovilidadEM) REFERENCES MOVILIDAD(ID_Movilidad)
);

CREATE TABLE CALIFICACIONES(
    id_calificacion VARCHAR(7) PRIMARY KEY,
    parcial_uno NUMERIC (3,1),
    parcial_dos NUMERIC (3,1),
    parcial_tres NUMERIC (3,1),
    Calificaciones NUMERIC (3,1),
    No_CuentaEstuudiante varchar(7) NOT NULL,
    ID_MateriaC varchar(7) not null, 

    FOREIGN KEY (No_CuentaEstuudiante) REFERENCES ESTUDIANTES(No_CuentaEstuudiante),
    FOREIGN KEY (ID_MateriaC) REFERENCES MATERIA(ID_Materia)
);

Drop table CALIFICACIONES;


-- Inserciones en LOGIN (Admin, Docentes y Alumnos requeridos)
INSERT INTO login (correo, contraseña) VALUES 
('admin@movilidad.com', 'AdminSecure2026'),
('carlos.perez@docente.com', 'DocPerez1'),
('ana.martinez@docente.com', 'DocMart2'),
('luis.rodriguez@docente.com', 'DocRod3'),
('jorge.hernandez@docente.com', 'DocHern4'),
('elena.sanchez@docente.com', 'DocSanc5'),
('sofia.ramirez@docente.com', 'DocRam6'),
('roberto.gomez@docente.com', 'DocGom7'),
('laura.vargas@docente.com', 'DocVarg8'),
('ricardo.castro@docente.com', 'DocCast9'),
('patricia.flores@docente.com', 'DocFlor10'),
('fernando.morales@docente.com', 'DocMor11'),
('marta.herrera@docente.com', 'DocHerr12'),
('gabriel.medina@docente.com', 'DocMed13'),
('silvia.delgado@docente.com', 'DocDelg14'),
('hugo.benitez@docente.com', 'DocBeni15'),
('beatriz.ruiz@docente.com', 'DocRuiz16'),
('manuel.rubio@docente.com', 'DocRub17'),
('isabel.ochoa@docente.com', 'DocOch18'),
('andres.soto@docente.com', 'DocSoto19'),
('clara.valdez@docente.com', 'DocVald20'),
('javier.luna@docente.com', 'DocLuna21'),
('lucia.ramos@docente.com', 'DocRam22'),
('tomas.cervantes@docente.com', 'DocCerv23'),
('gloria.serrano@docente.com', 'DocSerr24'),
('luis.perez@estudiante.com', 'PassPerez6'),
('maria.rod@estudiante.com', 'PassRod6'),
('juan.perez@estudiante.com', 'PassJuan1'),
('maria.lopez@estudiante.com', 'PassMar3'),
('luis.rod.est@estudiante.com', 'PassLuis6'),
('david.gut@estudiante.com', 'PassDav4'),
('lucia.ram.est@estudiante.com', 'PassLuc5'),
('carlos.gonz@estudiante.com', 'PassCar8');

-- UNIVERSIDAD
INSERT INTO UNIVERSIDAD (No_Universidad, NombreU, Estado, Pais) VALUES 
('UNI001', 'Universidad de Colima', 'Colima', 'México'),
('UNI002', 'Instituto Tecnológico de Monterrey', 'Nuevo León', 'México'),
('UNI003', 'University of Texas at Austin', 'Texas', 'Estados Unidos'),
('UNI004', 'Universidad de Buenos Aires', 'Buenos Aires', 'Argentina'),
('UNI005', 'Universidad Complutense de Madrid', 'Madrid', 'España');

-- FACULTAD (Corregido 'UNI0001' a 'UNI001')
INSERT INTO FACULTAD (ID_Facultad, NombreF, No_Universidad) VALUES 
('FAC0001', 'Facultad de Ingeniería Mecanica Electrica', 'UNI001'),
('FAC0002', 'Facultad de Arquitectura y Diseño', 'UNI001'),
('FAC0003', 'Facultad de Ciencias Químicas', 'UNI001'),
('FAC0004', 'Facultad de Ingeniería Sistemas Electricos', 'UNI002'),
('FAC0005', 'Facultad de Química', 'UNI002'),
('FAC0006', 'Facultad de Mecatronica', 'UNI003'),
('FAC0007', 'Facultad de Diseño', 'UNI003'),
('FAC0008', 'Facultad de Arquitectura', 'UNI004'),
('FAC0009', 'Facultad de Ciencias Químicas', 'UNI004'),
('FAC0010', 'Facultad de Telematica', 'UNI005'),
('FAC0011', 'Facultad de Arquitectura y Diseño', 'UNI005');

-- CARRERA (Añadido el campo Tem_Carrera solicitado)
INSERT INTO CARRERA (ID_Carrera, NombreC, Tem_Carrera, ID_FacultadC) VALUES 
('CAR0001', 'Ingeniería en Computación', 'Programación y Redes', 'FAC0001'),
('CAR0002', 'Ingeniería Mecánica', 'Termodinámica y Fluidos', 'FAC0001'),
('CAR0003', 'Ingenieria Mecatronica', 'Robótica y Automatización', 'FAC0001'),
('CAR0004', 'Ingenieria Arquitectura', 'Diseño Estructural', 'FAC0002'),
('CAR0005', 'Ingenieria en Diseño Grafico', 'Tipografía e Ilustración', 'FAC0002'),
('CAR0006', 'Ingeniería en Quimica Biologa', 'Microbiología Molecular', 'FAC0003'),
('CAR0007', 'Ingeniería en Quimica de Alimentos', 'Control de Calidad Alimentaria', 'FAC0003'),
('CAR0008', 'Ingeniería en Computación', 'Sistemas de Información', 'FAC0004'),
('CAR0009', 'Ingeniería Mecánica', 'Sistemas de Manufactura', 'FAC0004'),
('CAR0010', 'Ingeniería en Quimica Biologa', 'Bioquímica Clínica', 'FAC0005'),
('CAR0011', 'Ingeniería en Metalurgica', 'Siderurgia Avanzada', 'FAC0005'),
('CAR0012', 'Ingenieria Mecatronica', 'Sistemas Embebidos', 'FAC0006'),
('CAR0013', 'Ingenieria en Informatica', 'Desarrollo Web y Servidores', 'FAC0006'),
('CAR0014', 'Ingenieria en Diseño Grafico', 'Comunicación Visual', 'FAC0007'),
('CAR0015', 'Ingenieria en Diseño Industrial', 'Modelado 3D y Ergonomía', 'FAC0007'),
('CAR0016', 'Ingenieria Arquitectura', 'Urbanismo y Edificación', 'FAC0008'),
('CAR0017', 'Ingeniería Topologia', 'Cartografía y Altimetría', 'FAC0008'),
('CAR0018', 'Ingeniería en Metalurgica', 'Propiedades de Materiales', 'FAC0009'),
('CAR0019', 'Ingeniería en Quimica Biologa', 'Análisis Químico', 'FAC0009'),
('CAR0020', 'Ingeniería en Computación', 'Arquitectura de Computadoras', 'FAC0010'),
('CAR0021', 'Ingeniería Mecánica', 'Dinámica de Sistemas', 'FAC0010'),
('CAR0022', 'Ingenieria Arquitectura', 'Conservación del Patrimonio', 'FAC0011'),
('CAR0023', 'Ingenieria en Diseño Grafico', 'Marketing Digital', 'FAC0011');

-- DOCENTES (Se incluyeron las columnas ContraseñaD y correo)
INSERT INTO DOCENTES (No_CuentaDocente, ContraseñaD, NombresD, P_ApellidoD, S_ApellidoD, ID_CarreraD, correo) VALUES 
('DOC0001', 'passDOC1', 'Carlos', 'Pérez', 'Gómez', 'CAR0001', 'carlos.perez@docente.com'),
('DOC0002', 'passDOC2', 'Ana', 'Martínez', 'López', 'CAR0001', 'ana.martinez@docente.com'),
('DOC0003', 'passDOC3', 'Luis', 'Rodríguez', 'Rubio', 'CAR0002', 'luis.rodriguez@docente.com'),
('DOC0004', 'passDOC4', 'Jorge', 'Hernández', 'Díaz', 'CAR0003', 'jorge.hernandez@docente.com'),
('DOC0005', 'passDOC5', 'Elena', 'Sánchez', 'Cruz', 'CAR0008', 'elena.sanchez@docente.com'),
('DOC0006', 'passDOC6', 'Sofía', 'Ramírez', 'Torres', 'CAR0013', 'sofia.ramirez@docente.com'),
('DOC0007', 'passDOC7', 'Roberto', 'Gómez', 'Marín', 'CAR0004', 'roberto.gomez@docente.com'),
('DOC0008', 'passDOC8', 'Laura', 'Vargas', 'Sanz', 'CAR0005', 'laura.vargas@docente.com'),
('DOC0009', 'passDOC9', 'Ricardo', 'Castro', 'Peña', 'CAR0006', 'ricardo.castro@docente.com'),
('DOC0010', 'passDOC10', 'Patricia', 'Flores', 'Ríos', 'CAR0007', 'patricia.flores@docente.com'),
('DOC0011', 'passDOC11', 'Fernando', 'Morales', 'Solís', 'CAR0009', 'fernando.morales@docente.com'),
('DOC0012', 'passDOC12', 'Marta', 'Herrera', 'Mora', 'CAR0010', 'marta.herrera@docente.com'),
('DOC0013', 'passDOC13', 'Gabriel', 'Medina', 'Navarro', 'CAR0011', 'gabriel.medina@docente.com'),
('DOC0014', 'passDOC14', 'Silvia', 'Delgado', 'Méndez', 'CAR0012', 'silvia.delgado@docente.com'),
('DOC0015', 'passDOC15', 'Hugo', 'Benítez', 'Cortés', 'CAR0014', 'hugo.benitez@docente.com'),
('DOC0016', 'passDOC16', 'Beatriz', 'Ruiz', 'Espinoza', 'CAR0015', 'beatriz.ruiz@docente.com'),
('DOC0017', 'passDOC17', 'Manuel', 'Rubio', 'Campos', 'CAR0016', 'manuel.rubio@docente.com'),
('DOC0018', 'passDOC18', 'Isabel', 'Ochoa', 'Lara', 'CAR0017', 'isabel.ochoa@docente.com'),
('DOC0019', 'passDOC19', 'Andrés', 'Soto', 'Villalba', 'CAR0018', 'andres.soto@docente.com'),
('DOC0020', 'passDOC20', 'Clara', 'Valdez', 'Ortega', 'CAR0019', 'clara.valdez@docente.com'),
('DOC0021', 'passDOC21', 'Javier', 'Luna', 'Guerra', 'CAR0020', 'javier.luna@docente.com'),
('DOC0022', 'passDOC22', 'Lucía', 'Ramos', 'Palacios', 'CAR0021', 'lucia.ramos@docente.com'),
('DOC0023', 'passDOC23', 'Tomás', 'Cervantes', 'Acosta', 'CAR0022', 'tomas.cervantes@docente.com'),
('DOC0024', 'passDOC24', 'Gloria', 'Serrano', 'Maldonado', 'CAR0023', 'gloria.serrano@docente.com');

-- MATERIA (Se añadió la columna del docente titular No_CuentaDocenteM)
INSERT INTO MATERIA (ID_Materia, NombreM, T_Materia, ID_CarreraM, No_CuentaDocenteM) VALUES 
('MAT0001', 'Programación Estructurada', 'Programación', 'CAR0001', 'DOC0001'),
('MAT0002', 'Bases de Datos', 'Sistemas de Información', 'CAR0001', 'DOC0001'),
('MAT0003', 'Termodinámica', 'Física Aplicada', 'CAR0002', 'DOC0003'),
('MAT0004', 'Mecánica de Fluidos', 'Diseño Mecánico', 'CAR0002', 'DOC0003'),
('MAT0005', 'Robótica Industrial', 'Automatización', 'CAR0003', 'DOC0004'),
('MAT0006', 'Microcontroladores', 'Sistemas Embebidos', 'CAR0003', 'DOC0004'),
('MAT0007', 'Diseño Arquitectónico', 'Construcción', 'CAR0004', 'DOC0007'),
('MAT0008', 'Estructuras de Concreto', 'Cálculo Civil', 'CAR0004', 'DOC0007'),
('MAT0019', 'Bioquímica', 'Química Orgánica', 'CAR0010', 'DOC0012'),
('MAT0020', 'Microbiología', 'Biología Celular', 'CAR0010', 'DOC0012'),
('MAT0039', 'Programación Estructurada', 'Programación', 'CAR0020', 'DOC0021'),
('MAT0040', 'Bases de Datos', 'Sistemas de Información', 'CAR0020', 'DOC0021'),
('MAT0041', 'Termodinámica', 'Física Aplicada', 'CAR0021', 'DOC0022');

-- GRUPOS (Se definieron códigos únicos de grupos vinculados a las materias y semestres)
INSERT INTO GRUPOS (id_grupo, nombre_grupo, semestre, ID_Materia) VALUES 
('GRP0001', 'Grupo 1-A Computación', 1, 'MAT0001'),
('GRP0002', 'Grupo 3-A Bases de Datos', 3, 'MAT0002'),
('GRP0003', 'Grupo 2-A Termodinámica', 2, 'MAT0003'),
('GRP0004', 'Grupo 4-A Fluidos', 4, 'MAT0004'),
('GRP0005', 'Grupo 5-A Robótica', 5, 'MAT0005'),
('GRP0006', 'Grupo 6-A Bioquímica', 6, 'MAT0019'),
('GRP0007', 'Grupo 6-B Computación B', 6, 'MAT0039');

-- ADMINISTRADORES
INSERT INTO ADMINISTRADORES (matricula_admin, contraseña, NombresAd, P_ApellidoAd, S_ApellidoAd, correo) VALUES 
('ADM0001', 'AdminSecure2026', 'Carlos', 'Gómez', 'López', 'admin@movilidad.com');

-- Docente_Grupo
INSERT INTO Docente_Grupo (No_CuentaDocenteDG, id_grupo) VALUES 
('DOC0001', 'GRP0001'),
('DOC0001', 'GRP0002'),
('DOC0003', 'GRP0003'),
('DOC0003', 'GRP0004'),
('DOC0004', 'GRP0005'),
('DOC0012', 'GRP0006'),
('DOC0021', 'GRP0007');

-- ESTUDIANTES (Completada con campos obligatorios conformes a la estructura CREATE TABLE)
INSERT INTO ESTUDIANTES (No_CuentaEstuudiante, contraseñaE, NombresE, P_ApellidoE, S_ApellidoE, Fecha_Nacimiento, Domicilio, Nacionalidad, Semestre, Num_telefono, id_grupoE, id_CarreraE, correoE) VALUES 
('EST0070', 'PassPerez6', 'Luis', 'Pérez', 'Pérez', '2004-05-14', 'Av. Universidad 333, Colima', 'Mexicana', 6, '3121112233', 'GRP0007', 'CAR0001', 'luis.perez@estudiante.com'),
('EST0071', 'PassRod6', 'María', 'Rodríguez', 'Pérez', '2004-09-20', 'Calle Carranza 45, Villa de Álvarez', 'Mexicana', 6, '3124445566', 'GRP0006', 'CAR0002', 'maria.rod@estudiante.com'),  
('EST0001', 'PassJuan1', 'Juan', 'Pérez', 'García', '2007-01-10', 'Hidalgo 12, Colima Centro', 'Mexicana', 1, '3127778899', 'GRP0001', 'CAR0001', 'juan.perez@estudiante.com'),
('EST0002', 'PassMar3', 'María', 'López', 'Martínez', '2005-11-22', 'Niños Héroes 78, Comala', 'Mexicana', 3, '3128889900', 'GRP0002', 'CAR0001', 'maria.lopez@estudiante.com'),
('EST0003', 'PassLuis6', 'Luis', 'Rodríguez', 'Sánchez', '2004-02-28', 'Madero 400, Villa de Álvarez', 'Mexicana', 6, '3129990011', 'GRP0007', 'CAR0001', 'luis.rod.est@estudiante.com'),
('EST0012', 'PassDav4', 'David', 'Gutiérrez', 'Navarro', '2005-04-03', 'San Fernando 120, Colima', 'Mexicana', 4, '3121234567', 'GRP0004', 'CAR0004', 'david.gut@estudiante.com'),
('EST0030', 'PassLuc5', 'Lucía', 'Ramos', 'Cortés', '2004-08-15', 'Benito Juárez 89, Colima', 'Mexicana', 5, '3127654321', 'GRP0006', 'CAR0010', 'lucia.ram.est@estudiante.com'),
('EST0006', 'PassCar8', 'Carlos', 'González', 'Cruz', '2002-12-05', 'Pino Suárez 210, Manzanillo', 'Mexicana', 8, '3149876543', 'GRP0004', 'CAR0002', 'carlos.gonz@estudiante.com');

-- MOVILIDAD (Estructurada completamente con datos válidos según sus indicaciones)
INSERT INTO MOVILIDAD (ID_Movilidad, Ciclo_Escolar, Analisis_Movilidad, Gastos, Idioma, Nivel_Idioma, NombresCE, P_ApellidoCE, S_ApellidoCE, Numero_ContactoEmergencia, No_UniversidadM, ID_FacultadMo, ID_CarreraMo, No_CuentaDocenteMo) VALUES 
('MOV0001', '2025-2', 1, 'Madre/Padre', 'Español', 'C2', 'Pedro', 'Gutiérrez', 'Silva', '3121592634', 'UNI004', 'FAC0008', 'CAR0016', 'DOC0007'),
('MOV0002', '2026-1', 2, 'Propios', 'Inglés', 'B2', 'Martha', 'Ramos', 'Luna', '3123571113', 'UNI003', 'FAC0006', 'CAR0006', 'DOC0004'),
('MOV0003', '2026-1', 1, 'Familiares', 'Español', 'C1', 'Jorge', 'González', 'Rubio', '3141112223', 'UNI005', 'FAC0011', 'CAR0021', 'DOC0022'),
('MOV0004', '2026-1', 1, 'Terceros', 'Inglés', 'C1', 'Alicia', 'Pérez', 'Soto', '3129998877', 'UNI005', 'FAC0010', 'CAR0020', 'DOC0021'),
('MOV0005', '2026-1', 1, 'Madre/Padre', 'Inglés', 'B2', 'Roberto', 'Rodríguez', 'Mora', '3128887766', 'UNI005', 'FAC0010', 'CAR0020', 'DOC0021');

-- ESTUDIANTE_MOVILIDAD
INSERT INTO ESTUDIANTE_MOVILIDAD (No_CuentaEstuudianteEM, ID_MovilidadEM) VALUES 
('EST0012', 'MOV0001'),
('EST0030', 'MOV0002'),
('EST0006', 'MOV0003'),
('EST0070', 'MOV0004'),
('EST0071', 'MOV0005');


-- CALIFICACIONES (Agregados los registros completos asociados a los alumnos activos)
INSERT INTO CALIFICACIONES (id_calificacion, parcial_uno, parcial_dos, parcial_tres, Calificaciones, No_CuentaEstuudiante, ID_MateriaC) VALUES 
('CAL0001', 9.5, 8.0, 9.0, 8.8, 'EST0001', 'MAT0001'),
('CAL0002', 8.5, 9.0, 9.5, 9.0, 'EST0002', 'MAT0002'),
('CAL0003', 7.0, 8.5, 8.0, 7.8, 'EST0003', 'MAT0001'),
('CAL0004', 10.0, 9.5, 9.0, 9.5, 'EST0070', 'MAT0001'),
('CAL0005', 9.0, 9.0, 8.5, 8.8, 'EST0071', 'MAT0001'),
('CAL0006', 8.0, 7.5, 9.0, 8.2, 'EST0012', 'MAT0003'),
('CAL0007', 9.5, 10.0, 9.0, 9.5, 'EST0030', 'MAT0019');



SELECT * FROM login;
SELECT * FROM UNIVERSIDAD;
SELECT * FROM FACULTAD;
SELECT * FROM CARRERA;
SELECT * FROM DOCENTES;
SELECT * FROM MATERIA;
SELECT * FROM GRUPOS;
SELECT * FROM ADMINISTRADORES;
SELECT * FROM Docente_Grupo;
SELECT * FROM ESTUDIANTES;
SELECT * FROM MOVILIDAD;
SELECT * FROM ESTUDIANTE_MOVILIDAD;
SELECT * FROM MATERIAESTUDIANTE;
SELECT * FROM CALIFICACIONES;













