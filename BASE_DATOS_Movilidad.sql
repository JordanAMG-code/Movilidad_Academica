Create Database Movilidad_E3_F

Use Movilidad_E3_F;

Create Table ESTUDIANTES(
	No_CuentaE varchar(7) Primary key not null,
	Nombres varchar(17) not null,
	P_Apellido varchar(15) not null,
	S_Apellido varchar(15) not null,
	Semestre int,
	Grupo varchar(1) not null,
	ID_Movilidad varchar(7) not null,
	ID_Carrera varchar(7) not null,
	CONSTRAINT fk_No_CtaE 
        FOREIGN KEY (No_CuentaE) 
        REFERENCES ESTUDIANTES(No_CuentaE)

); 

CREATE TABLE ESTUDIANTES(
    No_CuentaE varchar(7) NOT NULL,
    Nombres varchar(17) NOT NULL,
    P_Apellido varchar(15) NOT NULL,
    S_Apellido varchar(15) NOT NULL,
    Semestre int,
    Grupo varchar(1) NOT NULL,
    ID_Movilidad varchar(7) NOT NULL,
    ID_Carrera varchar(7) NOT NULL,

    CONSTRAINT fk_ID_Carrera 
        FOREIGN KEY (ID_Carrera) 
        REFERENCES CARRERA(ID_Carrera),

    CONSTRAINT fk_ID_Movilidad
        FOREIGN KEY (ID_Movilidad) 
        REFERENCES MOVILIDAD(ID_Movilidad)
);




---
Create Database Movilidad_E3_F

Use Movilidad_E3_F;

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
	ID_FacultadC varchar(7) not null,
	CONSTRAINT fk_ID_FacultadC 
        FOREIGN KEY (ID_FacultadC) 
        REFERENCES FACULTAD(ID_Facultad)
);

Create Table MATERIA(
	ID_Materia varchar(7) primary key not null,
	NombreM varchar(40) not null,
	T_Materia varchar(40) not null,
	ID_CarreraM varchar(7) not null,
	CONSTRAINT fk_ID_CarreraM 
        FOREIGN KEY (ID_CarreraM) 
        REFERENCES CARRERA(ID_Carrera)
);

Create Table DOCENTES(
	No_CuentaDocente varchar(7) Primary key not null,
	NombresD varchar(17) not null,
	P_ApellidoD varchar(15) not null,
	S_ApellidoD varchar(15) not null,
	ID_CarreraD varchar(7) not null,
	CONSTRAINT fk_ID_CarreraD 
        FOREIGN KEY (ID_CarreraD) 
        REFERENCES CARRERA(ID_Carrera)

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
    No_CuentaEstuudiante varchar(7) NOT NULL,
    NombresE varchar(17) NOT NULL,
    P_ApellidoE varchar(15) NOT NULL,
    S_ApellidoE varchar(15) NOT NULL,
    Semestre int,
    Grupo varchar(1) NOT NULL,
    ID_CarreraE varchar(7) NOT NULL,

    CONSTRAINT fk_ID_CarreraE 
        FOREIGN KEY (ID_CarreraE) 
        REFERENCES CARRERA(ID_Carrera)
);

CREATE TABLE MOVILIDAD (
    ID_Movilidad varchar(7) PRIMARY KEY NOT NULL,
    Ciclo_Escolar varchar(10) NOT NULL,
    Analisis_Movilidad int,
    No_UniversidadM varchar(7) NOT NULL,
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
        REFERENCES DOCENTES(No_CuentaDocente)
    
    
);

Drop Table ESTUDIANTES;


Create Table ESTUDIANTE_MOVILIDAD(
	No_CuentaEstuudianteEM varchar(7) not null,
	ID_MovilidadEM varchar(7) not null,
	CONSTRAINT pk_ESTUDIANTE_MOVILIDAD PRIMARY KEY (No_CuentaEstuudianteEM, ID_MovilidadEM),
	
        CONSTRAINT fk_No_CuentaEstuudianteEM 
        FOREIGN KEY (No_CuentaEstuudianteEM) 
        REFERENCES ESTUDIANTES(No_CuentaEstuudiante),
	
        CONSTRAINT fk_ID_MovilidadEM
        FOREIGN KEY (ID_MovilidadEM) 
        REFERENCES MOVILIDAD(ID_Movilidad)

);

