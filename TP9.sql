/*
table facture
table devis
table client


un client peut avoir plusieur factures et une facture n'appartient à un seul client
un devis peut inclure plusieurs facture et une facture appartien à un devis
*/


DROP DATABASE IF EXISTS crm;
CREATE DATABASE IF NOT EXISTS crm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE crm;

CREATE TABLE clients(
    noCli INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255),
    CONSTRAINT pk_client PRIMARY KEY(noCli)
);

CREATE TABLE projets(
    noProj INT NOT NULL AUTO_INCREMENT,
    noCli INT NOT NULL,
    nom VARCHAR(255),
    version INT NOT NULL DEFAULT 1,
    CONSTRAINT pk_projets PRIMARY KEY(noProj)
);



CREATE TABLE factures(
    noFact CHAR(6) NOT NULL,
    noDev CHAR(8) NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    dateFact DATE NOT NULL,
    datePaiement DATE,
    info VARCHAR(255),
    CONSTRAINT pk_factures PRIMARY KEY(noFact)
);

CREATE TABLE devis(
    noDev CHAR(8) NOT NULL,
    noProj INT NOT NULL,
    CONSTRAINT pk_devis PRIMARY KEY(noDev)
);

ALTER TABLE projets
ADD CONSTRAINT fk_projets_clients FOREIGN KEY (noCli) REFERENCES clients(noCli);

ALTER TABLE devis
ADD CONSTRAINT fk_devis_projet FOREIGN KEY (noProj) REFERENCES projets(noProj);

ALTER TABLE factures
ADD CONSTRAINT fk_factures_devis FOREIGN KEY (noDev) REFERENCES devis(noDev);

INSERT INTO clients
(nom) 
VALUES 
("Mairie de Rennes"),
("Neo Soft"),
("Sopra"),
("Accenture"),
("Amazon")

INSERT INTO projets
(noCli,nom,version) 
VALUES
(1,"Creation de site internet"),
(1,"Creation de site internet",2),
(2,"Logiciel CRM"),
(3,"Logiciel de devis"),
(4,"Site internet ecommerce"),
(2,"logiciel ERP"),
(5,"logiciel Gestion de Stock")

INSERT INTO devis
(noDev,noProj)
VALUES
("DEV2100A",1),
("DEV2100B",2),
("DEV2100C",3),
("DEV2100D",4),
("DEV2100E",5),
("DEV2100F",6),
("DEV2100G",7)

INSERT INTO factures
(noFact,noDev,montant,dateFact,datePaiemet,info)
VALUES
("FA001","DEV2100A",1500,)

CREATE TABLE factures(
    noFact CHAR(6) NOT NULL,
    noDev CHAR(8) NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    dateFact DATE NOT NULL,
    datePaiement DATE,
    info VARCHAR(255),
    CONSTRAINT pk_factures PRIMARY KEY(noFact)
);




