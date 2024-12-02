SELECT MAX(salaire) as "salaire max" FROM inv_personne;
SELECT MIN(salaire) as "salaire min" FROM inv_personne;

SELECT nom,prenom,salaire FROM inv_personne  ORDER BY salaire ASC LIMIT 1;

SELECT nom,prenom,salaire FROM inv_personne  ORDER BY salaire DESC LIMIT 1;

SELECT SUM(salaire) / COUNT(salaire) as "Salaire moyen" FROM inv_personne;

SELECT COUNT(id) FROM inv_personne

SELECT * FROM inv_personne WHERE salaire BETWEEN 1000001 AND 3999999 ;

SELECT LOWER(nom) as 'Nom' , LOWER(prenom) as 'Prenom' FROM inv_personne

SELECT * FROM inv_personne WHERE prenom LIKE '%bra%'

SELECT * FROM inv_personne ORDER BY (age) ASC

SELECT COUNT(id) FROM inv_personne WHERE statut = "membre"

SELECT statut, COUNT(statut) as "nb_acteur" FROM inv_personne GROUP BY (statut)