Create Table MATERIAESTUDIANTE(
	No_CuentaEstuudianteMA varchar(7) not null,
	ID_MateriaMA varchar(7) not null,
	CONSTRAINT pk_MATERIAESTUDIANTE PRIMARY KEY (No_CuentaEstuudianteMA, ID_MateriaMA),
	CONSTRAINT fk_No_CuentaEstuudianteMA 
        FOREIGN KEY (No_CuentaEstuudianteMA) 
        REFERENCES ESTUDIANTES(No_CuentaEstuudiante),
	CONSTRAINT fk_ID_MateriaMA
        FOREIGN KEY (ID_MateriaMA) 
        REFERENCES MATERIA(ID_Materia)

);


INSERT INTO UNIVERSIDAD (No_Universidad, NombreU, Estado, Pais)
VALUES 
('UNI001', 'Universidad de Colima', 'Colima', 'México'),
('UNI002', 'Instituto Tecnológico de Monterrey', 'Nuevo León', 'México'),
('UNI003', 'University of Texas at Austin', 'Texas', 'Estados Unidos'),
('UNI004', 'Universidad de Buenos Aires', 'Buenos Aires', 'Argentina'),
('UNI005', 'Universidad Complutense de Madrid', 'Madrid', 'España');

select * from UNIVERSIDAD;


INSERT INTO FACULTAD (ID_Facultad, NombreF, No_Universidad)
VALUES 
('FAC0001', 'Facultad de Ingeniería Mecanica Electrica', 'UNI0001'),
('FAC0002', 'Facultad de Arquitectura y Diseño', 'UNI0001'),
('FAC0003', 'Facultad de Ciencias Químicas', 'UNI0001'),

('FAC0004', 'Facultad de Ingeniería Sistemas Electricos', 'UNI0002'),
('FAC0005', 'Facultad de Química', 'UNI0002'),

('FAC0006', 'Facultad de Mecatronica', 'UNI0003'),
('FAC0007', 'Facultad de Diseño', 'UNI0003'),

('FAC0008', 'Facultad de Arquitectura', 'UNI0004'),
('FAC0009', 'Facultad de Ciencias Químicas', 'UNI0004'),

('FAC0010', 'Facultad de Telematica', 'UNI0005'),
('FAC0011', 'Facultad de Arquitectura y Diseño', 'UNI0005');


select * from FACULTAD;


INSERT INTO CARRERA (ID_Carrera, NombreC, ID_FacultadC)
VALUES 
('CAR0001', 'Ingeniería en Computación', 'FAC0001'),
('CAR0002', 'Ingeniería Mecánica', 'FAC0001'),
('CAR0003', 'Ingenieria Mecatronica', 'FAC0001'),

('CAR0004', 'Ingenieria Arquitectura', 'FAC0002'),
('CAR0005', 'Ingenieria en Diseño Grafico', 'FAC0002'),

('CAR0006', 'Ingeniería en Quimica Biologa', 'FAC0003'),
('CAR0007', 'Ingeniería en Quimica de Alimentos', 'FAC0003'),

('CAR0008', 'Ingeniería en Computación', 'FAC0004'),
('CAR0009', 'Ingeniería Mecánica', 'FAC0004'),

('CAR0010', 'Ingeniería en Quimica Biologa', 'FAC0005'),
('CAR0011', 'Ingeniería en Metalurgica', 'FAC0005'),

('CAR0012', 'Ingenieria Mecatronica', 'FAC0006'),
('CAR0013', 'Ingenieria en Informatica', 'FAC0006'),

('CAR0014', 'Ingenieria en Diseño Grafico', 'FAC0007'),
('CAR0015', 'Ingenieria en Diseño Industrial', 'FAC0007'),

('CAR0016', 'Ingenieria Arquitectura', 'FAC0008'),
('CAR0017', 'Ingeniería Topologia', 'FAC0008'),

('CAR0018', 'Ingeniería en Metalurgica', 'FAC0009'),
('CAR0019', 'Ingeniería en Quimica Biologa', 'FAC0009'),

