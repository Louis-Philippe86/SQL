DROP DATABASE IF EXISTS ski;
CREATE DATABASE IF NOT EXISTS ski CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ski;

CREATE TABLE clients(
    noCli INT NOT NULL,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30),
    adresse VARCHAR(255),
    cpo VARCHAR(5) NOT NULL,
    ville VARCHAR(80) NOT NULL,
    CONSTRAINT pk_clients PRIMARY KEY(noCli)
);

CREATE TABLE fiches(
    noFic INT NOT NULL,
    noCli INT NOT NULL,
    dateCrea DATE NOT NULL,
    datePaiement DATE,
    etat ENUM('SO','EC','RE') NOT NULL,
    CONSTRAINT pk_fiches PRIMARY KEY(noFic)
);

CREATE TABLE lignesfic(
    noLig INT NOT NULL,
    noFic INT NOT NULL,
    refart CHAR(8) NOT NULL,
    depart DATE NOT NULL,
    retour DATE,
    CONSTRAINT pk_lignesfic PRIMARY KEY(noLig,noFic)
);

CREATE TABLE articles(
    refart CHAR(8) NOT NULL,
    designation VARCHAR(80) NOT NULL,
    codeGam CHAR(5),
    codeCate CHAR(5),
    CONSTRAINT pk_articles PRIMARY KEY(refart)
);

CREATE TABLE categories(
    codeCate CHAR(5) NOT NULL,
    libelle VARCHAR(30) NOT NULL,
    CONSTRAINT pk_categories PRIMARY KEY(codeCate)
);

CREATE TABLE gammes(
    codeGam CHAR(5) NOT NULL,
    libelle VARCHAR(45) NOT NULL,
    CONSTRAINT pk_gammes PRIMARY KEY(codeGam)
);

CREATE TABLE grilleTarifs(
    codeGam CHAR(5) NOT NULL,
    codeCate CHAR(5) NOT NULL,
    codeTarif CHAR(5),
    CONSTRAINT pk_grilleTarifs PRIMARY KEY(codeGam,codeCate)
);

CREATE TABLE tarifs(
    codeTarif CHAR(5) NOT NULL,
    libelle CHAR(30) NOT NULL,
    prixJour DECIMAL(5,0) NOT NULL,
    CONSTRAINT pk_tarifs PRIMARY KEY(codeTarif)
);

ALTER TABLE fiches
ADD CONSTRAINT fk_fiches_clients FOREIGN KEY (noCli) REFERENCES clients(noCli);

ALTER TABLE lignesfic
ADD CONSTRAINT fk_lignesfic_fiches FOREIGN KEY (noFic) REFERENCES fiches(noFic),
ADD CONSTRAINT fk_lignesfic_articles FOREIGN KEY (refart) REFERENCES articles(refart);

ALTER TABLE articles
ADD CONSTRAINT fk_articles_gammes FOREIGN KEY(codeGam) REFERENCES gammes(codeGam),
ADD CONSTRAINT fk_articles_categories FOREIGN KEY(codeCate) REFERENCES categories(codeCate);

ALTER TABLE grilleTarifs
ADD CONSTRAINT fk_grilleTarifs_gammes FOREIGN KEY(codeGam) REFERENCES gammes(codeGam),
ADD CONSTRAINT fk_grilleTarifs_categories FOREIGN KEY(codeCate) REFERENCES categories(codeCate),
ADD CONSTRAINT fk_grilleTarifs_tarifs FOREIGN KEY(codeTarif) REFERENCES tarifs(codeTarif);

SELECT *
FROM clients
WHERE nom LIKE 'D%'

SELECT nom,prenom
FROM clients

SELECT noFic,etat,nom,prenom
FROM fiches
INNER JOIN clients ON fiches.noCli = clients.noCli
WHERE clients.cpo LIKE '%44';

SELECT 
lignesfic.noFic AS "lignesfic",
clients.nom AS "Nom",
clients.prenom AS "Prenom",
lignesfic.refart AS "refart",
articles.designation AS "Designation",
lignesfic.depart AS "Depart",
lignesfic.retour AS "Retour",
tarifs.prixJour AS "prixJours",
(DATEDIFF(COALESCE(lignesfic.retour, CURDATE()),lignesfic.depart)+1)* tarifs.prixJour AS "montant"
FROM lignesfic 

