CREATE DATABASE IF NOT EXISTS PracABD1;
USE PracABD1;


DROP TABLE IF exists MatriculadosInteresados CASCADE;
DROP TABLE IF exists Cursos CASCADE;
DROP TABLE IF exists Personas CASCADE;

-- Eliminar tablespaces (incluyendo los datafiles asociados)
DROP TABLESPACE TBLS_MatriculadosInteresados;
DROP TABLESPACE TBLS_Cursos;
DROP TABLESPACE TBLS_Personas;

-- Tablespace para la tabla Personas
CREATE TABLESPACE TBLS_Personas
ADD DATAFILE 'DF_Personas.ibd'
AUTOEXTEND_SIZE= 40M;

-- Tablespace para la tabla Cursos
CREATE TABLESPACE TBLS_Cursos
ADD DATAFILE 'DF_Cursos.ibd'
autoextend_size= 40M;

-- Tablespace para la tabla MatriculadosInteresados
CREATE TABLESPACE TBLS_MatriculadosInteresados
ADD DATAFILE 'DF_MatriculadosInteresados.ibd'
AUTOEXTEND_SIZE=40M;

-- Crear tabla Personas en TBLS_Personas
CREATE TABLE Personas (
    ID_Persona INT PRIMARY KEY UNIQUE NOT NULL,
	DNI CHAR(9) NOT NULL UNIQUE,
    Nombre VARCHAR(20) NOT NULL,
    Apellido VARCHAR(30) NOT NULL,
	Genero CHAR(1) CHECK (Genero IN ('H', 'M')),
    Dirección VARCHAR(60),
	Localidad VARCHAR(50),
	Provincia VARCHAR(30),
	CodPostal CHAR(9),
    Teléfono CHAR(9),
	EnParo CHAR(1) CHECK (EnParo IN ('0','1')),
	Canal CHAR(1) CHECK (Canal IN ('0','1', '2','3','4')),
	FechaNac DATE,
    Email VARCHAR(60)
)
TABLESPACE TBLS_Personas;

-- Crear tabla Cursos en TBLS_Cursos
CREATE TABLE Cursos (
    ID_Curso INT PRIMARY KEY UNIQUE NOT NULL,
    Nombre VARCHAR(15) NOT NULL UNIQUE,
    Area VARCHAR(30),
	Edicion INT NOT NULL CHECK (Edicion BETWEEN 2008 AND 2020)
)
TABLESPACE TBLS_Cursos;

-- Crear tabla MatriculadosInteresados en TBLS_MatriculadosInteresados
CREATE TABLE MatriculadosInteresados (
    ID_Persona INT,
    ID_Curso INT,
    Estado VARCHAR(50),
    Descripcion VARCHAR(500),
	PRIMARY KEY (ID_Curso,ID_Persona),
    CONSTRAINT FK_Personas FOREIGN KEY (ID_Persona)
        REFERENCES Personas(ID_Persona)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_Cursos FOREIGN KEY (ID_Curso)
        REFERENCES Cursos(ID_Curso)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
TABLESPACE TBLS_MatriculadosInteresados;

-- Personas: Clave primaria sobre PersonaID
ALTER TABLE Personas
ADD CONSTRAINT ID_Personas PRIMARY KEY (ID_Persona);

-- Cursos: Clave primaria sobre CursoID
ALTER TABLE Cursos
ADD CONSTRAINT ID_Cursos PRIMARY KEY (ID_Curso);

-- MatriculadosInteresados: Clave primaria compuesta
ALTER TABLE MatriculadosInteresados
ADD CONSTRAINT ID_MatriculadosInteresados PRIMARY KEY (ID_Persona, ID_Curso);


-- MatriculadosInteresados → Definir Clave foránea Personas
ALTER TABLE MatriculadosInteresados
ADD CONSTRAINT FK_Personas FOREIGN KEY (ID_Persona)
        REFERENCES Personas(ID_Persona)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

-- MatriculadosInteresados → Definir Clave Foránea Cursos
ALTER TABLE MatriculadosInteresados
ADD CONSTRAINT FK_Cursos FOREIGN KEY (ID_Curso)
        REFERENCES Cursos(ID_Curso)
        ON DELETE CASCADE
        ON UPDATE CASCADE;


-- Eliminar FK de CURSO
ALTER TABLE MatriculadosInteresados
DROP FOREIGN KEY FK_Cursos;

-- Eliminar FK de PERSONA
ALTER TABLE MatriculadosInteresados
DROP FOREIGN KEY FK_Personas;

-- Eliminar PK de Personas
ALTER TABLE Personas
DROP PRIMARY KEY;

-- Eliminar PK de Cursos
ALTER TABLE Cursos
DROP PRIMARY KEY;

-- Eliminar PK compuesta de MatriculadosInteresados
ALTER TABLE MatriculadosInteresados
DROP PRIMARY KEY;