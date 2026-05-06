"C:\Program Files\MySQL\MySQL Workbench 8.0 CE\mysql.exe" -u root -p --local-infile=1
use nombreBD; 
set global local_infile=1;

LOAD DATA LOCAL INFILE 'C:/Users/Usuario/Downloads/Personas.csv'
INTO TABLE Personas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(ID_Persona, DNI, Nombre, Apellido, Genero, Dirección, Localidad, Provincia, CodPostal, Teléfono, EnParo, Canal, @fechaProvisional, Email)
SET
  FechaNac = IF(@fechaProvisional = '', NULL, STR_TO_DATE(@fechaProvisional, '%d/%m/%Y')),
  Teléfono = NULLIF(@Teléfono, ''),
  EnParo = NULLIF(@EnParo,''),
  Canal= NULLIF(@Canal,''),
  Email = REPLACE(
          REPLACE(
            REPLACE(
              REPLACE(
                REPLACE(
                  REPLACE(
                    REPLACE(
                      REPLACE(
                        REPLACE(
                          REPLACE(
                            REPLACE(@EmailOriginal, 'á', 'a'),
                          'é', 'e'),
                        'í', 'i'),
                      'ó', 'o'),
                    'ú', 'u'),
                  'Á', 'A'),
                'É', 'E'),
              'Í', 'I'),
            'Ó', 'O'),
          'Ú', 'U'),
        'ñ', 'n');