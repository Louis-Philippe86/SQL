DROP DATABASE IF EXISTS invitation;
CREATE DATABASE  invitation CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE invitation;

CREATE TABLE personne(
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(250) NOT NULL,
    prenom VARCHAR(250) NOT NULL,
    age INT NOT NULL,
    date_inscription DATE NOT NULL,
    etat TINYINT NOT NULL,
    statut ENUM("membre","non membre") NOT NULL,
    cv VARCHAR(255),
    salaire INT NOT NULL, 
    CONSTRAINT pk_personne PRIMARY KEY (id)   

)ENGINE=InnoDB;

ALTER TABLE personne
RENAME to inv_personne;

ALTER TABLE inv_personne
ALTER etat SET DEFAULT 1;


