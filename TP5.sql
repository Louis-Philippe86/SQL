DROP DATABASE spa;
CREATE DATABASE IF NOT EXISTS spa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE spa;

CREATE TABLE chats(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    yeux_id INT,
    CONSTRAINT pk_chats PRIMARY KEY(id)
);

CREATE TABLE couleurs(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    CONSTRAINT pk_couleurs PRIMARY KEY(id)
);

ALTER TABLE chats
ADD CONSTRAINT fk_chats_couleur FOREIGN KEY(yeux_id) REFERENCES couleurs(id);


INSERT INTO couleurs
(nom) VALUES ('marron'),('bleu'),('vert');


INSERT INTO chats (nom,age,yeux_id) VALUES
('maine coon',20,1),
('siamois',15,2),
('bengal',18,1),
('scottish fold',10,1),
('domestique',21,null);


SELECT chats.nom AS "Nom", chats.age AS "Âge", couleurs.nom AS "Couleur des yeux"
FROM chats
INNER JOIN couleurs ON chats.yeux_id = couleurs.id;