('CAR0020', 'Ingeniería en Computación', 'FAC0010'),
('CAR0021', 'Ingeniería Mecánica', 'FAC0010'),

('CAR0022', 'Ingenieria Arquitectura', 'FAC0011'),
('CAR0023', 'Ingenieria en Diseño Grafico', 'FAC0011');

SELECT * FROM CARRERA;


INSERT INTO MATERIA (ID_Materia, NombreM, T_Materia, ID_CarreraM)
VALUES 
-- CAR0001: Ingeniería en Computación
('MAT0001', 'Programación Estructurada', 'Programación', 'CAR0001'),
('MAT0002', 'Bases de Datos', 'Sistemas de Información', 'CAR0001'),

('MAT0003', 'Termodinámica', 'Física Aplicada', 'CAR0002'),
('MAT0004', 'Mecánica de Fluidos', 'Diseño Mecánico', 'CAR0002'),

('MAT0005', 'Robótica Industrial', 'Automatización', 'CAR0003'),
('MAT0006', 'Microcontroladores', 'Sistemas Embebidos', 'CAR0003'),

('MAT0007', 'Diseño Arquitectónico', 'Construcción', 'CAR0004'),
('MAT0008', 'Estructuras de Concreto', 'Cálculo Civil', 'CAR0004'),

('MAT0009', 'Ilustración Digital', 'Diseño Visual', 'CAR0005'),
('MAT0010', 'Tipografía', 'Comunicación Visual', 'CAR0005'),

('MAT0011', 'Bioquímica', 'Química Orgánica', 'CAR0006'),
('MAT0012', 'Microbiología', 'Biología Celular', 'CAR0006'),

('MAT0013', 'Análisis de Alimentos', 'Control de Calidad', 'CAR0007'),
('MAT0014', 'Procesos Alimentarios', 'Industrial', 'CAR0007'),

('MAT0015', 'Programación Estructurada', 'Programación', 'CAR0008'),
('MAT0016', 'Bases de Datos', 'Sistemas de Información', 'CAR0008'),

('MAT0017', 'Termodinámica', 'Física Aplicada', 'CAR0009'),
('MAT0018', 'Mecánica de Fluidos', 'Diseño Mecánico', 'CAR0009'),

('MAT0019', 'Bioquímica', 'Química Orgánica', 'CAR0010'),
('MAT0020', 'Microbiología', 'Biología Celular', 'CAR0010'),

('MAT0021', 'Fundición de Metales', 'Siderurgia', 'CAR0011'),
('MAT0022', 'Ciencia de Materiales', 'Propiedades Físicas', 'CAR0011'),

('MAT0023', 'Robótica Industrial', 'Automatización', 'CAR0012'),
('MAT0024', 'Microcontroladores', 'Sistemas Embebidos', 'CAR0012'),

('MAT0025', 'Redes de Computadoras', 'Telecomunicaciones', 'CAR0013'),
('MAT0026', 'Desarrollo Web', 'Programación', 'CAR0013'),

('MAT0027', 'Ilustración Digital', 'Diseño Visual', 'CAR0014'),
('MAT0028', 'Tipografía', 'Comunicación Visual', 'CAR0014'),

('MAT0029', 'Modelado 3D', 'Manufactura', 'CAR0015'),
('MAT0030', 'Ergonomía', 'Diseño de Productos', 'CAR0015'),

('MAT0031', 'Diseño Arquitectónico', 'Construcción', 'CAR0016'),
('MAT0032', 'Estructuras de Concreto', 'Cálculo Civil', 'CAR0016'),

('MAT0033', 'Cartografía', 'Geodesia', 'CAR0017'),
('MAT0034', 'Altimetría', 'Levantamiento', 'CAR0017'),

('MAT0035', 'Fundición de Metales', 'Siderurgia', 'CAR0018'),
('MAT0036', 'Ciencia de Materiales', 'Propiedades Físicas', 'CAR0018'),

('MAT0037', 'Bioquímica', 'Química Orgánica', 'CAR0019'),
('MAT0038', 'Microbiología', 'Biología Celular', 'CAR0019'),

('MAT0039', 'Programación Estructurada', 'Programación', 'CAR0020'),
('MAT0040', 'Bases de Datos', 'Sistemas de Información', 'CAR0020'),

