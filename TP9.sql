


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
    p_version INT NOT NULL DEFAULT 1,
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
("Amazon");

INSERT INTO projets
(noCli,nom,p_version) 
VALUES
(1,"Creation de site internet",1),
(1,"Creation de site internet",2),
(2,"Logiciel CRM",1),
(3,"Logiciel de devis",1),
(4,"Site internet ecommerce",1),
(2,"logiciel ERP",1),
(5,"logiciel Gestion de Stock",1);

INSERT INTO devis
(noDev,noProj)
VALUES
("DEV2100A",1),
("DEV2100B",2),
("DEV2100C",3),
("DEV2100D",4),
("DEV2100E",5),
("DEV2100F",6),
("DEV2100G",7);

INSERT INTO factures
(noFact,noDev,montant,dateFact,datePaiement,info)
VALUES
("FA001", "DEV2100A", 1500.00, '2023-09-01', '2023-10-01', "Site internet partie 1"),
("FA002", "DEV2100A", 1500.00, '2023-09-20', NULL, "Site internet partie 2"),
("FA003", "DEV2100C", 5000.00, '2024-02-01', NULL, "Logiciel CRM"),
("FA004", "DEV2100D", 3000.00, '2024-03-03', '2024-04-03', "Logiciel devis"),
("FA005", "DEV2100E", 5000.00, '2023-03-01', NULL, "Site internet ecommerce"),
("FA006", "DEV2100F", 2000.00, '2023-03-01', NULL, "Logiciel ERP");


SELECT 
factures.noFact AS "ref",
clients.nom AS "nom",
factures.info AS "Info",
factures.montant AS "Total",
factures.dateFact AS "date",
factures.datePaiement AS "paiement"
FROM factures
JOIN devis USING (noDev)
JOIN projets USING (noProj)
JOIN clients USING (noCli)
ORDER BY factures.noFact ASC;

SELECT
    clients.nom AS "client",
    COUNT(factures.noFact) AS "nb_facture"
FROM clients
LEFT JOIN projets USING (noCli)
LEFT JOIN devis USING (noProj)
LEFT JOIN factures USING (noDEV)
GROUP BY clients.nom
ORDER BY nb_facture DESC;

SELECT 
clients.nom AS "client",
SUM(factures.montant) AS "total"
FROM clients
LEFT JOIN projets USING (noCli)
LEFT JOIN devis USING (noProj)
LEFT JOIN factures USING (noDEV)
GROUP BY clients.nom
ORDER BY SUM(factures.montant) DESC;


SELECT SUM(total) AS "somme"
FROM(
    SELECT factures.montant AS total
    FROM factures
    WHERE factures.datePaiement IS NULL
) total

SELECT 
factures.noFact AS "Facture",
(DATEDIFF(COALESCE(factures.datePaiement, CURDATE()),factures.dateFact)+1) 
AS "nb_jours"
FROM factures
WHERE factures.datePaiement IS NULL





