DROP DATABASE IF EXISTS netflix2;
CREATE DATABASE IF NOT EXISTS netflix2 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE netflix2;

CREATE TABLE films(
    id INT NOT NULL AUTO_INCREMENT,
    titre VARCHAR(255) NOT NULL,
    CONSTRAINT pk_films PRIMARY KEY (id)
);


CREATE TABLE acteurs(
    id INT NOT NULL AUTO_INCREMENT,
    prenom VARCHAR(255) NOT NULL,
    nom VARCHAR(255) NOT NULL,
    CONSTRAINT pk_acteurs PRIMARY KEY (id)
);

CREATE TABLE film_has_acteur(
    film_id INT NOT NULL,
    acteur_id INT NOT NULL,
    CONSTRAINT pk_film_has_acteur PRIMARY KEY(film_id,acteur_id)
);

ALTER TABLE film_has_acteur
ADD CONSTRAINT fk_film_has_acteur_films FOREIGN KEY(film_id) REFERENCES films(id);
ALTER TABLE film_has_acteur
ADD CONSTRAINT fk_film_has_acteur_acteurs FOREIGN KEY(acteur_id) REFERENCES acteurs(id);

INSERT INTO films
(titre) VALUES ("Fight Club"),("One Upon the time");

INSERT INTO acteurs
(prenom, nom) VALUES ("Brad","PITT"),("Léonardo","DICAPRIO");

INSERT INTO film_has_acteur
(film_id,acteur_id) VALUES (1,1),(2,1),(2,2);


SELECT
films.titre ,
acteurs.prenom,
acteurs.nom
FROM films
INNER JOIN film_has_acteur ON films.id = film_has_acteur.film_id
INNER JOIN acteurs ON film_has_acteur.acteur_id = acteurs.id 
WHERE acteurs.prenom = "Brad" ORDER BY films.titre DESC

SELECT
acteurs.prenom AS "acteur_prenom",
acteurs.nom AS "acteur_nom",
COUNT(films.id) AS "nb_film"
FROM acteurs
INNER JOIN film_has_acteur ON acteurs.id = film_has_acteur.acteur_id
INNER JOIN films ON film_has_acteur.film_id = films.id
GROUP BY acteurs.prenom ORDER BY acteurs.prenom DESC

SELECT films.titre AS "film"
FROM films
WHERE films.id NOT IN(
    SELECT film_has_acteur.film_id
    FROM film_has_acteur
);