('MAT0041', 'Termodinámica', 'Física Aplicada', 'CAR0021'),
('MAT0042', 'Mecánica de Fluidos', 'Diseño Mecánico', 'CAR0021'),

('MAT0043', 'Diseño Arquitectónico', 'Construcción', 'CAR0022'),
('MAT0044', 'Estructuras de Concreto', 'Cálculo Civil', 'CAR0022'),

('MAT0045', 'Ilustración Digital', 'Diseño Visual', 'CAR0023'),
('MAT0046', 'Tipografía', 'Comunicación Visual', 'CAR0023');

select * from MATERIA;


INSERT INTO DOCENTES (No_CuentaDocente, NombresD, P_ApellidoD, S_ApellidoD, ID_CarreraD)
VALUES 
('DOC0001', 'Carlos', 'Pérez', 'Gómez', 'CAR0001'),
('DOC0002', 'Ana', 'Martínez', 'López', 'CAR0001'),
('DOC0003', 'Luis', 'Rodríguez', 'Rubio', 'CAR0002'),
('DOC0004', 'Jorge', 'Hernández', 'Díaz', 'CAR0003'),
('DOC0007', 'Roberto', 'Gómez', 'Marín', 'CAR0004'),
('DOC0008', 'Laura', 'Vargas', 'Sanz', 'CAR0005'),
('DOC0009', 'Ricardo', 'Castro', 'Peña', 'CAR0006'),
('DOC0010', 'Patricia', 'Flores', 'Ríos', 'CAR0007'),
('DOC0005', 'Elena', 'Sánchez', 'Cruz', 'CAR0008'),
('DOC0011', 'Fernando', 'Morales', 'Solís', 'CAR0009'),
('DOC0012', 'Marta', 'Herrera', 'Mora', 'CAR0010'),
('DOC0013', 'Gabriel', 'Medina', 'Navarro', 'CAR0011'),
('DOC0014', 'Silvia', 'Delgado', 'Méndez', 'CAR0012'),
('DOC0006', 'Sofía', 'Ramírez', 'Torres', 'CAR0013'),
('DOC0015', 'Hugo', 'Benítez', 'Cortés', 'CAR0014'),
('DOC0016', 'Beatriz', 'Ruiz', 'Espinoza', 'CAR0015'),
('DOC0017', 'Manuel', 'Rubio', 'Campos', 'CAR0016'),
('DOC0018', 'Isabel', 'Ochoa', 'Lara', 'CAR0017'),
('DOC0019', 'Andrés', 'Soto', 'Villalba', 'CAR0018'),
('DOC0020', 'Clara', 'Valdez', 'Ortega', 'CAR0019'),
('DOC0021', 'Javier', 'Luna', 'Guerra', 'CAR0020'),
('DOC0022', 'Lucía', 'Ramos', 'Palacios', 'CAR0021'),
('DOC0023', 'Tomás', 'Cervantes', 'Acosta', 'CAR0022'),
('DOC0024', 'Gloria', 'Serrano', 'Maldonado', 'CAR0023');

select * from DOCENTES;

INSERT INTO MATERIA_DOCENTE (No_CuentaDocenteMD, ID_MateriaMD)
VALUES 
('DOC0001', 'MAT0001'), 
('DOC0001', 'MAT0002'), 

('DOC0002', 'MAT0001'), 
('DOC0003', 'MAT0003'),
('DOC0003', 'MAT0004'), 

('DOC0004', 'MAT0005'), 
('DOC0004', 'MAT0006'), 

('DOC0007', 'MAT0007'), ('DOC0007', 'MAT0008'),

('DOC0008', 'MAT0009'), ('DOC0008', 'MAT0010'),

('DOC0009', 'MAT0011'), ('DOC0009', 'MAT0012'),

('DOC0010', 'MAT0013'), ('DOC0010', 'MAT0014'),

('DOC0005', 'MAT0015'), 
('DOC0005', 'MAT0016'),

('DOC0011', 'MAT0017'), ('DOC0011', 'MAT0018'),

('DOC0012', 'MAT0019'), ('DOC0012', 'MAT0020'),

('DOC0013', 'MAT0021'), ('DOC0013', 'MAT0022'),

