DROP DATABASE IF EXISTS netflix;
CREATE DATABASE IF NOT EXISTS netflix CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE netflix;

CREATE TABLE films(
    id INT NOT NULL AUTO_INCREMENT,
    titre VARCHAR(255) NOT NULL,
    sortie DATE NOT NULL,
    categ_id INT NOT NULL,
    CONSTRAINT pk_films PRIMARY KEY(id)
);

CREATE TABLE categ(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    CONSTRAINT pk_categ PRIMARY KEY(id)
);

ALTER TABLE films
ADD CONSTRAINT fk_films_categ FOREIGN KEY(categ_id) REFERENCES categ(id);

INSERT INTO categ (nom) VALUES 
('Sciences Fiction'),
('Thriller');

INSERT INTO films (titre,sortie,categ_id) VALUES
('STAR WARS','1977/05/25',1),
('THE MATRIX','1999/06/23',1),
('PULP FICTION','1994/10/26',2);

SELECT films.titre AS "Titre", films.sortie AS "Date de sortie", categ.nom AS "categorie" 
FROM films
INNER JOIN categ ON films.categ_id = categ.id;
