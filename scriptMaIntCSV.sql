LOAD DATA LOCAL INFILE 'C:/Users/Usuario/Downloads/MatriculadosInteresados.csv'
INTO TABLE MatriculadosInteresados
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n';