('DOC0014', 'MAT0023'), ('DOC0014', 'MAT0024'),

('DOC0006', 'MAT0025');
('DOC0006', 'MAT0026'); 

('DOC0015', 'MAT0027'), ('DOC0015', 'MAT0028'),

('DOC0016', 'MAT0029'), ('DOC0016', 'MAT0030'),

('DOC0017', 'MAT0031'), ('DOC0017', 'MAT0032'),

('DOC0018', 'MAT0033'), ('DOC0018', 'MAT0034'),

('DOC0019', 'MAT0035'), ('DOC0019', 'MAT0036'),

('DOC0020', 'MAT0037'), ('DOC0020', 'MAT0038'),

('DOC0021', 'MAT0039'), ('DOC0021', 'MAT0040'),

('DOC0022', 'MAT0041'), ('DOC0022', 'MAT0042'),

('DOC0023', 'MAT0043'), ('DOC0023', 'MAT0044'),

('DOC0024', 'MAT0045'), ('DOC0024', 'MAT0046');

select * from MATERIA_DOCENTE;

INSERT INTO ESTUDIANTES (No_CuentaEstuudiante, NombresE, P_ApellidoE, S_ApellidoE, Semestre, Grupo, ID_CarreraE)
VALUES 

('EST0070', 'Luis', 'Pérez', 'Pérez', 6, 'A', 'CAR0001'),
('EST0071', 'María', 'Rodríguez', 'Pérez', 6, 'A', 'CAR0002'),  

('EST0001', 'Juan', 'Pérez', 'García', 1, 'A', 'CAR0001'),
('EST0002', 'María', 'López', 'Martínez', 3, 'B', 'CAR0001'),
('EST0003', 'Luis', 'Rodríguez', 'Sánchez', 6, 'A', 'CAR0001'), 

('EST0004', 'Pedro', 'Ramírez', 'Gómez', 2, 'A', 'CAR0002'),
('EST0005', 'Ana', 'Fernández', 'Díaz', 4, 'A', 'CAR0002'),
('EST0006', 'Carlos', 'González', 'Cruz', 8, 'B', 'CAR0002'),

('EST0007', 'Sofía', 'Álvarez', 'Torres', 1, 'A', 'CAR0003'),
('EST0008', 'Diego', 'Hernández', 'Ruiz', 5, 'A', 'CAR0003'),
('EST0009', 'Laura', 'Jiménez', 'Morales', 7, 'B', 'CAR0003'),

('EST0010', 'Miguel', 'Moreno', 'Muñoz', 3, 'A', 'CAR0004'),
('EST0011', 'Elena', 'Romero', 'Alonso', 2, 'B', 'CAR0004'),
('EST0012', 'David', 'Gutiérrez', 'Navarro', 4, 'A', 'CAR0004'),

('EST0013', 'Isabel', 'Navarro', 'Solís', 5, 'A', 'CAR0005'),
('EST0014', 'Alejandro', 'Domínguez', 'Vidal', 1, 'B', 'CAR0005'),
('EST0015', 'Cristina', 'Vázquez', 'Castro', 3, 'A', 'CAR0005'),

('EST0016', 'Antonio', 'Blanco', 'Molina', 2, 'A', 'CAR0006'),
('EST0017', 'Silvia', 'Morales', 'Delgado', 6, 'A', 'CAR0006'), 
('EST0018', 'Manuel', 'Ortiz', 'Marín', 8, 'B', 'CAR0006'),

('EST0019', 'Patricia', 'Delgado', 'Ortiz', 4, 'A', 'CAR0007'),
('EST0020', 'Roberto', 'Marín', 'Blanco', 2, 'B', 'CAR0007'),
('EST0021', 'Alicia', 'Castro', 'Vázquez', 7, 'A', 'CAR0007'),

('EST0022', 'Fernando', 'Soto', 'Medina', 1, 'A', 'CAR0008'),
('EST0023', 'Marta', 'Herrera', 'Flores', 3, 'B', 'CAR0008'),
('EST0024', 'Gabriel', 'Vargas', 'Gómez', 5, 'A', 'CAR0008'),