INNER JOIN fiches ON lignesfic.noFic = fiches.noFic
INNER JOIN clients ON fiches.noCli = clients.noCli
INNER JOIN articles ON lignesfic.refart = articles.refart
INNER JOIN categories ON articles.codeCate = categories.codeCate
INNER JOIN grilleTarifs ON categories.codeCate = grilleTarifs.codeCate
INNER JOIN tarifs ON grilleTarifs.codeTarif = tarifs.codeTarif

WHERE lignesfic.noFic = "1002" AND tarifs.prixJour = 10;


SELECT 
gammes.libelle AS "Gamme",
SUM(tarifs.prixJour) / COUNT(grilleTarifs.codeGam) AS "Tarif journalier moyen"
FROM grilleTarifs
INNER JOIN tarifs ON grilleTarifs.codeTarif =  tarifs.codeTarif
INNER JOIN gammes ON grilleTarifs.codeGam = gammes.codeGam
GROUP BY grilleTarifs.codeGam


SELECT 
lignesfic.noFic AS "lignesfic",
clients.nom AS "Nom",
clients.prenom AS "Prenom",
lignesfic.refart AS "refart",
articles.designation AS "Designation",
lignesfic.depart AS "Depart",
lignesfic.retour AS "Retour",
tarifs.prixJour AS "prixJours",
(DATEDIFF(COALESCE(lignesfic.retour, CURDATE()),lignesfic.depart)+1)* tarifs.prixJour AS "montant",
SUM((DATEDIFF(COALESCE(lignesfic.retour, CURDATE()), lignesfic.depart) + 1) * tarifs.prixJour) 
OVER (PARTITION BY lignesfic.noFic) AS "Total"
FROM lignesfic 

INNER JOIN fiches ON lignesfic.noFic = fiches.noFic
INNER JOIN clients ON fiches.noCli = clients.noCli
INNER JOIN articles ON lignesfic.refart = articles.refart
INNER JOIN categories ON articles.codeCate = categories.codeCate
INNER JOIN grilleTarifs ON categories.codeCate = grilleTarifs.codeCate
INNER JOIN tarifs ON grilleTarifs.codeTarif = tarifs.codeTarif

WHERE lignesfic.noFic = "1002" AND tarifs.prixJour = 10


SELECT 
categories.libelle AS "Libellle",
gammes.libelle AS "libelle",
tarifs.libelle AS "libelle",
tarifs.prixJour AS "prixJour"
FROM grilleTarifs
INNER JOIN tarifs ON grilleTarifs.codeTarif = tarifs.codeTarif
INNER JOIN gammes ON grilleTarifs.codeGam = gammes.codeGam
INNER JOIN categories ON grilleTarifs.codeCate = categories.codeCate


SELECT 
articles.refart AS "refart",
articles.designation AS "Designation",
COUNT(lignesfic.refart) AS "nb de location"
FROM articles
INNER JOIN lignesfic ON articles.refart = lignesfic.refart
WHERE articles.designation = "Décathlon Apparition"
GROUP BY lignesfic.refart;

SELECT AVG(nb_lignes) AS "moyenne_lignes_par_fiche"
FROM (
    SELECT fiches.noFic, 
    COUNT(lignesfic.noFic) AS nb_lignes
    FROM lignesfic
    INNER JOIN fiches ON lignesfic.noFic = fiches.noFic
    GROUP BY fiches.noFic
)AS sous_requete;


SELECT 
categories.libelle AS "categories",
COUNT(lignesfic.noFic) AS "Total"
FROM lignesfic
INNER JOIN fiches ON lignesfic.noFic = fiches.noFic 
INNER JOIN articles ON lignesfic.refart = articles.refart 
INNER JOIN categories ON articles.codeCate = categories.codeCate 
WHERE 
categories.libelle = "Ski alpin" OR
categories.libelle = "Patinette" OR
categories.libelle = "Surf"
GROUP BY categories.libelle