('EST0025', 'Hugo', 'Benítez', 'Ríos', 2, 'A', 'CAR0009'),
('EST0026', 'Beatriz', 'Ruiz', 'Sanz', 4, 'A', 'CAR0009'),
('EST0027', 'Andrés', 'Corona', 'Peña', 8, 'B', 'CAR0009'),

('EST0028', 'Clara', 'Valdez', 'Mora', 3, 'A', 'CAR0010'),
('EST0029', 'Javier', 'Luna', 'Solís', 1, 'B', 'CAR0010'),
('EST0030', 'Lucía', 'Ramos', 'Cortés', 5, 'A', 'CAR0010'),

('EST0031', 'Tomás', 'Acosta', 'Lara', 2, 'A', 'CAR0011'),
('EST0032', 'Gloria', 'Serrano', 'Ochoa', 4, 'A', 'CAR0011'),
('EST0033', 'Oscar', 'Preciado', 'Raya', 6, 'B', 'CAR0011'), 

('EST0034', 'Héctor', 'Chávez', 'Campos', 7, 'A', 'CAR0012'),
('EST0035', 'Diana', 'Méndez', 'Rubio', 1, 'B', 'CAR0012'),
('EST0036', 'Rubén', 'Espinoza', 'Soto', 3, 'A', 'CAR0012'),

('EST0037', 'Cesar', 'Aguilar', 'Valdez', 5, 'A', 'CAR0013'),
('EST0038', 'Lorena', 'Miranda', 'Luna', 2, 'B', 'CAR0013'),
('EST0039', 'Mario', 'Ríos', 'Ramos', 4, 'A', 'CAR0013'),

('EST0040', 'Verónica', 'Cárdenas', 'Acosta', 1, 'A', 'CAR0014'),
('EST0041', 'Ricardo', 'Puga', 'Serrano', 8, 'B', 'CAR0014'),
('EST0042', 'Natalia', 'Meza', 'Chávez', 3, 'A', 'CAR0014'),

('EST0043', 'Francisco', 'Gaitán', 'Méndez', 2, 'A', 'CAR0015'),
('EST0044', 'Guadalupe', 'Mora', 'Espinoza', 6, 'A', 'CAR0015'), 
('EST0045', 'Arturo', 'Zúñiga', 'Aguilar', 7, 'B', 'CAR0015'),

('EST0046', 'Adriana', 'Raya', 'Miranda', 4, 'A', 'CAR0016'),
('EST0047', 'Enrique', 'Sánchez', 'Ríos', 1, 'B', 'CAR0016'),
('EST0048', 'Rocío', 'Gómez', 'Cárdenas', 5, 'A', 'CAR0016'),

('EST0049', 'Paola', 'López', 'Puga', 2, 'A', 'CAR0017'),
('EST0050', 'Fabián', 'Martínez', 'Meza', 3, 'A', 'CAR0017'),
('EST0051', 'Karla', 'Rodríguez', 'Gaitán', 8, 'B', 'CAR0017'),

('EST0052', 'Saúl', 'Ramírez', 'Mora', 1, 'A', 'CAR0018'),
('EST0053', 'Julia', 'Fernández', 'Zúñiga', 4, 'B', 'CAR0018'),
('EST0054', 'Omar', 'González', 'Sánchez', 5, 'A', 'CAR0018'),

('EST0055', 'Raúl', 'Álvarez', 'López', 3, 'A', 'CAR0019'),
('EST0056', 'Vanessa', 'Hernández', 'Martínez', 2, 'B', 'CAR0019'),
('EST0057', 'Yolanda', 'Jiménez', 'Rodríguez', 7, 'A', 'CAR0019'),

('EST0058', 'Manuel', 'Moreno', 'Ramírez', 6, 'A', 'CAR0020'), 
('EST0059', 'Teresa', 'Romero', 'Fernández', 1, 'B', 'CAR0020'),
('EST0060', 'Irma', 'Gutiérrez', 'González', 4, 'A', 'CAR0020'),

('EST0061', 'Felipe', 'Navarro', 'Álvarez', 2, 'A', 'CAR0021'),
('EST0062', 'Mónica', 'Domínguez', 'Hernández', 5, 'A', 'CAR0021'),
('EST0063', 'Sonia', 'Vázquez', 'Jiménez', 8, 'B', 'CAR0021'),

('EST0064', 'Gustavo', 'Blanco', 'Moreno', 3, 'A', 'CAR0022'),
('EST0065', 'Rosa', 'Morales', 'Romero', 1, 'B', 'CAR0022'),
('EST0066', 'Félix', 'Ortiz', 'Gutiérrez', 7, 'A', 'CAR0022'),

('EST0067', 'Armando', 'Delgado', 'Navarro', 4, 'A', 'CAR0023'),
('EST0068', 'Miriam', 'Marín', 'Domínguez', 2, 'B', 'CAR0023'),
('EST0069', 'Joel', 'Castro', 'Vázquez', 5, 'A', 'CAR0023');

select * from ESTUDIANTES;

INSERT INTO MOVILIDAD (ID_Movilidad, Ciclo_Escolar, Analisis_Movilidad, No_UniversidadM, ID_CarreraMo, No_CuentaDocenteMo)
VALUES 
('MOV0001', '2025-2', 1, 'UNI004', 'CAR0016', 'DOC0007'),

('MOV0002', '2026-1', 2, 'UNI003', 'CAR0006', 'DOC0004'),

('MOV0003', '2026-1', 1, 'UNI005', 'CAR0021', 'DOC0022'),

('MOV0004', '2026-1', 1, 'UNI005', 'CAR0020', 'DOC0021'),

('MOV0005', '2026-1', 1, 'UNI005', 'CAR0020', 'DOC0021');

Select * from MOVILIDAD;

INSERT INTO ESTUDIANTE_MOVILIDAD (No_CuentaEstuudianteEM, ID_MovilidadEM)
VALUES 
('EST0012', 'MOV0001'),

('EST0030', 'MOV0002'),

('EST0006', 'MOV0003'),

('EST0070', 'MOV0004'),

('EST0071', 'MOV0005');

select * from ESTUDIANTE_MOVILIDAD;

INSERT INTO MATERIAESTUDIANTE (No_CuentaEstuudianteMA, ID_MateriaMA)
VALUES 
('EST0001', 'MAT0001'), ('EST0001', 'MAT0002'),
('EST0002', 'MAT0001'), ('EST0002', 'MAT0002'),
('EST0003', 'MAT0001'), ('EST0003', 'MAT0002'),
('EST0070', 'MAT0001'), ('EST0070', 'MAT0002'),
('EST0071', 'MAT0001'), ('EST0071', 'MAT0002'),

('EST0004', 'MAT0003'), ('EST0004', 'MAT0004'),
('EST0005', 'MAT0003'), ('EST0005', 'MAT0004'),
('EST0006', 'MAT0003'), ('EST0006', 'MAT0004'),

('EST0007', 'MAT0005'), ('EST0007', 'MAT0006'),
('EST0008', 'MAT0005'), ('EST0008', 'MAT0006'),
('EST0009', 'MAT0005'), ('EST0009', 'MAT0006'),

('EST0010', 'MAT0007'), ('EST0010', 'MAT0008'),
('EST0011', 'MAT0007'), ('EST0011', 'MAT0008'),
('EST0012', 'MAT0007'), ('EST0012', 'MAT0008'),

('EST0013', 'MAT0009'), ('EST0013', 'MAT0010'),
('EST0014', 'MAT0009'), ('EST0014', 'MAT0010'),
('EST0015', 'MAT0009'), ('EST0015', 'MAT0010'),

('EST0016', 'MAT0011'), ('EST0016', 'MAT0012'),
('EST0017', 'MAT0011'), ('EST0017', 'MAT0012'),
('EST0018', 'MAT0011'), ('EST0018', 'MAT0012'),

('EST0019', 'MAT0013'), ('EST0019', 'MAT0014'),
('EST0020', 'MAT0013'), ('EST0020', 'MAT0014'),
('EST0021', 'MAT0013'), ('EST0021', 'MAT0014'),

('EST0022', 'MAT0015'), ('EST0022', 'MAT0016'),
('EST0023', 'MAT0015'), ('EST0023', 'MAT0016'),
('EST0024', 'MAT0015'), ('EST0024', 'MAT0016'),

('EST0025', 'MAT0017'), ('EST0025', 'MAT0018'),
('EST0026', 'MAT0017'), ('EST0026', 'MAT0018'),
('EST0027', 'MAT0017'), ('EST0027', 'MAT0018'),

('EST0028', 'MAT0019'), ('EST0028', 'MAT0020'),
('EST0029', 'MAT0019'), ('EST0029', 'MAT0020'),
('EST0030', 'MAT0019'), ('EST0030', 'MAT0020'),

('EST0031', 'MAT0021'), ('EST0031', 'MAT0022'),
('EST0032', 'MAT0021'), ('EST0032', 'MAT0022'),
('EST0033', 'MAT0021'), ('EST0033', 'MAT0022'),

('EST0034', 'MAT0023'), ('EST0034', 'MAT0024'),
('EST0035', 'MAT0023'), ('EST0035', 'MAT0024'),
('EST0036', 'MAT0023'), ('EST0036', 'MAT0024'),

('EST0037', 'MAT0025'), ('EST0037', 'MAT0026'),
('EST0038', 'MAT0025'), ('EST0038', 'MAT0026'),
('EST0039', 'MAT0025'), ('EST0039', 'MAT0026'),

('EST0040', 'MAT0027'), ('EST0040', 'MAT0028'),
('EST0041', 'MAT0027'), ('EST0041', 'MAT0028'),
('EST0042', 'MAT0027'), ('EST0042', 'MAT0028'),

('EST0043', 'MAT0029'), ('EST0043', 'MAT0030'),
('EST0044', 'MAT0029'), ('EST0044', 'MAT0030'),
('EST0045', 'MAT0029'), ('EST0045', 'MAT0030'),

('EST0046', 'MAT0031'), ('EST0046', 'MAT0032'),
('EST0047', 'MAT0031'), ('EST0047', 'MAT0032'),
('EST0048', 'MAT0031'), ('EST0048', 'MAT0032'),

('EST0049', 'MAT0033'), ('EST0049', 'MAT0034'),
('EST0050', 'MAT0033'), ('EST0050', 'MAT0034'),
('EST0051', 'MAT0033'), ('EST0051', 'MAT0034'),

('EST0052', 'MAT0035'), ('EST0052', 'MAT0036'),
('EST0053', 'MAT0035'), ('EST0053', 'MAT0036'),
('EST0054', 'MAT0035'), ('EST0054', 'MAT0036'),

('EST0055', 'MAT0037'), ('EST0055', 'MAT0038'),
('EST0056', 'MAT0037'), ('EST0056', 'MAT0038'),
('EST0057', 'MAT0037'), ('EST0057', 'MAT0038'),

('EST0058', 'MAT0039'), ('EST0058', 'MAT0040'),
('EST0059', 'MAT0039'), ('EST0059', 'MAT0040'),
('EST0060', 'MAT0039'), ('EST0060', 'MAT0040'),

('EST0061', 'MAT0041'), ('EST0061', 'MAT0042'),
('EST0062', 'MAT0041'), ('EST0062', 'MAT0042'),
('EST0063', 'MAT0041'), ('EST0063', 'MAT0042'),

('EST0064', 'MAT0043'), ('EST0064', 'MAT0044'),
('EST0065', 'MAT0043'), ('EST0065', 'MAT0044'),
('EST0066', 'MAT0043'), ('EST0066', 'MAT0044'),

('EST0067', 'MAT0045'), ('EST0067', 'MAT0046'),
('EST0068', 'MAT0045'), ('EST0068', 'MAT0046'),
('EST0069', 'MAT0045'), ('EST0069', 'MAT0046');

select * from MATERIAESTUDIANTE;



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
    parcial_uno NUMERIC (2,1),
    parcial_dos NUMERIC (2,1),
    parcial_tres NUMERIC (2,1),
    Calificaciones NUMERIC (2,1),
    No_CuentaEstuudiante varchar(7) NOT NULL,
    ID_MateriaC varchar(7) not null, 

    FOREIGN KEY (No_CuentaEstuudiante) REFERENCES ESTUDIANTES(No_CuentaEstuudiante),
    FOREIGN KEY (ID_MateriaC) REFERENCES MATERIA(ID_Materia)
);

Drop table MATERIA_DOCENTE;

















